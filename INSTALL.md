# Munchies Kiosk - Instrukcja instalacji

## Wymagania
- System Linux z zainstalowanym snapd
- Snapcraft (najnowsza wersja)

## Instalacja Snapcraft
```bash
# Usuń starą wersję snapcraft jeśli była zainstalowana przez apt
sudo apt remove snapcraft

# Zainstaluj snapcraft ze snapa
sudo snap install snapcraft --classic

# Zainstaluj LXD (jeśli nie jest zainstalowany)
sudo snap install lxd
sudo lxd init --auto
```

## Budowanie snapa
1. Sklonuj repozytorium:
```bash
git clone <repository-url>
cd kiosk_app
```

2. Zbuduj snapa:
```bash
snapcraft
```

3. Zainstaluj zbudowanego snapa:
```bash
sudo snap install ./munchies-kiosk_1.0.4_amd64.snap --dangerous
```

## Konfiguracja środowiska

### Metoda 1: Używanie pliku .env (zalecane dla rozwoju)
1. Utwórz katalog dla danych użytkownika:
```bash
mkdir -p ~/snap/munchies-kiosk/current
```

2. Skopiuj plik .env:
```bash
cp .env ~/snap/munchies-kiosk/current/
```

### Metoda 2: Konfiguracja przez snap (zalecane dla produkcji)
```bash
sudo snap set munchies-kiosk terminal.ip="10.3.15.90"
sudo snap set munchies-kiosk terminal.port.state="5189"
sudo snap set munchies-kiosk terminal.port.payment="5188"
sudo snap set munchies-kiosk aps.id="1"
sudo snap set munchies-kiosk supabase.local.url="http://172.20.20.198:8084/"
sudo snap set munchies-kiosk supabase.local.key="your-key"
sudo snap set munchies-kiosk supabase.central.url="http://10.3.15.11:8084"
sudo snap set munchies-kiosk supabase.central.key="your-key"
```

## Uruchamianie
```bash
munchies-kiosk
```

## Sprawdzanie logów
```bash
snap logs munchies-kiosk
```

## Rozwiązywanie problemów

1. Sprawdź czy wszystkie interfejsy są podłączone:
```bash
snap connections munchies-kiosk
```

2. Sprawdź czy plik .env jest poprawnie umieszczony:
```bash
ls -la ~/snap/munchies-kiosk/current/.env
```

3. Sprawdź logi systemowe:
```bash
journalctl -xe
```

4. Sprawdź status aplikacji:
```bash
systemctl status snap.munchies-kiosk.munchies-kiosk
```

## Aktualizacja
Snap będzie automatycznie aktualizowany. Aby wymusić aktualizację:
```bash
sudo snap refresh munchies-kiosk
```

## Usuwanie
```bash
sudo snap remove munchies-kiosk
```