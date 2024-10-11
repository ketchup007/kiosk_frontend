from flask import Blueprint, render_template, session, redirect, url_for, request
from flask_babel import _
from app.services.aps_service import ApsService
from app.services.order_service import OrderService

main_bp = Blueprint('main', __name__)
aps_service = ApsService()
order_service = OrderService()

@main_bp.route('/')
def start_screen():
    aps_state = aps_service.get_aps_state(1)  # Zakładamy, że APS ID to 1
    return render_template('start_screen.html', aps_state=aps_state)

@main_bp.route('/set_language/<lang>')
def set_language(lang):
    session['language'] = lang
    return redirect(request.referrer or url_for('main.start_screen'))

@main_bp.route('/start_order')
def start_order():
    if aps_service.get_aps_state(1) == 'active':
        order_id = order_service.create_new_order(1)  # Tworzymy nowe zamówienie dla APS ID 1
        return redirect(url_for('main.menu', order_id=order_id))
    else:
        return redirect(url_for('main.start_screen'))