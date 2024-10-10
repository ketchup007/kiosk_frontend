from ..utils.supabase_client_manager import SupabaseClientManager

class OrderService:
    def __init__(self):
        self.supabase = SupabaseClientManager().get_local_client()

    def create_new_order(self, aps_id):
        new_order = {
            'aps_id': aps_id,
            'origin': 'kiosk',
            'status': 'during_ordering'
        }
        response = self.supabase.table('aps_order').insert(new_order).execute()
        if response.data:
            return response.data[0]['id']
        return None