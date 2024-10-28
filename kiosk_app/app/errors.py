from flask import jsonify
from app import app
from werkzeug.exceptions import NotFound, MethodNotAllowed, BadRequest

@app.errorhandler(NotFound)
def not_found_error(error):
    return jsonify(error="Resource not found"), 404

@app.errorhandler(MethodNotAllowed)
def method_not_allowed_error(error):
    return jsonify(error="Method not allowed"), 405

@app.errorhandler(BadRequest)
def bad_request_error(error):
    return jsonify(error="Bad request"), 400

class DatabaseError(Exception):
    pass

@app.errorhandler(DatabaseError)
def database_error(error):
    app.logger.error(f'Database error: {str(error)}')
    return jsonify(error="A database error occurred"), 500

class PaymentError(Exception):
    pass

@app.errorhandler(PaymentError)
def payment_error(error):
    app.logger.error(f'Payment error: {str(error)}')
    return jsonify(error="A payment error occurred"), 500
