from services.supabase_client_manager import SupabaseClientManager

class OrderService:
    def __init__(self):
        self.supabase = SupabaseClientManager.create_local_client()

    def create_order(self, aps_id, origin):
        try:
            response = self.supabase.table('aps_order').insert({
                'aps_id': aps_id,
                'origin': origin,
                'status': 'during_ordering'
            }).execute()
            
            if response.data:
                return response.data[0]['id']
            else:
                return None
        except Exception as e:
            print(f"Error creating order: {e}")
            return None

    def cancel_order(self, order_id):
        try:
            response = self.supabase.table('aps_order').update({'status': 'canceled'}).eq('id', order_id).execute()
            return len(response.data) > 0
        except Exception as e:
            print(f"Error canceling order: {e}")
            return False

    def update_order_items(self, order_id, cart):
        try:
            # Najpierw usuńmy wszystkie istniejące pozycje zamówienia
            self.supabase.table('aps_order_item').delete().eq('aps_order_id', order_id).execute()
            
            # Teraz dodajmy nowe pozycje
            items_to_insert = [
                {'aps_order_id': order_id, 'item_id': int(item_id), 'quantity': quantity, 'status': 'reserved'}
                for item_id, quantity in cart.items() if quantity > 0
            ]
            
            if items_to_insert:
                self.supabase.table('aps_order_item').insert(items_to_insert).execute()
            
            return True
        except Exception as e:
            print(f"Error updating order items: {e}")
            return False

    def get_order_items(self, order_id):
        try:
            response = self.supabase.table('aps_order_item').select('*').eq('aps_order_id', order_id).execute()
            return response.data
        except Exception as e:
            print(f"Error getting order items: {e}")
            return []

    def get_order_total(self, order_id):
        try:
            response = self.supabase.rpc('get_order_total', {'input_order_id': order_id}).execute()
            return response.data
        except Exception as e:
            print(f"Error getting order total: {e}")
            return 0

    def update_order_status(self, order_id, status, kds_order_number=None):
        try:
            update_data = {'status': status}
            if kds_order_number is not None:
                update_data['kds_order_number'] = kds_order_number
            
            response = self.supabase.table('aps_order').update(update_data).eq('id', order_id).execute()
            return len(response.data) > 0
        except Exception as e:
            print(f"Error updating order status: {e}")
            return False

    def get_order_details(self, order_id):
        try:
            response = self.supabase.table('aps_order').select('kds_order_number', 'estimated_time', 'pickup_number').eq('id', order_id).execute()
            if response.data:
                return response.data[0]
            else:
                return None
        except Exception as e:
            print(f"Error getting order details: {e}")
            return None