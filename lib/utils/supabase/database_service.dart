import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/utils/supabase/aps_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/aps_order_repository.dart';
import 'package:kiosk_flutter/utils/supabase/item_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/menu_repository.dart';
import 'package:kiosk_flutter/utils/supabase/storage_state_repository.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseService {
  DatabaseService({
    ApsOrderRepository? orderRepository,
    ItemDescriptionRepository? itemDescriptionRepository,
    MenuRepository? menuRepository,
    ApsDescriptionRepository? apsDescriptionRepository,
    StorageStateRepository? storageStateRepository,
  })  : _orderRepository = orderRepository ?? ApsOrderRepository(),
        _itemDescriptionRepository = itemDescriptionRepository ?? ItemDescriptionRepository(),
        _menuRepository = menuRepository ?? MenuRepository(),
        _apsDescriptionRepository = apsDescriptionRepository ?? ApsDescriptionRepository(),
        _storageStateRepository = storageStateRepository ?? StorageStateRepository();

  final ApsOrderRepository _orderRepository;
  final ItemDescriptionRepository _itemDescriptionRepository;
  final MenuRepository _menuRepository;
  final ApsDescriptionRepository _apsDescriptionRepository;
  final StorageStateRepository _storageStateRepository;

  Future<List<ItemDescription>> getAllItemDescriptions() {
    return _itemDescriptionRepository.getAllItemDescriptions();
  }

  Future<void> createOrder(ApsOrder order) async {
    await _orderRepository.createApsOrder(order: order);
  }

  // Future<List<StorageState>> getStorageLimits() async {
  //   return await _storageStateRepository.getStorageState();
  // }

  Future<void> updateOrderStatus(int orderId, OrderStatus status) async {
    await _orderRepository.updateApsOrder(
      orderId: orderId,
      data: {
        'status': status.value,
      },
    );
  }

  Future<void> updateOrderClientPhoneNumber(int orderId, String? phoneNumber) async {
    await _orderRepository.updateApsOrder(
      orderId: orderId,
      data: {
        'client_phone_number': phoneNumber,
      },
    );
  }

  Future<int> updateOrderNumber({required int orderId}) async {
    final int orderNumber = await _orderRepository.getKdsOrderNumber(apsId: AppConfig.instance.apsId);
    await _orderRepository.updateApsOrder(
      orderId: orderId,
      data: {
        'kds_order_number': orderNumber,
      },
    );
    return orderNumber;
  }

  Future<List<AvailableItem>> getAvailableItems({required List<int> itemIds}) async {
    return await _storageStateRepository.getAvailableItems(itemIds: itemIds);
  }

  Future<void> createOrderItems(List<ApsOrderItem> orderItems) async {
    await _orderRepository.createApsOrderItems(orderItems: orderItems);
  }

  Stream<List<MenuItemWithDescription>> menuItemsWithDescriptionsStream({
    required int apsId,
  }) {
    // Pobieramy strumień ApsDescription na podstawie apsId
    final apsStream = _apsDescriptionRepository.apsStream(apsId: apsId);

    return apsStream.switchMap((apsDescription) {
      final menuId = apsDescription.menuId;

      final menuItemPricesStream = _menuRepository.menuItemPriceStream(menuId: menuId);

      return menuItemPricesStream.switchMap((menuItems) {
        List<int> itemIds = menuItems.map((menuItem) => menuItem.itemId).toList();

        final itemDescriptionsStream = _itemDescriptionRepository.itemDescriptionsStream(itemIds);

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
}
