import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/utils/supabase/aps_order_repository.dart';

class ApsOrderService {
  ApsOrderService({
    required ApsOrderRepository orderRepository,
  }) : _orderRepository = orderRepository;

  final ApsOrderRepository _orderRepository;

  ApsOrder? _order;

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

    _order = await _orderRepository.createApsOrder(order: newOrder);
  }

  Future initalize() async {
    _order = null;

    _orderRepository.
  }
}
