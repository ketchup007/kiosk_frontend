import os
import sys

# Dodaj ścieżkę do katalogu głównego projektu do sys.path
project_root = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, project_root)

from app.main import app

if __name__ == '__main__':
    app.run(debug=True)