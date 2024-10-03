import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/backend_exceptions.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/utils/supabase/aps_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/aps_order_repository.dart';
import 'package:kiosk_flutter/utils/supabase/item_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/menu_repository.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_function_repository.dart';
import 'package:rxdart/rxdart.dart';

class OrderService {
  OrderService({
    required ApsOrderRepository orderRepository,
    required MenuRepository menuRepository,
    required ItemDescriptionRepository itemRepository,
    required ApsDescriptionRepository apsRepository,
    required SupabaseFunctionRepository supabaseFunctionRepository,
  })  : _orderRepository = orderRepository,
        _menuRepository = menuRepository,
        _itemRepository = itemRepository,
        _apsRepository = apsRepository,
        _supabaseFunctionRepository = supabaseFunctionRepository;

  final ApsOrderRepository _orderRepository;
  final ItemDescriptionRepository _itemRepository;
  final MenuRepository _menuRepository;
  final ApsDescriptionRepository _apsRepository;
  final SupabaseFunctionRepository _supabaseFunctionRepository;

  final BehaviorSubject<ApsOrder?> _orderSubject = BehaviorSubject<ApsOrder?>();

  Future<void> createNewOrder() async {
    final newOrder = ApsOrder(
      apsId: AppConfig.instance.apsId,
      origin: OriginType.kiosk,
      status: OrderStatus.duringOrdering,
      estimatedTime: 0,
      kdsOrderNumber: null,
      pickupNumber: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final createdOrder = await _orderRepository.createApsOrder(order: newOrder);
    _orderSubject.add(createdOrder);
  }

  // Stream zamówienia z repozytorium, który nasłuchuje na zmiany w zamówieniu
  Stream<ApsOrder?> get orderStream {
    return _orderSubject.switchMap((order) {
      if (order != null && order.id != null) {
        return _orderRepository.streamApsOrder(orderId: order.id!);
      } else {
        return Stream.value(null);
      }
    });
  }

  // Stream dla elementów zamówienia
  Stream<List<ApsOrderItem>> apsOrderItemsStream() {
    return _orderSubject.switchMap((order) {
      if (order != null && order.id != null) {
        return _orderRepository.streamApsOrderItems(orderId: order.id!);
      } else {
        return Stream.value(<ApsOrderItem>[]);
      }
    });
  }

  // Zamknij stream, kiedy nie jest potrzebny
  void dispose() {
    _orderSubject.close();
  }

  Stream<List<AvailableItem>> availableItemStream({
    required int apsId,
  }) {
    final apsStream = _apsRepository.apsStream(apsId: apsId);

    return apsStream.switchMap((apsDescription) {
      final menuId = apsDescription.menuId;

      final menuItemPricesStream = _menuRepository.menuItemPriceStream(menuId: menuId);
      final apsOrdersStream = _orderRepository.streamAllApsOrders();
      final apsOrderItemsStream = _orderRepository.streamAllApsOrderItems();

      // Łączenie trzech strumieni w jeden (menuItems, APS Orders i APS Order Items)
      return Rx.combineLatest3(
        menuItemPricesStream,
        apsOrdersStream,
        apsOrderItemsStream,
        (List<MenuItemPrice> menuItems, List<ApsOrder> apsOrders, List<ApsOrderItem> apsOrderItems) {
          List<int> itemIds = menuItems.map((menuItem) => menuItem.itemId).toList();

          return itemIds;
        },
      ).switchMap((List<int> itemIds) {
        return Stream.fromFuture(_supabaseFunctionRepository.getAvailableItems(itemIds: itemIds));
      });
    });
  }

  Stream<List<MenuItemWithDescription>> menuItemsWithDescriptionsStream({
    required int apsId,
  }) {
    final apsStream = _apsRepository.apsStream(apsId: apsId);

    return apsStream.switchMap((apsDescription) {
      final menuId = apsDescription.menuId;

      final menuItemPricesStream = _menuRepository.menuItemPriceStream(menuId: menuId);

      return menuItemPricesStream.switchMap((menuItems) {
        List<int> itemIds = menuItems.map((menuItem) => menuItem.itemId).toList();

        final itemDescriptionsStream = _itemRepository.itemDescriptionsStream(itemIds);

        return Rx.combineLatest2<List<MenuItemPrice>, List<ItemDescription>, List<MenuItemWithDescription>>(
          menuItemPricesStream,
          itemDescriptionsStream,
          (menuItems, itemDescriptions) {
            return menuItems.map((menuItem) {
              final itemDescription = itemDescriptions.firstWhere(
                (description) => description.id == menuItem.itemId,
              );
              return MenuItemWithDescription(
                menuItemPrice: menuItem,
                itemDescription: itemDescription,
              );
            }).toList();
          },
        );
      });
    });
  }

  Future<void> cancelOrder() async {
    // Pobierz aktualne zamówienie ze strumienia
    final order = _orderSubject.valueOrNull;

    if (order != null && order.id != null) {
      try {
        // Aktualizacja statusu zamówienia na "canceled"
        final updateOrderStatus = _orderRepository.updateApsOrder(
          orderId: order.id!,
          data: {
            'status': OrderStatus.canceled.value,
          },
        );

        // Aktualizacja statusu wszystkich pozycji zamówienia na "canceled"
        final updateOrderItemsStatus = _orderRepository.deleteApsOrderItems(
          orderId: order.id!,
        );

        // Poczekaj na zakończenie obu operacji
        await Future.wait([updateOrderStatus, updateOrderItemsStatus]);

        // Zaktualizowanie stanu zamówienia, ustawienie na null
        _orderSubject.add(null);
      } catch (e) {
        print('Error canceling order: $e');
        throw OrderException('Failed to cancel the order');
      }
    }
  }

  Future<void> addItemToOrder(int itemId) async {
    final orderId = _orderSubject.valueOrNull?.id;
    if (orderId != null) {
      final newOrderItem = ApsOrderItem(
        apsId: AppConfig.instance.apsId,
        apsOrderId: orderId,
        itemId: itemId,
        status: ItemStatus.reserved,
      );

      await _orderRepository.createOrderItem(orderItem: newOrderItem);
    }
  }

  Future<void> removeItemFromOrder(int orderItemId) async {
    await _orderRepository.deleteOrderItem(orderItemId: orderItemId);
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    final orderId = _orderSubject.valueOrNull?.id;
    if (orderId != null) {
      await _orderRepository.updateApsOrder(
        orderId: orderId,
        data: {
          'client_phone_number': phoneNumber,
        },
      );
    }
  }

  Future<void> updateOrderStatus(OrderStatus newStatus) async {
    final orderId = _orderSubject.valueOrNull?.id;
    if (orderId != null) {
      await _orderRepository.updateApsOrder(
        orderId: orderId,
        data: {
          'status': newStatus.value,
        },
      );
    }
  }

  void finishOrder() {
    _orderSubject.add(null);
  }

  Future<int?> getKDSOrderNumber() async {
    // TODO: moze wyrzucanie exception? i jak nie bedzie zamowienia to ekran strartowy by zaczac od nowa?
    final orderId = _orderSubject.valueOrNull?.id;
    if (orderId != null) {
      final int orderNumber = await _orderRepository.getKdsOrderNumber(apsId: AppConfig.instance.apsId);
      await _orderRepository.updateApsOrder(
        orderId: orderId,
        data: {
          'kds_order_number': orderNumber,
        },
      );
      return orderNumber;
    }
    return null;
  }
}
