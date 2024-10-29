import logging
from logging.handlers import RotatingFileHandler
import os
import sys
import sentry_sdk
from sentry_sdk.integrations.flask import FlaskIntegration
from datetime import datetime

class LoggingService:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(LoggingService, cls).__new__(cls)
            cls._instance.logger = None
            cls._instance.sentry_initialized = False
            cls._instance.file_logging_enabled = False
            cls._instance.sentry_logging_enabled = False
            cls._instance.console_logging_enabled = False
        return cls._instance

    def initialize(self, app, enable_file_logging=False, enable_sentry_logging=False, enable_console_logging=True):
        self.file_logging_enabled = enable_file_logging
        self.sentry_logging_enabled = enable_sentry_logging
        self.console_logging_enabled = enable_console_logging
        self.initialize_logging(app)
        self.initialize_sentry(app)

    def initialize_logging(self, app):
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.DEBUG)

        formatter = logging.Formatter('[%(levelname)s] - [%(asctime)s]: %(message)s', datefmt='%Y-%m-%d %H:%M:%S')

        if self.file_logging_enabled:
            if not os.path.exists('logs'):
                os.mkdir('logs')

            current_time = datetime.now().strftime("%Y%m%d_%H%M%S")
            log_filename = f'logs/kiosk_app_{current_time}.log'
            file_handler = RotatingFileHandler(log_filename, maxBytes=10240, backupCount=10)
            file_handler.setFormatter(formatter)
            file_handler.setLevel(logging.INFO)
            self.logger.addHandler(file_handler)

            self.logger.info('Kiosk app file logging initialized')
        else:
            self.logger.info('File logging is disabled')

        if self.console_logging_enabled:
            console_handler = logging.StreamHandler(sys.stdout)
            console_handler.setFormatter(formatter)
            console_handler.setLevel(logging.INFO)
            self.logger.addHandler(console_handler)
            self.logger.info('Console logging initialized')
        else:
            self.logger.info('Console logging is disabled')

    def initialize_sentry(self, app):
        if self.sentry_logging_enabled and not self.sentry_initialized and 'SENTRY_DSN' in app.config:
            sentry_sdk.init(
                dsn=app.config['SENTRY_DSN'],
                integrations=[FlaskIntegration()],
                traces_sample_rate=1.0
            )
            self.sentry_initialized = True
            self.logger.info('Sentry initialized')
        elif not self.sentry_logging_enabled:
            self.logger.info('Sentry logging is disabled')

    def info(self, message):
        self.logger.info(message)

    def debug(self, message):
        self.logger.debug(message)

    def warning(self, message):
        self.logger.warning(message)

    def error(self, message):
        self.logger.error(message)
        if self.sentry_initialized and self.sentry_logging_enabled:
            sentry_sdk.capture_message(message, level="error")

    def exception(self, message):
        self.logger.exception(message)
        if self.sentry_initialized and self.sentry_logging_enabled:
            sentry_sdk.capture_exception()

logging_service = LoggingService()
