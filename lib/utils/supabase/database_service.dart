import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/utils/supabase/aps_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/aps_order_repository.dart';
import 'package:kiosk_flutter/utils/supabase/item_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/menu_repository.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_function_repository.dart';

class DatabaseService {
  DatabaseService({
    ApsOrderRepository? orderRepository,
    ItemDescriptionRepository? itemDescriptionRepository,
    MenuRepository? menuRepository,
    ApsDescriptionRepository? apsDescriptionRepository,
    SupabaseFunctionRepository? storageStateRepository,
  })  : _orderRepository = orderRepository ?? ApsOrderRepository(),
        _itemDescriptionRepository = itemDescriptionRepository ?? ItemDescriptionRepository(),
        _storageStateRepository = storageStateRepository ?? SupabaseFunctionRepository();

  final ApsOrderRepository _orderRepository;
  final ItemDescriptionRepository _itemDescriptionRepository;
  final SupabaseFunctionRepository _storageStateRepository;

  Future<List<ItemDescription>> getAllItemDescriptions() {
    return _itemDescriptionRepository.getAllItemDescriptions();
  }

  Future<ApsOrder> createOrder(ApsOrder order) async {
    return await _orderRepository.createApsOrder(order: order);
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

  Future<void> createOrderItems(List<ApsOrderItem> orderItems) async {
    await _orderRepository.createApsOrderItems(orderItems: orderItems);
  }
}
