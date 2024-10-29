from flask import render_template, request, jsonify, session, redirect, url_for, current_app, abort, flash
import supabase
from app import app
from flask_babel import _
from kiosk_app.config import Config
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
    logging_service.info("Index route called (home.html)")
    return render_template('home.html')


@app.route('/set_language/<lang>', methods=['POST'])
def set_language(lang):
    logging_service.info(f"Setting language to: {lang}")
    if lang in app.config['LANGUAGES']:
        session['language'] = lang
        logging_service.info(f"Language set to: {lang}")
        return jsonify(success=True)
    return jsonify(success=False), 400


@app.route('/get_aps_state')
def get_aps_state():
    try:
        logging_service.info("get_aps_state endpoint called")
        aps_id = app.config['APS_ID']
        state = db.get_aps_state(aps_id)
        logging_service.info(f"APS state retrieved: {state}")
        return jsonify({
            'state': state,
            'timestamp': datetime.now().isoformat()
        })
    except Exception as e:
        logging_service.error(f"Error in get_aps_state: {str(e)}")
        return jsonify({
            'state': 'error',
            'error': _('Failed to get APS state. Please try again.'),
            'timestamp': datetime.now().isoformat()
        }), 500

@app.route('/create_order', methods=['POST'])
def create_order():
    aps_id = app.config['APS_ID']
    aps_state = db.get_aps_state(aps_id)
    logging_service.info(f"APS state retrieved: {aps_state}")
    if aps_state != APSState.ACTIVE.value:
        error_msg = app.config['APS_STATE_MESSAGES'].get(aps_state, _("Kiosk is not available"))
        logging_service.info(f"Error message: {error_msg}")
        return jsonify(success=False, error=error_msg)
    
    try:
        order = db.create_order(aps_id)  # Zwraca obiekt APSOrder
        logging_service.info(f"Order created: {order}")
        return jsonify(success=True, order_id=order.id)  # Zwracamy tylko ID zamówienia
    except Exception as e:
        logging_service.error(f"Failed to create order: {str(e)}")
        error_msg = _('Failed to create order. Please try again.')
        return jsonify(success=False, error=error_msg)

@app.route('/order/<int:order_id>')
def order(order_id):
    try:
        aps_id = app.config['APS_ID']
        
        try:
            order_status = db.get_order_status(order_id)
            logging_service.info(f"Order status: {order_status}")
            if order_status not in [OrderStatus.DURING_ORDERING.value]:
                flash(_("This order is no longer active"), "error")
                return redirect(url_for('index'))
        except DatabaseError:
            logging_service.error("Database error in order route: Order not found")
            flash(_("Order not found"), "error")
            return redirect(url_for('index'))
            
        menu_data = db.get_menu(aps_id)
        menu_items = menu_data.menu_items if menu_data else []
        logging_service.info(f"Menu items: {menu_items}")
        estimated_waiting_time = db.calculate_estimated_waiting_time(aps_id, order_id)
        logging_service.info(f"Estimated waiting time: {estimated_waiting_time}")
        
        return render_template('order.html', 
                           menu_items=menu_items,
                           order_id=order_id,
                           estimated_waiting_time=estimated_waiting_time)
    except Exception as e:
        logging_service.error(f"Error in order route: {str(e)}")
        flash(_("An error occurred while loading the order page"), "error")
        return redirect(url_for('index'))

@app.route('/get_menu', methods=['GET'])
def get_menu():
    aps_id = app.config['APS_ID']
    menu = db.get_menu(aps_id)
    logging_service.info(f"Menu: {menu}")
    return jsonify(menu=menu)

@app.route('/add_to_order', methods=['POST'])
def add_to_order():
    order_id = request.json.get('order_id')
    item_id = request.json.get('item_id')
    quantity = request.json.get('quantity', 1)
    logging_service.info(f"Adding to order: order_id={order_id}, item_id={item_id}, quantity={quantity}")

    if not all([order_id, item_id]) or not isinstance(quantity, int) or quantity <= 0:
        logging_service.error("Invalid input data")
        return jsonify(success=False, error=_('Invalid input data'))

    try:
        db.add_item_to_order(order_id, item_id, quantity)
        logging_service.info("Item added successfully")
        return jsonify(success=True, message=_('Item added successfully'))
    except DatabaseError as e:
        logging_service.error(f"Database error in add_to_order: {str(e)}")
        return jsonify(success=False, error=str(e))

@app.route('/remove_from_order', methods=['POST'])
def remove_from_order():
    order_id = request.json.get('order_id')
    item_id = request.json.get('item_id')
    quantity = request.json.get('quantity', 1)
    logging_service.info(f"Removing from order: order_id={order_id}, item_id={item_id}, quantity={quantity}")
    try:
        db.remove_item_from_order(order_id, item_id, quantity)
        logging_service.info("Item removed successfully")
        return jsonify(success=True)
    except DatabaseError as e:
        logging_service.error(f"Database error in remove_from_order: {str(e)}")
        return jsonify(error=str(e)), 500

@app.route('/get_order_summary', methods=['GET'])
def get_order_summary():
    order_id = request.args.get('order_id', type=int)
    try:
        summary = db.get_order_summary(order_id)
        logging_service.info(f"Order summary: {summary}")
        return jsonify(summary=summary)
    except DatabaseError as e:
        logging_service.error(f"Database error in get_order_summary: {str(e)}")
        return jsonify(error=str(e)), 500

@app.route('/get_order_total', methods=['GET'])
def get_order_total():
    order_id = request.args.get('order_id', type=int)
    aps_id = app.config['APS_ID']
    try:
        total = db.get_order_total(order_id, aps_id)
        logging_service.info(f"Order total: {total}")
        return jsonify(total=total)
    except DatabaseError as e:
        logging_service.error(f"Database error in get_order_total: {str(e)}")
        return jsonify(error=str(e)), 500

@app.route('/get_available_items', methods=['GET'])
def get_available_items():
    aps_id = app.config['APS_ID']
    item_ids = request.args.getlist('item_ids', type=int)
    try:
        available_items = db.get_available_items(aps_id, item_ids)
        logging_service.info(f"Available items: {available_items}")
        return jsonify(available_items=available_items)
    except DatabaseError as e:
        logging_service.error(f"Database error in get_available_items: {str(e)}")
        return jsonify(error=str(e)), 500

@app.route('/cancel_order', methods=['POST'])
def cancel_order():
    order_id = request.json.get('order_id')
    aps_id = app.config['APS_ID']
    logging_service.info(f"Cancelling order: order_id={order_id}")
    try:
        db.cancel_order(order_id)
        logging_service.info("Order cancelled successfully")
        return jsonify(success=True)
    except DatabaseError as e:
        logging_service.error(f"Database error in cancel_order: {str(e)}")
        return jsonify(error=str(e)), 500


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
            return jsonify(success=True, message=_('Payment processed successfully'), kds_number=kds_number)
        else:
            return jsonify(success=False, error=_('Payment failed'))
    except PaymentError as e:
        logging_service.error(f"Payment processing failed: {str(e)}")
        return jsonify(success=False, error=_('Payment processing failed. Please try again.'))

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

@app.errorhandler(404)
def not_found_error(error):
    return jsonify(error=_('Page not found')), 404

@app.errorhandler(500)
def internal_error(error):
    return jsonify(error=_('An unexpected error occurred. Please try again.')), 500

@app.errorhandler(Exception)
def handle_exception(e):
    logging_service.error(f'Unhandled exception: {str(e)}')
    logging_service.error(traceback.format_exc())
    return jsonify(success=False, error=_('An unexpected error occurred. Please try again.')), 500

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
    logging_service.info("Performing operation")
    # ... operation logic ...
    return "Operation result"

@app.route('/get_product_availability')
def get_product_availability():
    try:
        aps_id = app.config['APS_ID']
        snacks_available = db.check_category_availability(aps_id, 'snack')
        drinks_available = db.check_category_availability(aps_id, 'drink')
        coffee_available = db.check_category_availability(aps_id, 'coffee')
        
        if not any([snacks_available, drinks_available, coffee_available]):
            message = _("Sorry, all products are currently unavailable. Please try again later.")
        
        return jsonify({
            'snacks_available': snacks_available,
            'drinks_available': drinks_available,
            'coffee_available': coffee_available,
            'message': message if 'message' in locals() else None
        })
    except Exception as e:
        logging_service.error(f"Error checking product availability: {str(e)}")
        return jsonify({
            'error': _('Failed to check product availability. Please try again.')
        }), 500

@app.route('/get_public_image_url', methods=['GET'])
def get_public_image_url():
    try:
        filename = request.args.get('filename')
        # Konstruuj publiczny URL dla Supabase Storage
        # url = f"{Config.SUPABASE_URL}/storage/v1/object/public/images/{filename}"
        url = Config.get_central_client().storage.from_('images').get_public_url(filename)
        logging_service.info(f"Public image URL: {url}")
        return jsonify(url=url)
    except Exception as e:
        logging_service.error(f"Error in get_public_image_url: {str(e)}")
        return jsonify(error=str(e)), 500

