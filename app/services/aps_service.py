from ..utils.supabase_client_manager import SupabaseClientManager

class ApsService:
    def __init__(self):
        self.supabase = SupabaseClientManager().get_local_client()

    def get_aps_state(self, aps_id):
        response = self.supabase.table('aps_description').select('state').eq('id', aps_id).execute()
        if response.data:
            return response.data[0]['state']
        return None