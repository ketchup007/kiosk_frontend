from services.supabase_client_manager import SupabaseClientManager

class ApsService:
    def __init__(self):
        self.supabase = SupabaseClientManager.create_local_client()

    def get_aps_state(self, aps_id):
        try:
            response = self.supabase.table('aps_description').select('state').eq('id', aps_id).execute()
            if response.data:
                return response.data[0]['state']
            else:
                return 'inactive'  # Domyślnie zwracamy 'inactive' jeśli nie znaleziono APS
        except Exception as e:
            print(f"Error getting APS state: {e}")
            return 'inactive'  # W przypadku błędu również zwracamy 'inactive'