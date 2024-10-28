from flask import render_template, request, jsonify, session, redirect, url_for, current_app, abort, flash
from app import app
from flask_babel import _
from services.database import db
from app.models import APSState, OrderStatus, OrderOrigin
import os
from services.payment_service import payment_service
from app.errors import DatabaseError, PaymentError
import traceback
import asyncio
import time
from services.logging_service import logging_service
from datetime import datetime

@app.route('/')
def index():
    return render_template('home.html')


@app.route('/set_language/<lang>', methods=['POST'])
def set_language(lang):
    if lang in app.config['LANGUAGES']:
        session['language'] = lang
        print(f"Language set to: {lang}")  # Dodaj debugowanie
        return jsonify(success=True)
    return jsonify(success=False), 400


@app.route('/get_aps_state')
def get_aps_state():
    try:
        logging_service.debug("get_aps_state endpoint called")
        aps_id = app.config['APS_ID']
        state = db.get_aps_state(aps_id)
        logging_service.info(f"APS state retrieved: {state}")
        return jsonify({
            'state': state,
            'timestamp': datetime.now().isoformat()
        })
    except Exception as e:
        logging_service.error(f"Error in get_aps_state: {str(e)}")
        flash(str(e), 'error')
        return jsonify({
            'state': 'error',
            'timestamp': datetime.now().isoformat()
        })

@app.route('/create_order', methods=['POST'])
def create_order():
    aps_id = app.config['APS_ID']
    aps_state = db.get_aps_state(aps_id)
    if aps_state != APSState.ACTIVE.value:
        error_msg = app.config['APS_STATE_MESSAGES'].get(aps_state, _("Kiosk is not available"))
        return jsonify(success=False, error=error_msg)
    
    try:
        order_id = db.create_order(aps_id)
        return jsonify(success=True, order_id=order_id)
    except Exception as e:
        logging_service.error(f"Failed to create order: {str(e)}")
        error_msg = _('Failed to create order: {}').format(str(e))
        return jsonify(success=False, error=error_msg)

@app.route('/order/<int:order_id>')
def order(order_id):
    aps_id = app.config['APS_ID']
    menu = db.get_menu(aps_id)
    order_items = db.get_order_items(order_id)
    estimated_waiting_time = db.calculate_estimated_waiting_time(aps_id, order_id)
    return render_template('order.html', 
                           menu=menu, 
                           order_items=order_items, 
                           order_id=order_id,
                           estimated_waiting_time=estimated_waiting_time)

@app.route('/get_menu', methods=['GET'])
def get_menu():
    aps_id = app.config['APS_ID']
    menu = db.get_menu(aps_id)
    return jsonify(menu=menu)

@app.route('/add_to_order', methods=['POST'])
def add_to_order():
    order_id = request.json.get('order_id')
    item_id = request.json.get('item_id')
    quantity = request.json.get('quantity', 1)

    if not all([order_id, item_id]) or not isinstance(quantity, int) or quantity <= 0:
        flash(_('Invalid input data'), 'error')
        return jsonify(success=False)

    try:
        db.add_item_to_order(order_id, item_id, quantity)
        flash(_('Item added successfully'), 'success')
        return jsonify(success=True)
    except DatabaseError as e:
        flash(str(e), 'error')
        return jsonify(success=False)

@app.route('/remove_from_order', methods=['POST'])
def remove_from_order():
    order_id = request.json.get('order_id')
    item_id = request.json.get('item_id')
    quantity = request.json.get('quantity', 1)
    try:
        db.remove_item_from_order(order_id, item_id, quantity)
        return jsonify(success=True)
    except DatabaseError as e:
        return jsonify(error=str(e)), 500

@app.route('/get_order_summary', methods=['GET'])
def get_order_summary():
    order_id = request.args.get('order_id', type=int)
    try:
        summary = db.get_order_summary(order_id)
        return jsonify(summary=summary)
    except DatabaseError as e:
        return jsonify(error=str(e)), 500

@app.route('/get_order_total', methods=['GET'])
def get_order_total():
    order_id = request.args.get('order_id', type=int)
    aps_id = app.config['APS_ID']
    try:
        total = db.get_order_total(order_id, aps_id)
        return jsonify(total=total)
    except DatabaseError as e:
        return jsonify(error=str(e)), 500

@app.route('/get_available_items', methods=['GET'])
def get_available_items():
    aps_id = app.config['APS_ID']
    item_ids = request.args.getlist('item_ids', type=int)
    try:
        available_items = db.get_available_items(aps_id, item_ids)
        return jsonify(available_items=available_items)
    except DatabaseError as e:
        return jsonify(error=str(e)), 500

@app.route('/cancel_order', methods=['POST'])
def cancel_order():
    order_id = request.json.get('order_id')
    aps_id = app.config['APS_ID']
    # This is a placeholder. In a real scenario, you'd cancel the order in the database.
    success = True
    return jsonify(success=success)

@app.route('/add_item', methods=['POST'])
def add_item():
    order_id = request.json.get('order_id')
    item_id = request.json.get('item_id')
    quantity = request.json.get('quantity')
    aps_id = app.config['APS_ID']
    # This is a placeholder. In a real scenario, you'd add the item to the order in the database.
    success = True
    return jsonify(success=success)

@app.route('/remove_item', methods=['POST'])
def remove_item():
    order_id = request.json.get('order_id')
    item_id = request.json.get('item_id')
    aps_id = app.config['APS_ID']
    # This is a placeholder. In a real scenario, you'd remove the item from the order in the database.
    success = True
    return jsonify(success=success)

@app.route('/get_public_image_url', methods=['GET'])
def get_public_image_url():
    filename = request.args.get('filename')
    # This is a placeholder. In a real scenario, you'd generate this URL using Supabase.
    url = f"https://example.com/images/{filename}"
    return jsonify(url=url)

@app.route('/detect_inactivity', methods=['POST'])
def detect_inactivity():
    order_id = request.json.get('order_id')
    # This is a placeholder. In a real scenario, you'd cancel the order and perform any necessary cleanup.
    success = True
    return jsonify(success=success)

@app.route('/calculate_estimated_waiting_time', methods=['GET'])
def calculate_estimated_waiting_time():
    try:
        aps_id = app.config['APS_ID']
        order_id = request.args.get('order_id', type=int)  # order_id is optional
        
        waiting_time = db.calculate_estimated_waiting_time(aps_id, order_id)
        
        # Ensure waiting_time is a valid integer
        if waiting_time is None:
            waiting_time = 0
        
        return jsonify({
            'waiting_time': int(waiting_time),  # Convert to integer explicitly
            'timestamp': datetime.now().isoformat()
        })
    except Exception as e:
        logging_service.error(f"Error calculating estimated waiting time: {str(e)}")
        return jsonify({
            'waiting_time': 0,
            'error': str(e),
            'timestamp': datetime.now().isoformat()
        }), 500

@app.route('/init_payment', methods=['POST'])
def init_payment():
    order_id = request.json.get('order_id')
    amount = request.json.get('amount')
    try:
        result = payment_service.init_transaction(amount)
        return jsonify(success=True, result=result)
    except PaymentError as e:
        logging_service.error(f"Payment initialization failed: {str(e)}")
        return jsonify(success=False, error=str(e)), 500

@app.route('/process_payment', methods=['POST'])
def process_payment():
    order_id = request.json.get('order_id')
    amount = request.json.get('amount')
    try:
        result = payment_service.start_payment(amount)
        if result == "00":  # Assuming "00" means success
            db.update_order_status(order_id, OrderStatus.PAID.value)
            kds_number = db.generate_next_kds_order_number(app.config['APS_ID'])
            db.update_order_kds_number(order_id, kds_number)
            flash(_('Payment processed successfully'), 'success')
            return jsonify(success=True, kds_number=kds_number)
        else:
            flash(_('Payment failed'), 'error')
            return jsonify(success=False)
    except PaymentError as e:
        logging_service.error(f"Payment processing failed: {str(e)}")
        flash(str(e), 'error')
        return jsonify(success=False)

@app.route('/cancel_payment', methods=['POST'])
def cancel_payment():
    order_id = request.json.get('order_id')
    try:
        db.update_order_status(order_id, OrderStatus.CANCELED.value)
        return jsonify(success=True)
    except DatabaseError as e:
        logging_service.error(f"Payment cancellation failed: {str(e)}")
        return jsonify(success=False, error=str(e)), 500

@app.route('/update_order_status', methods=['POST'])
def update_order_status():
    order_id = request.json.get('order_id')
    new_status = request.json.get('status')
    # This is a placeholder. In a real scenario, you'd update the order status in the database.
    success = True
    return jsonify(success=success)

@app.route('/handle_payment_error', methods=['POST'])
def handle_payment_error():
    error_code = request.json.get('error_code')
    error_description = request.json.get('error_description')
    order_id = request.json.get('order_id')
    # This is a placeholder. In a real scenario, you'd handle the payment error and update the order status.
    success = True
    return jsonify(success=success, message="Payment error handled")

@app.route('/generate_unique_order_number', methods=['POST'])
def generate_unique_order_number():
    aps_id = app.config['APS_ID']
    order_number = db.generate_next_kds_order_number(aps_id)
    return jsonify(order_number=order_number)

@app.before_request
def before_request():
    if 'language' not in session:
        session['language'] = request.accept_languages.best_match(app.config['LANGUAGES'])

@app.route('/order/summary/<int:order_id>')
def order_summary(order_id):
    try:
        aps_id = app.config['APS_ID']
        order_details = db.get_order_details_with_items(order_id)
        suggested_products = db.get_suggested_products(aps_id, order_id)
        estimated_waiting_time = db.calculate_estimated_waiting_time(aps_id, order_id)
        return render_template('order_summary.html', 
                               order_details=order_details,
                               suggested_products=suggested_products,
                               order_id=order_id,
                               estimated_waiting_time=estimated_waiting_time)
    except Exception as e:
        logging_service.error(f"Error in order_summary: {str(e)}")
        return jsonify(error="An error occurred while processing your request"), 500

@app.route('/update_order_item', methods=['POST'])
def update_order_item():
    order_id = request.json.get('order_id')
    item_id = request.json.get('item_id')
    quantity = request.json.get('quantity')
    try:
        db.update_order_item(order_id, item_id, quantity)
        return jsonify(success=True)
    except DatabaseError as e:
        return jsonify(error=str(e)), 500

@app.route('/add_suggested_product', methods=['POST'])
def add_suggested_product():
    order_id = request.json.get('order_id')
    item_id = request.json.get('item_id')
    try:
        db.add_item_to_order(order_id, item_id, 1)
        return jsonify(success=True)
    except DatabaseError as e:
        return jsonify(error=str(e)), 500

@app.route('/payment/<int:order_id>')
def payment(order_id):
    order_details = db.get_order_details(order_id)
    return render_template('payment.html', 
                           order_details=order_details,
                           order_id=order_id)

@app.route('/order/confirmation/<int:kds_number>')
def order_confirmation(kds_number):
    aps_id = app.config['APS_ID']
    order_details = db.get_order_details_by_kds(aps_id, kds_number)
    estimated_waiting_time = db.calculate_estimated_waiting_time(aps_id, order_details['id'])
    return render_template('order_confirmation.html', 
                           order_details=order_details,
                           kds_number=kds_number,
                           estimated_waiting_time=estimated_waiting_time)

@app.errorhandler(Exception)
def handle_exception(e):
    logging_service.error(f'Unhandled exception: {str(e)}')
    logging_service.error(traceback.format_exc())
    flash(_('An unexpected error occurred'), 'error')
    return jsonify(success=False)

@app.route('/long_running_task')
async def long_running_task():
    def run_task():
        # Symulacja długotrwałego zadania
        time.sleep(5)
        return "Task completed"

    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(None, run_task)
    return result

@app.route('/example')
def example_route():
    try:
        # Some operation
        result = perform_operation()
        logging_service.info(f"Operation completed successfully: {result}")
        return jsonify(result=result)
    except Exception as e:
        logging_service.error(f"Error in example_route: {str(e)}")
        return jsonify(error="An error occurred"), 500

def perform_operation():
    # Simulating an operation
    logging_service.debug("Performing operation")
    # ... operation logic ...
    return "Operation result"

@app.route('/get_product_availability')
def get_product_availability():
    try:
        aps_id = app.config['APS_ID']
        snacks_available = db.check_category_availability(aps_id, 'snack')
        drinks_available = db.check_category_availability(aps_id, 'drink')
        coffee_available = db.check_category_availability(aps_id, 'coffee')
        
        return jsonify({
            'snacks_available': snacks_available,
            'drinks_available': drinks_available,
            'coffee_available': coffee_available
        })
    except Exception as e:
        logging_service.error(f"Error checking product availability: {str(e)}")
        return jsonify({
            'error': str(e)
        }), 500

