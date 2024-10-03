import 'dart:async';
import 'package:kiosk_flutter/models/backend_exceptions.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApsOrderRepository {
  static const String _tableApsOrder = 'aps_order';
  static const String _tableApsOrderItem = 'aps_order_item';
  // static const String _tableApsOrderHistory = 'aps_order_history';
  // static const String _tableApsOrderItemHistory = 'aps_order_item_history';

  ApsOrderRepository({
    SupabaseClient? clientLocal,
  }) : _clientLocal = clientLocal ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _clientLocal;

  Future<ApsOrder> getApsOrder({required int orderId}) async {
    try {
      final response = await _clientLocal //
          .from(_tableApsOrder)
          .select()
          .eq('id', orderId)
          .limit(1)
          .single();

      return ApsOrder.fromJson(response);
    } catch (e) {
      print('Error while fetching APS order: $e');
      throw OrderException('Failed to get APS order with ID: $orderId');
    }
  }

  Future<ApsOrder> createApsOrder({required ApsOrder order}) async {
    try {
      final response = await _clientLocal //
          .from(_tableApsOrder)
          .insert(order.toJson())
          .select()
          .single();

      return ApsOrder.fromJson(response);
    } catch (e) {
      print('Error while creating APS order: $e');
      throw OrderException('Failed to create APS order');
    }
  }

  Future<void> updateApsOrder({
    required int orderId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _clientLocal //
          .from(_tableApsOrder)
          .update(data)
          .eq('id', orderId);
    } catch (e) {
      print('Error while updating APS order: $e');
      throw OrderException('Failed to update APS order with ID: $orderId');
    }
  }

  // Future<void> updateApsOrderStatus(String orderId, OrderStatus newStatus) async {
  //   try {
  //     await _clientLocal //
  //         .from(_tableApsOrder)
  //         .update({'status': newStatus.value})
  //         .eq('id', orderId)
  //         .catchError((error) {
  //           print('Database error: $error');
  //           throw OrderException('Failed to update APS order status due to database error');
  //         });

  //     // Add a new entry to the order history
  //     await _clientLocal //
  //         .from(_tableApsOrderHistory)
  //         .insert({
  //       'aps_order_id': orderId,
  //       'status': newStatus.value,
  //       'timestamp': DateTime.now().toIso8601String(),
  //     }).catchError((error) {
  //       print('Database error: $error');
  //       throw OrderException('Failed to add APS order history due to database error');
  //     });
  //   } on OrderException {
  //     rethrow;
  //   } catch (e) {
  //     print('Error: $e');
  //     throw OrderException('An error occurred while updating APS order status: $e');
  //   }
  // }

  Future<int> getKdsOrderNumber({required int apsId}) async {
    try {
      final response = await _clientLocal //
          .from(_tableApsOrder)
          .select('kds_order_number')
          .eq('aps_id', apsId)
          .order('id', ascending: false)
          .limit(1)
          .single();

      return response['kds_order_number'] as int;
    } catch (e) {
      print('Error while fetching KDS order number: $e');
      throw OrderException('Failed to get KDS order number for APS ID: $apsId');
    }
  }

  Future<List<ApsOrderItem>> getApsOrderItems({required int orderId}) async {
    try {
      final items = await _clientLocal //
          .from(_tableApsOrderItem)
          .select()
          .eq('aps_order_id', orderId);

      return items.map<ApsOrderItem>(ApsOrderItem.fromJson).toList();
    } catch (e) {
      print('Error while fetching APS order items: $e');
      throw OrderException('Failed to get APS order items for order ID: $orderId');
    }
  }

  // Future<List<ApsOrderHistory>> getApsOrderHistory({required String orderId}) async {
  //   try {
  //     return await _clientLocal
  //         .from(_tableApsOrderHistory)
  //         .select()
  //         .eq('aps_order_id', orderId)
  //         .order('timestamp', ascending: true)
  //         .then((history) => history.map(ApsOrderHistory.fromJson).toList())
  //         .catchError((error) {
  //       print('Database error: $error');
  //       throw OrderException('Failed to get APS order history due to database error');
  //     });
  //   } on OrderException {
  //     rethrow;
  //   } catch (e) {
  //     print('Error: $e');
  //     throw OrderException('An error occurred while getting APS order history: $e');
  //   }
  // }

  // Future<List<ApsOrderItemHistory>> getApsOrderItemHistory({required String orderItemId}) async {
  //   try {
  //     return await _clientLocal
  //         .from(_tableApsOrderItemHistory)
  //         .select()
  //         .eq('aps_order_item_id', orderItemId)
  //         .order('timestamp', ascending: true)
  //         .then((history) => history.map(ApsOrderItemHistory.fromJson).toList())
  //         .catchError((error) {
  //       print('Database error: $error');
  //       throw OrderException('Failed to get APS order item history due to database error');
  //     });
  //   } on OrderException {
  //     rethrow;
  //   } catch (e) {
  //     print('Error: $e');
  //     throw OrderException('An error occurred while getting APS order item history: $e');
  //   }
  // }

  Stream<ApsOrder> streamApsOrder({required int orderId}) {
    return _clientLocal //
        .from(_tableApsOrder)
        .stream(primaryKey: ['id'])
        .eq('id', orderId)
        .limit(1)
        .map((orderData) {
          if (orderData.isNotEmpty) {
            return ApsOrder.fromJson(orderData.first);
          } else {
            throw OrderException('No APS order found with ID: $orderId');
          }
        })
        .handleError((error) {
          print('Database error: $error');
          throw OrderException('Failed to stream APS order: $error');
        });
  }

  Stream<List<ApsOrderItem>> streamApsOrderItems({required int orderId}) {
    return _clientLocal //
        .from(_tableApsOrderItem)
        .stream(primaryKey: ['id'])
        .eq('aps_order_id', orderId)
        .map((itemsData) => itemsData.map<ApsOrderItem>((item) => ApsOrderItem.fromJson(item)).toList())
        .handleError((error) {
          print('Database error: $error');
          throw OrderException('Failed to stream APS order items: $error');
        });
  }

  Stream<List<ApsOrder>> streamAllApsOrders() {
    return _clientLocal //
        .from(_tableApsOrder)
        .stream(primaryKey: ['id'])
        .map((ordersData) => ordersData.map<ApsOrder>((order) => ApsOrder.fromJson(order)).toList())
        .handleError((error) {
          print('Database error: $error');
          throw OrderException('Failed to stream all APS orders: $error');
        });
  }

  Stream<List<ApsOrderItem>> streamAllApsOrderItems() {
    return _clientLocal //
        .from(_tableApsOrderItem)
        .stream(primaryKey: ['id'])
        .map((itemsData) => itemsData.map<ApsOrderItem>((item) => ApsOrderItem.fromJson(item)).toList())
        .handleError((error) {
          print('Database error: $error');
          throw OrderException('Failed to stream all APS order items: $error');
        });
  }

  Future<void> updateApsOrderItems({
    required int orderId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _clientLocal //
          .from(_tableApsOrderItem)
          .update(data)
          .eq('aps_order_id', orderId);
    } catch (e) {
      print('Error while updating APS order items: $e');
      throw OrderException('Failed to update APS order items for order ID: $orderId');
    }
  }

  Future<void> deleteApsOrderItems({
    required int orderId,
  }) async {
    try {
      await _clientLocal //
          .from(_tableApsOrderItem)
          .delete()
          .eq('aps_order_id', orderId);
    } catch (e) {
      print('Error while deleting APS order items: $e');
      throw OrderException('Failed to delete APS order items for order ID: $orderId');
    }
  }

  Future<void> deleteOrderItem({required int orderItemId}) async {
    try {
      await _clientLocal //
          .from(_tableApsOrderItem)
          .delete()
          .eq('id', orderItemId);
    } catch (e) {
      throw OrderException('Failed to delete APS order item ID: $orderItemId');
    }
  }

  Future<void> createOrderItem({required ApsOrderItem orderItem}) async {
    try {
      await _clientLocal //
          .from(_tableApsOrderItem)
          .insert(orderItem.toJson());
    } catch (e) {
      throw OrderException('Failed to create APS order item');
    }
  }
}
