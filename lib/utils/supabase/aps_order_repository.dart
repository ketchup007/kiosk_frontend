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
      return await _clientLocal //
          .from(_tableApsOrder)
          .select()
          .eq('id', orderId)
          .limit(1)
          .single()
          .then((value) => ApsOrder.fromJson(value))
          .catchError((error) {
        print('Database error: $error');
        throw OrderException('Failed to get APS order due to database error');
      });
    } on OrderException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw OrderException('An error occurred while getting APS order: $e');
    }
  }

  Future<void> createApsOrder({required ApsOrder order}) async {
    try {
      await _clientLocal //
          .from(_tableApsOrder)
          .insert(order.toJson())
          .catchError((error) {
        print('Database error: $error');
        throw OrderException('Failed to create APS order due to database error');
      });
    } on OrderException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw OrderException('An error occurred while creating APS order: $e');
    }
  }

  Future<void> updateApsOrder({required int orderId, required Map<String, dynamic> data}) async {
    try {
      await _clientLocal //
          .from(_tableApsOrder)
          .update(data)
          .eq('id', orderId)
          .catchError((error) {
        print('Database error: $error');
        throw OrderException('Failed to update APS order due to database error');
      });
    } on OrderException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw OrderException('An error occurred while updating APS order: $e');
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
      return await _clientLocal //
          .from(_tableApsOrder)
          .select('kds_order_number')
          .eq('aps_id', apsId)
          .order('id', ascending: false)
          .limit(1)
          .then((response) {
        if (response.isNotEmpty) {
          return response[0]['kds_order_number'] as int;
        } else {
          throw OrderException('No KDS order number found for APS ID: $apsId');
        }
      }).catchError((error) {
        print('Database error: $error');
        throw OrderException('Failed to get KDS order number due to database error');
      });
    } on OrderException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw OrderException('An error occurred while getting KDS order number: $e');
    }
  }

  Future<List<ApsOrderItem>> getApsOrderItems({required int orderId}) async {
    try {
      return await _clientLocal //
          .from(_tableApsOrderItem)
          .select()
          .eq('aps_order_id', orderId)
          .then((items) => items.map(ApsOrderItem.fromJson).toList())
          .catchError((error) {
        print('Database error: $error');
        throw OrderException('Failed to get APS order items due to database error');
      });
    } on OrderException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw OrderException('An error occurred while getting APS order items: $e');
    }
  }

  Future<void> createApsOrderItems({required List<ApsOrderItem> orderItems}) async {
    try {
      final itemsToInsert = orderItems.map((item) => item.toJson()).toList();

      await _clientLocal //
          .from(_tableApsOrderItem)
          .insert(itemsToInsert)
          .catchError((error) {
        print('Database error: $error');
        throw OrderException('Failed to create APS order items due to database error');
      });
    } on OrderException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw OrderException('An error occurred while creating APS order items: $e');
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
}
