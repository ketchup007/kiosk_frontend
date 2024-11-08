# Building a Snap for Flask Application

This guide explains how to build a snap package for your Flask application.

## Setup

1. Install Snapcraft:
   ```bash
   sudo snap install snapcraft --classic
   ```

## Building the Snap

1. Navigate to your Flask project directory.

2. Create a `snapcraft.yaml` file in your project root:
   ```yaml
   name: munchies-kiosk
   version: 1.0.4
   summary: Munchies Kiosk
   description: Munchies Kiosk App

   base: core20
   confinement: strict
   grade: stable

   apps:
     munchies-kiosk:
       command: bin/flask-run
       environment:
         FLASK_APP: kiosk_app
         FLASK_ENV: production
       plugs:
         - network
         - desktop
         - desktop-legacy
         - x11
         - wayland
         - gsettings
         - unity7
         - audio-playback
         - audio-record
         - pulseaudio
         - alsa

   parts:
     flask-kiosk-app:
       plugin: python
       source: .
       requirements:
         - requirements.txt
       override-build: |
         snapcraftctl build
         mkdir -p $SNAPCRAFT_PART_INSTALL/bin
         cat > $SNAPCRAFT_PART_INSTALL/bin/flask-run << 'EOF'
         #!/bin/sh
         exec flask run --host=0.0.0.0 --port=8000
         EOF
         chmod +x $SNAPCRAFT_PART_INSTALL/bin/flask-run
   ```

3. Ensure your `requirements.txt` is up to date:
   ```bash
   pip freeze > requirements.txt
   ```

4. Build the snap:
   ```bash
   snapcraft
   ```
   
   Note: If you encounter errors or need to rebuild the snap, clean the build environment:
   ```bash
   snapcraft clean
   ```

## Environment Configuration

The application supports two methods for environment configuration:

1. Using snap configuration (recommended for production):
   ```bash
   # Configure environment variables
   sudo snap set munchies-kiosk terminal.ip="10.3.15.90"
   sudo snap set munchies-kiosk terminal.port.state="5189"
   sudo snap set munchies-kiosk terminal.port.payment="5188"
   sudo snap set munchies-kiosk supabase.local.url="http://172.20.20.198:8084/"
   sudo snap set munchies-kiosk supabase.local.key="your-key"
   sudo snap set munchies-kiosk supabase.central.url="http://10.3.15.11:8084"
   sudo snap set munchies-kiosk supabase.central.key="your-key"
   sudo snap set munchies-kiosk aps.id="1"
   ```

2. Using .env file (recommended for development):
   ```bash
   # Create snap user data directory
   mkdir -p ~/snap/munchies-kiosk/current
   
   # Copy your .env file
   cp .env ~/snap/munchies-kiosk/current/
   ```

Note: For production deployment, it's recommended to use snap configuration rather than .env files.

## Installation on Target Machine

1. Remove existing snap (if installed):
   ```bash
   sudo snap remove munchies-kiosk
   ```

2. Install the snap locally:
   ```bash
   sudo snap install ./munchies-kiosk_1.0.4_amd64.snap --dangerous
   ```

3. Restart the kiosk service:
   ```bash
   systemctl --user restart kiosk.service
   ```

## Copying the Snap File to Target Machine

To copy the snap file using `scp`:

```bash
scp munchies-kiosk_1.0.4_amd64.snap avena@<ip>:
```

Replace `<ip>` with the target machine's IP address.

## Troubleshooting

1. If the snap fails to build:
   - Check the Python version compatibility (core20 uses Python 3.8)
   - Verify all dependencies in requirements.txt are compatible
   - Use `snapcraft --debug` to investigate build issues

2. If the snap fails to run:
   - Check system logs: `journalctl -xe`
   - Check snap logs: `snap logs munchies-kiosk`
   - Verify network permissions and port availability

## Optional: Desktop Integration

1. Create a desktop file in `snap/gui/munchies-kiosk.desktop`:
   ```
   [Desktop Entry]
   Name=Munchies Kiosk
   Comment=Munchies Kiosk Application
   Exec=munchies-kiosk
   Icon=${SNAP}/meta/gui/munchies-kiosk.png
   Terminal=false
   Type=Application
   Categories=Network;
   ```

2. Add your app icon as `snap/gui/munchies-kiosk.png`

For more information, see the [Snapcraft Python documentation](https://snapcraft.io/docs/python-apps).

## Security Notes

1. Environment Variables:
   - Never commit sensitive credentials to version control
   - Use snap configuration for production deployments
   - Keep .env files secure and only in development environments

2. Production Deployment:
   - Always use `confinement: strict` in production
   - Configure environment variables using snap configuration
   - Regularly rotate security keys and credentials
