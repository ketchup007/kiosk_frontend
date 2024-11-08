import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import app
from flask import send_from_directory
from services.logging_service import logging_service
import mimetypes

# Dodajemy właściwe typy MIME
mimetypes.add_type('application/javascript', '.js')
mimetypes.add_type('text/css', '.css')
mimetypes.add_type('image/svg+xml', '.svg')

@app.route('/static/<path:filename>')
def serve_static(filename):
    logging_service.debug(f"Serving static file: {filename}")
    try:
        static_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'static')
        response = send_from_directory(
            static_folder,
            filename,
            conditional=True
        )
        
        # Dodajemy nagłówki dla lepszego debugowania
        response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
        response.headers['Pragma'] = 'no-cache'
        response.headers['Expires'] = '0'
        
        # Dodajemy właściwy Content-Type dla JavaScript
        if filename.endswith('.js'):
            response.headers['Content-Type'] = 'application/javascript; charset=utf-8'
            logging_service.debug(f"Serving JavaScript file with headers: {response.headers}")
        
        return response
    except Exception as e:
        logging_service.error(f"Error serving static file {filename}: {str(e)}")
        return f"File not found: {filename}", 404

@app.after_request
def add_header(response):
    # Dodajemy nagłówki do wszystkich odpowiedzi
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-Frame-Options'] = 'DENY'
    response.headers['X-XSS-Protection'] = '1; mode=block'
    return response

if __name__ == "__main__":
    # Konfiguracja dla trybu debug
    app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
    app.config['TEMPLATES_AUTO_RELOAD'] = True
    
    # Określamy ścieżkę do folderu static
    static_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'static')
    
    # Dodajemy informację o uruchomieniu serwera
    logging_service.info("Starting Flask development server...")
    logging_service.info(f"Static folder: {static_folder}")
    
    app.run(
        debug=False,
        host='0.0.0.0',
        port=5000,
        use_reloader=True
    )
