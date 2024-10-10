from flask import Flask
from flask_babel import Babel
from .config import Config
from .utils.supabase_client_manager import SupabaseClientManager

babel = Babel()
supabase_manager = SupabaseClientManager()

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    babel.init_app(app)
    supabase_manager.init_app(app)

    with app.app_context():
        from . import routes
        routes.init_app(app)

    return app