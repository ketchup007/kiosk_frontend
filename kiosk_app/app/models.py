from enum import Enum
from datetime import datetime
from typing import List, Optional, Dict
from pydantic import BaseModel, Field

class ItemCategory(Enum):
    SNACK = 'snack'
    DRINK = 'drink'
    COFFEE = 'coffee'
    TAKE_AWAY_BOX = 'take_away_box'
    SAUCE = 'sauce'
    PAPER_TRAY = 'paper_tray'
    CUP = 'cup'
    SUGAR = 'sugar'

class APSState(Enum):
    ACTIVE = 'active'
    INACTIVE = 'inactive'
    MALFUNCTION = 'malfunction'
    DURING_DELIVERY = 'during_delivery'

class OrderOrigin(Enum):
    KIOSK = 'kiosk'
    PHONE = 'phone'

class OrderStatus(Enum):
    DURING_ORDERING = 'during_ordering'
    PAYMENT_IN_PROGRESS = 'payment_in_progress'
    PAID = 'paid'
    ACCEPTED_FOR_EXECUTION = 'accepted_for_execution'
    ORDER_PROCESSING_HAS_STARTED = 'order_processing_has_started'
    FIRST_ITEM_WAITING_FOR_RECIPIENT = 'first_item_waiting_for_recipient'
    READY_FOR_PICKUP = 'ready_for_pickup'
    PICKED_UP = 'picked_up'
    CANCELED = 'canceled'

class ItemStatus(Enum):
    RESERVED = 'reserved'
    QUEUED = 'queued'
    PLACING_TRAY = 'placing_tray'
    TRAY_PLACED = 'tray_placed'
    DRINK_POSITION_RESERVED = 'drink_position_reserved'
    COFFEE_POSITION_RESERVED = 'coffee_position_reserved'
    BAG_POSITION_RESERVED = 'bag_position_reserved'
    IN_R1_ARM = 'in_r1_arm'
    PRE_BAKING = 'pre_baking'
    REMAINING_BAKING = 'remaining_baking'
    READY_TO_CREATE_DATA = 'ready_to_create_data'
    READY_TO_PICK_R2 = 'ready_to_pick_R2'
    IN_R2_ARM = 'in_r2_arm'
    ON_CONVEYOR = 'on_conveyor'
    READY_TO_RECEIVE = 'ready_to_receive'
    WAITING_FOR_CLIENT = 'waiting_for_client'
    RECEIVED = 'received'
    CANCELED = 'canceled'

class PickupNumber(Enum):
    ONE = '1'
    TWO = '2'
    THREE = '3'

class ItemDescription(BaseModel):
    id: Optional[int] = None
    name_pl: str
    name_en: str
    name_ua: str
    description_pl: Optional[str]
    description_en: Optional[str]
    description_ua: Optional[str]
    allergens_pl: Optional[str]
    allergens_en: Optional[str]
    allergens_ua: Optional[str]
    category: ItemCategory
    image: Optional[str]
    price: Optional[float] = 0.0
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'name_pl': self.name_pl,
            'name_en': self.name_en,
            'name_ua': self.name_ua,
            'description_pl': self.description_pl,
            'description_en': self.description_en,
            'description_ua': self.description_ua,
            'allergens_pl': self.allergens_pl,
            'allergens_en': self.allergens_en,
            'allergens_ua': self.allergens_ua,
            'category': self.category.value,
            'image': self.image,
            'price': self.price
        }

class Menu(BaseModel):
    id: int
    name: str
    description: Optional[str]
    created_at: datetime
    updated_at: datetime

class MenuItemPrice(BaseModel):
    menu_id: int
    item_id: int
    price: float
    created_at: datetime
    updated_at: datetime

class Storage(BaseModel):
    id: int
    storage_name: str
    created_at: datetime
    updated_at: datetime

class StorageItemSlot(BaseModel):
    storage_id: int
    item_description_id: Optional[int]
    slot_name: str
    current_quantity: int = 0
    max_quantity: int = 0
    created_at: datetime
    updated_at: datetime

class APSDescription(BaseModel):
    id: int
    name: str
    address: str
    location: str  # This should be a Point type, but we'll use string for simplicity
    storage_id: int
    menu_id: int
    state: APSState
    created_at: datetime
    updated_at: datetime

class APSOrder(BaseModel):
    id: int
    aps_id: int
    origin: OrderOrigin
    status: OrderStatus
    pickup_number: Optional[PickupNumber]
    kds_order_number: Optional[int]
    client_phone_number: Optional[str]
    estimated_time: int = 0 
    created_at: datetime
    updated_at: datetime

class APSOrderItemCreate(BaseModel):
    aps_order_id: int
    aps_id: int
    item_id: int
    status: ItemStatus
    created_at: datetime = Field(default_factory=datetime.now)
    updated_at: datetime = Field(default_factory=datetime.now)

class APSOrderWithItems(BaseModel):
    id: int
    aps_id: int
    origin: OrderOrigin
    status: OrderStatus
    pickup_number: Optional[PickupNumber]
    kds_order_number: Optional[int]
    client_phone_number: Optional[str]
    estimated_time: int
    created_at: datetime
    updated_at: datetime
    items: List[ItemDescription]

    class Config:
        from_attributes = True

    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'aps_id': self.aps_id,
            'origin': self.origin.value,
            'status': self.status.value,
            'pickup_number': self.pickup_number.value if self.pickup_number else None,
            'kds_order_number': self.kds_order_number,
            'client_phone_number': self.client_phone_number,
            'estimated_time': self.estimated_time,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat(),
            'items': [item.to_dict() for item in self.items]
        }

class APSMenuItem(BaseModel):
    item_id: int
    name_pl: str
    name_en: str
    name_ua: str
    description_pl: Optional[str]
    description_en: Optional[str]
    description_ua: Optional[str]
    allergens_pl: Optional[str]
    allergens_en: Optional[str]
    allergens_ua: Optional[str]
    category: ItemCategory
    image: Optional[str]
    price: float

class APSMenuItems(BaseModel):
    aps_id: int
    aps_name: str
    menu_id: int
    menu_name: str
    menu_items: List[APSMenuItem]

class AvailableItem(BaseModel):
    item_id: int
    available_quantity: int

class SuggestedProduct(BaseModel):
    item_id: int
    name_pl: str
    name_en: str
    name_ua: str
    category: ItemCategory
    image: Optional[str]
    price: float
    stock_quantity: int

class EstimatedWaitingTime(BaseModel):
    aps_id: int
    order_id: int
    estimated_time: int
