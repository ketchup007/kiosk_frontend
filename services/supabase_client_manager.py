import os
from dotenv import load_dotenv
from supabase import create_client, Client

load_dotenv()

class SupabaseClientManager:
    @staticmethod
    def create_local_client() -> Client:
        url = os.getenv("SUPABASE_LOCAL_URL")
        key = os.getenv("SUPABASE_LOCAL_KEY")
        return create_client(url, key)

    @staticmethod
    def create_central_client() -> Client:
        url = os.getenv("SUPABASE_CENTRAL_URL")
        key = os.getenv("SUPABASE_CENTRAL_KEY")
        return create_client(url, key)