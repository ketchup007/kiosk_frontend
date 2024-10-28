from flask import Flask, request, session
from flask_babel import Babel
import os
from config import Config
from services.logging_service import logging_service

app = Flask(__name__, template_folder='../templates', static_folder='../static')

app.config.from_object(Config)

# The secret key is now set from the Config object
app.secret_key = app.config['SECRET_KEY']

# Zmiana ścieżki do tłumaczeń na bezwzględną
app.config['BABEL_TRANSLATION_DIRECTORIES'] = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'translations')
app.config['LANGUAGES'] = ['en', 'pl', 'uk']

def get_locale():
    if 'language' in session:
        return session['language']
    return request.accept_languages.best_match(app.config['LANGUAGES'])

# Initialize Babel with locale_selector
babel = Babel(app, locale_selector=get_locale)

# Initialize LoggingService
logging_service.initialize(app, enable_console_logging=True)

# Import routes at the end to avoid circular imports
from app import routes
