from flask import Flask, request, session
from flask_babel import Babel
from .config import Config
from .utils.supabase_client_manager import SupabaseClientManager

supabase_manager = SupabaseClientManager()

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    def get_locale():
        return session.get('language', request.accept_languages.best_match(app.config['LANGUAGES']))

    babel = Babel(app, locale_selector=get_locale)
    app.config['BABEL_DEFAULT_LOCALE'] = 'pl'
    app.config['BABEL_TRANSLATION_DIRECTORIES'] = 'translations'
    
    babel.init_app(app)
    supabase_manager.init_app(app)

    with app.app_context():
        from .routes.main import main_bp
        app.register_blueprint(main_bp)

    return app