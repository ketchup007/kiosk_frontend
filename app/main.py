import os

# Dodaj tę linię na początku pliku
print(f"Current working directory: {os.getcwd()}")

from flask import Flask, render_template, request, jsonify, session, redirect, url_for
from flask_babel import Babel, _
from services.order_service import OrderService
from services.aps_service import ApsService
from services.menu_service import MenuService
from services.storage_service import StorageService
from services.payment_service import PaymentService
from dotenv import load_dotenv
import os

load_dotenv()

static_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'static')
app = Flask(__name__, static_folder=static_folder, template_folder='../templates')
app.secret_key = os.getenv("SECRET_KEY", "default_secret_key")

# Konfiguracja obsługiwanych języków
LANGUAGES = ['pl', 'en', 'uk']

# Funkcja selektora języka
def get_locale():
    lang = session.get('language', request.accept_languages.best_match(LANGUAGES))
    print(f"Current language: {lang}")  # Dodaj tę linię
    return lang

# Konfiguracja Flask-Babel
babel = Babel(app, locale_selector=get_locale)

# Konfiguracja domyślnego języka i katalogu tłumaczeń
app.config['BABEL_DEFAULT_LOCALE'] = 'pl'
app.config['BABEL_TRANSLATION_DIRECTORIES'] = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'translations')

@app.route('/')
def start_screen():
    current_lang = get_locale()
    print(f"Current language: {current_lang}")
    message = _('Dotknij ekranu, aby rozpocząć')
    print(f"Translated message: {message}")
    print(f"Available translations: {os.listdir(app.config['BABEL_TRANSLATION_DIRECTORIES'])}")
    
    aps_service = ApsService()
    aps_state = aps_service.get_aps_state(os.getenv("APS_ID"))
    additional_info = ""
    if aps_state != 'active':
        additional_info = _("Przepraszamy za niedogodności. Prosimy spróbować później.")
    return render_template('start_screen.html', aps_state=aps_state, additional_info=additional_info, message=message)

@app.route('/set_language/<lang>', methods=['POST'])
def set_language(lang):
    if lang in LANGUAGES:
        session['language'] = lang
        print(f"Language set to: {lang}")  # Dodaj tę linię
        return jsonify(success=True)
    return jsonify(success=False), 400

@app.route('/start_order', methods=['POST'])
def start_order():
    order_service = OrderService()
    aps_service = ApsService()
    
    if aps_service.get_aps_state(os.getenv("APS_ID")) == 'active':
        order_id = order_service.create_order(os.getenv("APS_ID"), 'kiosk')
        if order_id:
            session['order_id'] = order_id
            return jsonify(success=True)
    
    return jsonify(success=False, message=_("Nie można rozpocząć zamówienia. Spróbuj ponownie pźniej."))

@app.route('/order')
def order_page():
    if 'order_id' not in session:
        return redirect(url_for('start_screen'))
    return render_template('order_page.html')

@app.route('/get_products')
def get_products():
    menu_service = MenuService()
    storage_service = StorageService()
    
    products = menu_service.get_menu_items(os.getenv("APS_ID"))
    available_items = storage_service.get_available_items(os.getenv("APS_ID"), [p['id'] for p in products])
    
    for product in products:
        product['available_quantity'] = next((item['available_quantity'] for item in available_items if item['item_id'] == product['id']), 0)
    
    return jsonify(products)

@app.route('/cancel_order', methods=['POST'])
def cancel_order():
    if 'order_id' not in session:
        return jsonify(success=False, message=_("Nie znaleziono aktywnego zamówienia."))
    
    order_service = OrderService()
    success = order_service.cancel_order(session['order_id'])
    
    if success:
        session.pop('order_id', None)
        return jsonify(success=True)
    else:
        return jsonify(success=False, message=_("Nie udało się anulować zamówienia. Spróbuj ponownie."))

@app.route('/update_order', methods=['POST'])
def update_order():
    if 'order_id' not in session:
        return jsonify(success=False, message=_("Nie znaleziono aktywnego zamówienia."))
    
    cart = request.json
    order_service = OrderService()
    success = order_service.update_order_items(session['order_id'], cart)
    
    if success:
        return jsonify(success=True)
    else:
        return jsonify(success=False, message=_("Nie udało się zaktualizować zamówienia. Spróbuj ponownie."))

@app.route('/order/summary')
def order_summary():
    if 'order_id' not in session:
        return redirect(url_for('start_screen'))
    return render_template('order_summary.html')

@app.route('/get_order_summary')
def get_order_summary():
    if 'order_id' not in session:
        return jsonify(success=False, message=_("Nie znaleziono aktywnego zamówienia."))
    
    order_service = OrderService()
    menu_service = MenuService()
    
    order_items = order_service.get_order_items(session['order_id'])
    suggested_products = menu_service.get_suggested_products(os.getenv("APS_ID"), [item['id'] for item in order_items])
    
    return jsonify(success=True, order_items=order_items, suggested_products=suggested_products)

@app.route('/proceed_to_payment', methods=['POST'])
def proceed_to_payment():
    if 'order_id' not in session:
        return jsonify(success=False, message=_("Nie znaleziono aktywnego zamówienia."))
    
    order_service = OrderService()
    payment_service = PaymentService()
    
    order_id = session['order_id']
    order_total = order_service.get_order_total(order_id)
    
    if order_total > 0:
        kds_order_number = payment_service.generate_next_kds_order_number(os.getenv("APS_ID"))
        if order_service.update_order_status(order_id, 'payment_in_progress', kds_order_number):
            return jsonify(success=True)
    
    return jsonify(success=False, message=_("Nie udało się przejść do płatności. Spróbuj ponownie."))

@app.route('/payment')
def payment_screen():
    if 'order_id' not in session:
        return redirect(url_for('start_screen'))
    return render_template('payment.html')

@app.route('/cancel_payment', methods=['POST'])
def cancel_payment():
    if 'order_id' not in session:
        return jsonify(success=False, message=_("Nie znaleziono aktywnego zamówienia."))
    
    order_service = OrderService()
    success = order_service.update_order_status(session['order_id'], 'during_ordering')
    
    if success:
        return jsonify(success=True)
    else:
        return jsonify(success=False, message=_("Nie udało się anulować płatności. Spróbuj ponownie."))

@app.route('/process_payment', methods=['POST'])
def process_payment():
    if 'order_id' not in session:
        return jsonify(success=False, message=_("Nie znaleziono aktywnego zamówienia."))
    
    payment_data = request.json
    payment_service = PaymentService()
    order_service = OrderService()
    
    payment_result = payment_service.process_payment(session['order_id'], payment_data)
    
    if payment_result['success']:
        order_service.update_order_status(session['order_id'], 'paid')
        return jsonify(success=True)
    else:
        return jsonify(success=False, message=payment_result['message'])

@app.route('/order/confirmation')
def order_confirmation():
    if 'order_id' not in session:
        return redirect(url_for('start_screen'))
    return render_template('order_confirmation.html')

@app.route('/get_confirmation_details')
def get_confirmation_details():
    if 'order_id' not in session:
        return jsonify(success=False, message=_("Nie znaleziono aktywnego zamówienia."))
    
    order_service = OrderService()
    order_details = order_service.get_order_details(session['order_id'])
    
    if order_details:
        return jsonify(success=True, **order_details)
    else:
        return jsonify(success=False, message=_("Nie udało się pobrać szczegółów zamówienia."))

@app.route('/finish_order', methods=['POST'])
def finish_order():
    if 'order_id' not in session:
        return jsonify(success=False, message=_("Nie znaleziono aktywnego zamówienia."))
    
    order_service = OrderService()
    success = order_service.update_order_status(session['order_id'], 'accepted_for_execution')
    
    if success:
        session.pop('order_id', None)
        return jsonify(success=True)
    else:
        return jsonify(success=False, message=_("Nie udało się zakończyć zamówienia. Spróbuj ponownie."))

@app.before_request
def before_request():
    if 'language' not in session:
        session['language'] = request.accept_languages.best_match(LANGUAGES)

if __name__ == '__main__':
    app.run(debug=True)