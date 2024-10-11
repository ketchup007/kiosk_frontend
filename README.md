# Kiosk App

## Konfiguracja projektu

1. Sklonuj repozytorium:
   ```
   git clone [URL_REPOZYTORIUM]
   cd kiosk_app
   ```

2. Utwórz wirtualne środowisko Python:
   ```
   python -m venv venv
   ```

3. Aktywuj wirtualne środowisko:
   - Na Windows:
     ```
     venv\Scripts\activate
     ```
   - Na macOS/Linux:
     ```
     source venv/bin/activate
     ```

4. Zainstaluj zależności:
   ```
   pip install -r requirements.txt
   ```

5. Skonfiguruj zmienne środowiskowe:
   - Skopiuj plik `.env.example` do `.env`
   - Uzupełnij wartości w pliku `.env`

## Uruchamianie aplikacji

Po skonfigurowaniu projektu, możesz uruchomić aplikację wykonując następujące kroki:

1. Upewnij się, że jesteś w głównym katalogu projektu.

2. Aktywuj wirtualne środowisko (jeśli jeszcze nie jest aktywne):
   - Na Windows:
     ```
     venv\Scripts\activate
     ```
   - Na macOS/Linux:
     ```
     source venv/bin/activate
     ```

3. Uruchom aplikację:
   ```
   python run.py
   ```

4. Otwórz przeglądarkę i przejdź pod adres `http://localhost:5000` (lub inny port, jeśli zosta zmieniony w konfiguracji).

5. Aplikacja powinna być teraz dostępna i gotowa do użycia.

## Struktura projektu

- `app/`: Główny katalog aplikacji Flask
- `templates/`: Szablony HTML
- `static/`: Pliki statyczne (CSS, JavaScript, obrazy)
- `services/`: Logika biznesowa i interakcja z bazą danych
- `models/`: Definicje modeli danych
- `run.py`: Plik uruchomieniowy aplikacji

## Rozwój projektu

- Używaj `Flask-Babel` do obsługi tłumaczeń
- Integracja z PayU jest zaimplementowana w `services/payment_service.py`
- Wszystkie zapytania do bazy danych Supabase powinny być wykonywane przez `SupabaseClientManager`

### Zarządzanie tłumaczeniami

1. Ekstrakcja tekstów do tłumaczenia:
   ```
   pybabel extract -F babel.cfg -o messages.pot .
   ```

2. Inicjalizacja lub aktualizacja plików tłumaczeń:
   ```
   pybabel init -i messages.pot -d translations -l pl
   pybabel init -i messages.pot -d translations -l en
   pybabel init -i messages.pot -d translations -l uk
   ```
   lub
   ```
   pybabel update -i messages.pot -d translations
   ```

3. Edytuj pliki `translations/<lang>/LC_MESSAGES/messages.po`

4. Kompilacja plików tłumaczeń:
   ```
   pybabel compile -d translations
   ```

## Testowanie

- Uruchom testy jednostkowe:
  ```
  python -m unittest discover tests
  ```

## Bezpieczeństwo

- Nie commituj pliku `.env` do repozytorium
- Regularnie aktualizuj zależności
- Używaj `python-dotenv` do zarządzania zmiennymi środowiskowymi