from services.supabase_client_manager import SupabaseClientManager

class MenuService:
    def __init__(self):
        self.supabase = SupabaseClientManager.create_local_client()

    def get_menu_items(self, aps_id):
        try:
            response = self.supabase.rpc('get_aps_menu_items', {'p_aps_id': aps_id}).execute()
            return response.data
        except Exception as e:
            print(f"Error getting menu items: {e}")
            return []

    def get_suggested_products(self, aps_id, ordered_item_ids):
        try:
            response = self.supabase.rpc('get_suggested_products', {
                'p_aps_id': aps_id,
                'p_ordered_item_ids': ordered_item_ids
            }).execute()
            return response.data
        except Exception as e:
            print(f"Error getting suggested products: {e}")
            return []