from services.supabase_client_manager import SupabaseClientManager

class StorageService:
    def __init__(self):
        self.supabase = SupabaseClientManager.create_local_client()

    def get_available_items(self, aps_id, item_ids):
        try:
            response = self.supabase.rpc('get_available_items', {
                'aps_id_input': aps_id,
                'item_ids': item_ids
            }).execute()
            return response.data
        except Exception as e:
            print(f"Error getting available items: {e}")
            return []