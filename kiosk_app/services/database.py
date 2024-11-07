from app.errors import DatabaseError
from functools import lru_cache
from config import Config
from app.models import (
    APSMenuItems, APSMenuItem, AvailableItem, APSOrder, APSOrderWithItems,
    SuggestedProduct, ItemCategory, OrderStatus, ItemStatus,
    OrderOrigin, APSOrderItemCreate, StorageCategory
)
from typing import List, Dict, Any
from services.logging_service import logging_service
from datetime import datetime
from flask_babel import _

class Database:
    def __init__(self):
        self.client = Config.get_local_client()

    def get_available_quantities(self, aps_id: int, item_ids: List[int]) -> List[AvailableItem]:
        try:
            result = self.client.rpc('get_available_quantities', {
                'aps_id_input': aps_id,
                'item_ids': item_ids
            }).execute()
            
            logging_service.info(f"get_available_quantities result: {result}")
            if result.data:
                return [AvailableItem(**item) for item in result.data]
            return []
        except Exception as e:
            logging_service.error(f"Database error in get_available_quantities: {str(e)}")
            raise DatabaseError("Error getting available quantities")

    def get_order_total(self, order_id: int, aps_id: int) -> float:
        try:
            result = self.client.rpc('get_order_total', {
                'input_order_id': order_id,
                'input_aps_id': aps_id
            }).execute()
            
            # Sprawdź czy mamy dane
            if not result.data:
                return 0.0
                
            # Jeśli result.data jest liczbą
            if isinstance(result.data, (int, float)):
                return float(result.data)
                
            # Jeśli result.data jest listą lub słownikiem
            if isinstance(result.data, list) and result.data:
                if isinstance(result.data[0], dict):
                    return float(result.data[0].get('get_order_total', 0))
                return float(result.data[0])
                
            return 0.0
        except Exception as e:
            logging_service.error(f"Database error in get_order_total: {str(e)}")
            raise DatabaseError("Error getting order total")

    def generate_next_kds_order_number(self, aps_id: int) -> int:
        try:
            result = self.client.rpc('generate_next_kds_order_number', {
                'input_aps_id': aps_id
            }).execute()
            
            return int(result.data)
        except Exception as e:
            logging_service.error(f"Database error in generate_next_kds_order_number: {str(e)}")
            raise DatabaseError("Error generating KDS order number")

    def calculate_estimated_waiting_time(self, aps_id: int, order_id: int = None) -> int:
        """
        Oblicza szacowany czas oczekiwania dla zamówienia lub ogólny czas kolejki.
        
        Args:
            aps_id (int): ID kiosku APS
            order_id (int, optional): ID zamówienia, jeśli None to oblicza tylko czas kolejki
        
        Returns:
            int: Szacowany czas oczekiwania w minutach
        """
        try:
            # Wywołujemy funkcję SQL z odpowiednimi parametrami
            result = self.client.rpc(
                'calculate_estimated_waiting_time',
                {
                    'input_aps_id': aps_id,
                    'input_order_id': order_id
                }
            ).execute()
            
            # Sprawdzamy czy mamy wynik
            if not result.data:
                return 0
                
            try:
                return int(result.data)
            except (ValueError, TypeError, IndexError) as e:
                logging_service.error(f"Invalid waiting time value or format: {str(e)}")
                return 0
                
        except Exception as e:
            logging_service.error(f"Database error in calculate_estimated_waiting_time: {str(e)}")
            return 0  # Zwracamy 0 w przypadku błędu

    def get_suggested_products(self, aps_id: int, order_id: int, max_suggestions: int = 5) -> List[SuggestedProduct]:
        try:
            # Wywołaj funkcję SQL z odpowiednimi parametrami
            result = self.client.rpc(
                'get_suggested_products',
                {
                    'input_aps_id': aps_id,
                    'input_order_id': order_id,
                    'max_suggestions': max_suggestions
                }
            ).execute()
            
            logging_service.info(f"Raw suggested products result: {result}")
            
            if result.data:
                suggested_products = []
                # Parsuj każdy produkt z wyniku JSON
                for item in result.data:
                    try:
                        # Konwertuj kategorię na enum
                        if isinstance(item.get('category'), str):
                            item['category'] = ItemCategory(item['category'])
                        suggested_products.append(SuggestedProduct(**item))
                    except Exception as e:
                        logging_service.error(f"Error mapping suggested product: {str(e)}, data: {item}")
                        continue
                
                logging_service.info(f"Mapped {len(suggested_products)} suggested products")
                return suggested_products
                
            return []
        except Exception as e:
            logging_service.error(f"Database error in get_suggested_products: {str(e)}")
            raise DatabaseError("Error getting suggested products")


    @lru_cache(maxsize=128)
    def get_menu(self, aps_id: int) -> APSMenuItems:
        try:
            result = self.client.table('aps_menu_items').select('*').eq('aps_id', aps_id).execute()
            
            if not result.data:
                raise DatabaseError(_("Menu not found"))
                
            menu_data = result.data[0]
            menu_items = []
            
            for item in menu_data.get('menu_items', []):
                try:
                    if isinstance(item.get('item_category'), str):
                        item['item_category'] = ItemCategory(item['item_category'])
                    menu_items.append(APSMenuItem(**item))
                except Exception as e:
                    logging_service.error(f"Error mapping menu item: {str(e)}, data: {item}")
                    continue
                
            return APSMenuItems(
                aps_id=menu_data['aps_id'],
                aps_name=menu_data['aps_name'],
                menu_id=menu_data['menu_id'],
                menu_name=menu_data['menu_name'],
                menu_items=menu_items
            )
        except Exception as e:
            logging_service.error(f"Database error in get_menu: {str(e)}")
            raise DatabaseError(_("Error getting menu"))

    def get_aps_state(self, aps_id: int) -> str:
        try:
            result = self.client.table('aps_description').select('state').eq('id', aps_id).execute()
            if result.data:
                state = result.data[0]['state']
                logging_service.info(f"APS state retrieved: {state}")
                return state
            raise DatabaseError("APS state not found")
        except Exception as e:
            logging_service.error(f"Database error in get_aps_state: {str(e)}")
            raise DatabaseError("Error getting APS state")

    def create_order(self, aps_id: int) -> APSOrder:
        try:
            # Przygotuj dane początkowe dla nowego zamówienia
            current_time = datetime.now().isoformat()  # Konwertuj datetime na string ISO            
            order_data = {
                'aps_id': aps_id,  # Przypisany punkt APS
                'origin': OrderOrigin.KIOSK.value,  # Typ źródła zamówienia
                'status': OrderStatus.DURING_ORDERING.value,  # Status początkowy
                'pickup_number': None,  # Zostanie przypisane później po zapłacie
                'kds_order_number': None,  # Zostanie przypisane później po zapłacie
                'client_phone_number': None,  # Opcjonalne dla kiosku
                'estimated_time': 0,  # Początkowy szacowany czas
                'created_at': current_time,  # Czas utworzenia
                'updated_at': current_time  # Czas ostatniej aktualizacji
            }
            
            # Wstaw zamówienie do bazy danych
            logging_service.info(f"Inserting order data: {order_data}")
            result = self.client.table('aps_order').insert(order_data).execute()
            logging_service.info(f"Order creation result: {result}")
            
            if not result.data:
                logging_service.error("No data returned from order creation")
                raise DatabaseError(_("Failed to create order"))
                
            # Konwertuj wynik na obiekt APSOrder
            try:
                return APSOrder(**result.data[0])
            except Exception as e:
                logging_service.error(f"Error creating APSOrder object: {str(e)}")
                raise DatabaseError(_("Error processing order data"))
                
        except Exception as e:
            logging_service.error(f"Database error in create_order: {str(e)}")
            raise DatabaseError(_("Error creating order"))

    def get_order_items(self, order_id: int) -> List[Dict[str, Any]]:
        try:
            result = self.client.table('aps_order_item').select('*').eq('aps_order_id', order_id).execute()
            
            return result.data
        except Exception as e:
            logging_service.error(f"Database error in get_order_items: {str(e)}")
            raise DatabaseError("Error getting order items")

    def add_item_to_order(self, order_id: int, item_id: int, quantity: int) -> bool:
        try:
            # Najpierw pobierz aps_id z zamówienia
            order_result = self.client.table('aps_order').select('aps_id').eq('id', order_id).execute()
            if not order_result.data:
                raise DatabaseError(_("Order not found"))
            
            aps_id = order_result.data[0]['aps_id']
            
            # Utwórz listę obiektów APSOrderItemCreate
            items_to_insert = [
                APSOrderItemCreate(
                    aps_order_id=order_id,
                    aps_id=aps_id,
                    item_id=item_id,
                    status=ItemStatus.RESERVED
                ).model_dump(mode='json')
                for _ in range(quantity)
            ]
            
            self.client.table('aps_order_item').insert(items_to_insert).execute()
            return True
        except Exception as e:
            logging_service.error(f"Database error in add_item_to_order: {str(e)}")
            raise DatabaseError(_("Error adding item to order"))

    def remove_item_from_order(self, order_id: int, item_id: int, quantity: int) -> bool:
        try:
            # Używamy enuma ItemStatus dla statusu przedmiotu
            items_to_remove = self.client.table('aps_order_item')\
                .select('id')\
                .eq('aps_order_id', order_id)\
                .eq('item_id', item_id)\
                .eq('status', ItemStatus.RESERVED.value)\
                .limit(quantity)\
                .execute()
            
            if items_to_remove.data:
                ids_to_remove = [item['id'] for item in items_to_remove.data]
                self.client.table('aps_order_item').delete().in_('id', ids_to_remove).execute()
            return True
        except Exception as e:
            logging_service.error(f"Database error in remove_item_from_order: {str(e)}")
            raise DatabaseError(_("Error removing item from order"))

    def get_order_summary(self, order_id: int) -> APSOrderWithItems:
        try:
            result = self.client.table('aps_order_with_items').select('*').eq('id', order_id).execute()
            logging_service.info(f"get_order_summary result: {result}")
            
            if result.data and len(result.data) > 0:
                # Bierzemy pierwszy element z listy
                order_data = result.data[0]
                
                # Konwertujemy dane do odpowiedniego formatu
                for item in order_data.get('items', []):
                    # Konwertuj category na enum
                    if isinstance(item.get('category'), str):
                        item['category'] = ItemCategory(item['category'])
                
                # Tworzymy obiekt APSOrderWithItems
                return APSOrderWithItems(**order_data)
                
            raise DatabaseError("Order summary not found")
        except Exception as e:
            logging_service.error(f"Database error in get_order_summary: {str(e)}")
            raise DatabaseError("Error getting order summary")

    def get_order_details(self, order_id: int) -> APSOrder:
        try:
            result = self.client.table('aps_order').select('*').eq('id', order_id).execute()
            
            if result.data:
                return APSOrder(**result.data[0])
            raise DatabaseError("Order details not found")
        except Exception as e:
            logging_service.error(f"Database error in get_order_details: {str(e)}")
            raise DatabaseError("Error getting order details")

    def update_order_status(self, order_id: int, status: OrderStatus) -> bool:
        try:
            self.client.table('aps_order').update({'status': status.value}).eq('id', order_id).execute()
            return True
        except Exception as e:
            logging_service.error(f"Database error in update_order_status: {str(e)}")
            raise DatabaseError("Error updating order status")

    def update_order_kds_number(self, order_id: int, kds_number: int) -> bool:
        try:
            self.client.table('aps_order').update({'kds_order_number': kds_number}).eq('id', order_id).execute()
            return True
        except Exception as e:
            logging_service.error(f"Database error in update_order_kds_number: {str(e)}")
            raise DatabaseError("Error updating order KDS number")

    def get_order_with_items(self, order_id: int) -> APSOrderWithItems:
        try:
            result = self.client.table('aps_order_with_items').select('*').eq('id', order_id).execute()
            
            if result.data:
                return APSOrderWithItems(**result.data[0])
            raise DatabaseError("Order with items not found")
        except Exception as e:
            logging_service.error(f"Database error in get_order_with_items: {str(e)}")
            raise DatabaseError("Error getting order with items")

    def check_category_availability(self, aps_id: int, category: str) -> bool:
        try:
            menu = self.get_menu(aps_id)
            category_item_ids = [
                item.item_id 
                for item in menu.menu_items 
                if item.item_category == ItemCategory(category)
            ]
            
            if not category_item_ids:
                return False
                
            available_items = self.get_available_quantities(aps_id, category_item_ids)
            
            return any(
                item.available_quantity > 0 
                for item in available_items
            )
            
        except Exception as e:
            logging_service.error(f"Database error in check_category_availability: {str(e)}")
            raise DatabaseError(_("Error checking category availability"))

    def get_order_status(self, order_id: int) -> str:
        """Get the current status of an order."""
        try:
            result = self.client.table('aps_order').select('status').eq('id', order_id).execute()
            
            if result.data:
                return result.data[0]['status']
            raise DatabaseError(_("Order not found"))
        except Exception as e:
            logging_service.error(f"Database error in get_order_status: {str(e)}")
            raise DatabaseError(_("Error getting order status"))
        
    def cancel_order(self, order_id: int) -> bool:
        try:
            self.client.table('aps_order').update({'status': OrderStatus.CANCELED.value}).eq('id', order_id).execute()
            self.client.table('aps_order_item').delete().eq('aps_order_id', order_id).execute()
            return True
        except Exception as e:
            logging_service.error(f"Database error in cancel_order: {str(e)}")
            raise DatabaseError(_("Error cancelling order"))

    def update_order_phone_number(self, order_id: int, phone_number: str) -> bool:
        try:
            self.client.table('aps_order').update({
                'client_phone_number': phone_number
            }).eq('id', order_id).execute()
            return True
        except Exception as e:
            logging_service.error(f"Database error in update_order_phone_number: {str(e)}")
            raise DatabaseError(_("Error updating phone number"))

db = Database()
