import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    SUPABASE_LOCAL_URL = os.environ.get('SUPABASE_LOCAL_URL')
    SUPABASE_LOCAL_KEY = os.environ.get('SUPABASE_LOCAL_KEY')
    SUPABASE_CENTRAL_URL = os.environ.get('SUPABASE_CENTRAL_URL')
    SUPABASE_CENTRAL_KEY = os.environ.get('SUPABASE_CENTRAL_KEY')
    LANGUAGES = ['pl', 'en', 'uk']