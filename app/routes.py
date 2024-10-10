from flask import render_template, session, redirect, url_for
from flask_babel import _
from .services.aps_service import ApsService
from .services.order_service import OrderService

aps_service = ApsService()
order_service = OrderService()

def init_app(app):
    @app.route('/')
    def start_screen():
        aps_state = aps_service.get_aps_state(1)  # Zakładamy, że APS ID to 1
        return render_template('start_screen.html', aps_state=aps_state)

    @app.route('/set_language/<lang>')
    def set_language(lang):
        session['language'] = lang
        return redirect(url_for('start_screen'))

    @app.route('/start_order')
    def start_order():
        if aps_service.get_aps_state(1) == 'active':
            order_id = order_service.create_new_order(1)  # Tworzymy nowe zamówienie dla APS ID 1
            return redirect(url_for('menu', order_id=order_id))
        else:
            return redirect(url_for('start_screen'))