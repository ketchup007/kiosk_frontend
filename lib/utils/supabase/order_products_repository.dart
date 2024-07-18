import 'dart:async';
import 'package:kiosk_flutter/models/exceptions/order_exception.dart';
import 'package:kiosk_flutter/models/orders/order_product.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderProductsRepository {
  OrderProductsRepository({
    SupabaseClient? client,
  }) : _client = client ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _client;

  Future<void> createOrderProducts(List<OrderProduct> orderProducts) async {
    try {
      return await _client //
          .from('order_products')
          .insert(orderProducts.map((e) => e.toJson()).toList())
          .catchError((error) {
        print('Database error: $error');
        throw OrderException('Failed to create order due to database error');
      });
    } on OrderException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw OrderException('An error occurred while creating the order: $e');
    }
  }
}
