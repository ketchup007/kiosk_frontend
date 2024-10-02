part of 'order_bloc.dart';

@freezedEvent
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.createNewOrder() = _CreateNewOrder;
  const factory OrderEvent.loadAvailableItems() = _LoadAvailableItems;
  const factory OrderEvent.loadMenuItemsWithDescriptions() = _LoadMenuItemsWithDescriptions;
  const factory OrderEvent.loadOrderItems() = _LoadOrderItems;
  const factory OrderEvent.changeTabCategory(TabCategory category) = _ChangeTabCategory;
  const factory OrderEvent.updatePhoneNumber(String phoneNumber) = _UpdatePhoneNumber;
  const factory OrderEvent.updateOrderStatus(OrderStatus status) = _UpdateOrderStatus;
  const factory OrderEvent.cancelOrder() = _CancelOrder;
  const factory OrderEvent.addItemToOrder(int itemId) = _AddItemToOrder;
  const factory OrderEvent.removeItemToOrder(int itemId) = _RemoveItemToOrder;
}
