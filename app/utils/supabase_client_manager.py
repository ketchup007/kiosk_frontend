from supabase import create_client, Client
from flask import current_app

class SupabaseClientManager:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(SupabaseClientManager, cls).__new__(cls)
            cls._instance.local_client = None
            cls._instance.central_client = None
        return cls._instance

    def init_app(self, app):
        with app.app_context():
            self.local_client = create_client(
                current_app.config['SUPABASE_LOCAL_URL'],
                current_app.config['SUPABASE_LOCAL_KEY']
            )
            self.central_client = create_client(
                current_app.config['SUPABASE_CENTRAL_URL'],
                current_app.config['SUPABASE_CENTRAL_KEY']
            )

    def get_local_client(self) -> Client:
        if self.local_client is None:
            raise RuntimeError("Supabase local client not initialized. Make sure to call init_app() first.")
        return self.local_client

    def get_central_client(self) -> Client:
        if self.central_client is None:
            raise RuntimeError("Supabase central client not initialized. Make sure to call init_app() first.")
        return self.central_client