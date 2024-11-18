# Kiosk Samoobsługowy APS

## Opis projektu
Aplikacja kiosku samoobsługowego dla punktu APS (Autonomiczny Punkt Sprzedaży), umożliwiająca klientom przeglądanie menu, składanie zamówień i dokonywanie płatności. Aplikacja obsługuje wiele języków (polski, angielski, ukraiński), zapewnia intuicyjny interfejs użytkownika oraz integruje się z systemem płatności ELAVON i bazą danych Supabase.

## Wymagania systemowe
- Python 3.x
- Flask 3.0.3
- Flask-Babel 4.0.0
- python-dotenv 1.0.1
- sentry-sdk 2.17.0
- supabase 2.9.1
- tenacity 9.0.0
- Inne zależności wymienione w pliku `requirements.txt`

## Instalacja i uruchomienie projektu
1. Sklonuj repozytorium:
   ```
   git clone https://github.com/twoj-username/kiosk-app.git
   cd kiosk-app
   ```

2. Utwórz i aktywuj wirtualne środowisko:
   ```
   python -m venv venv
   source venv/bin/activate  # Na Windows użyj: venv\Scripts\activate
   ```

3. Zainstaluj zależności:
   ```
   pip install -r requirements.txt
   ```

4. Skonfiguruj zmienne środowiskowe:
   - Skopiuj plik `.env.example` do `.env`
   - Wypełnij wszystkie wymagane zmienne w pliku `.env`

5. Kompilacja tłumaczeń:
   ```
   pybabel compile -d translations
   ```

6. Uruchom aplikację:
   ```
   python run.py
   ```

8. Otwórz przeglądarkę i przejdź do `http://localhost:5000`

## Konfiguracja tłumaczeń

1. Utwórz katalog `translations`:
   ```
   mkdir translations
   ```

2. Wygeneruj plik `.pot`:
   ```
   pybabel extract -F babel.cfg -o messages.pot .
   ```

3. Utwórz pliki `.po` dla każdego języka:
   ```
   pybabel init -i messages.pot -d translations -l pl
   pybabel init -i messages.pot -d translations -l en
   pybabel init -i messages.pot -d translations -l uk
   ```

4. Edytuj pliki `.po` w katalogu `translations` dla każdego języka, dodając tłumaczenia.

5. Skompiluj tłumaczenia:
   ```
   pybabel compile -d translations
   ```

## Aktualizacja tłumaczeń
Jeśli chcesz zaktualizować lub dodać nowe tłumaczenia:

1. Zaktualizuj pliki `.po` w katalogu `translations`

2. Wygeneruj nowe pliki tłumaczeń:
   ```
   pybabel extract -F babel.cfg -o messages.pot .
   pybabel update -i messages.pot -d translations
   ```

3. Edytuj pliki `.po` w katalogu `translations` dla każdego języka

4. Skompiluj pliki tłumaczeń:
   ```
   pybabel compile -d translations
   ```

## Uruchamianie testów
Aby uruchomić testy jednostkowe:

```
python -m unittest discover tests
```

## Struktura projektu
- `/app`: Główny pakiet aplikacji
  - `__init__.py`: Inicjalizacja aplikacji Flask
  - `routes.py`: Definicje tras
  - `models.py`: Modele danych
  - `utils.py`: Funkcje pomocnicze
- `/services`: Usługi zewnętrzne
  - `database.py`: Obsługa bazy danych Supabase
  - `payment_service.py`: Integracja z systemem płatności ELAVON
- `/static`: Pliki statyczne (CSS, JavaScript, obrazy)
- `/templates`: Szablony HTML
- `/translations`: Pliki tłumaczeń
- `/tests`: Testy jednostkowe

## Konfiguracja
Aplikacja korzysta z pliku `.env` do przechowywania konfiguracji. Upewnij się, że ustawiono następujące zmienne:
<!-- - `SENTRY_DSN`: DSN dla integracji z Sentry -->
- `SUPABASE_LOCAL_URL`: URL lokalnej bazy danych Supabase
- `SUPABASE_LOCAL_KEY`: Klucz dostępu do lokalnej bazy danych Supabase
- `SUPABASE_CENTRAL_URL`: URL centralnej bazy danych Supabase
- `SUPABASE_CENTRAL_KEY`: Klucz dostępu do centralnej bazy danych Supabase
- `TERMINAL_ELAVON_IP`: Adres IP terminala płatniczego ELAVON
- `TERMINAL_ELAVON_PORT_STATE`: Port do sprawdzania stanu terminala ELAVON
- `TERMINAL_ELAVON_PORT_PAYMENT`: Port do obsługi płatności terminala ELAVON
- `APS_ID`: Identyfikator punktu APS

## Rozwiązywanie problemów
- Jeśli występują problemy z połączeniem z bazą danych, sprawdź konfigurację Supabase w pliku `.env`
- W przypadku problemów z płatnościami, upewnij się, że terminal ELAVON jest dostępny i poprawnie skonfigurowany
- Jeśli tłumaczenia nie działają, upewnij się, że pliki `.mo` zostały poprawnie wygenerowane w katalogu `translations`

## Autorzy
- [Twoje Imię]

## Licencja
[Dodaj informacje o licencji]
