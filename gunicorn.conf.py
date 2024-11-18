# Konfiguracja Gunicorn
workers = 4
bind = "127.0.0.1:18073"
timeout = 120
worker_class = "sync"
max_requests = 1000
max_requests_jitter = 50
keepalive = 5
