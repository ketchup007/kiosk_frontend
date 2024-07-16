import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/orders/order.dart';
import 'package:kiosk_flutter/models/exceptions/order_exception.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepository {
  OrderRepository({
    SupabaseClient? client,
  }) : _client = client ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _client;

  Future<String> createOrder() async {
    try {
      return await _client
          .from('orders')
          .insert({'munchie_id': AppConfig.instance.munchieId})
          .select()
          .single()
          .then((response) {
            return Order.fromJson(response).id;
          })
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

  // Future<bool> updateOrderProduct(String id, String orderName, int value) async {
  //   await _client //
  //       .from('orders')
  //       .update({orderName: value}).match({'id': id});
  //   return true;
  // }

  // Future<bool> updateOrderStatus(String id, int value) async {
  //   await _client //
  //       .from('orders')
  //       .update({'status': value}).match({'id': id});
  //   return true;
  // }

  // Future<bool> updateOrderClientPhoneNumber(String id, String phoneNumber) async {
  //   await _client //
  //       .from('orders')
  //       .update({'status': 1, 'client_phone_number': phoneNumber}).match({'id': id});
  //   return true;
  // }

  // Future<int> updateOrderNumber(String id) async {
  //   final lastorders = await _client //
  //       .from('orders')
  //       .select('KDS_order_number')
  //       .eq('munchie_id', AppConfig.instance.munchieId)
  //       .order('id', ascending: false)
  //       .limit(2);

  //   int orderNumber;
  //   if (lastorders.length == 2) {
  //     final int lastOrderNumber = lastorders[1]['KDS_order_number'];
  //     if (lastOrderNumber < 99) {
  //       orderNumber = lastOrderNumber + 1;
  //     } else {
  //       orderNumber = 1;
  //     }
  //   } else {
  //     orderNumber = 1;
  //   }
  //   await _client //
  //       .from('orders')
  //       .update({'status': 2, 'KDS_order_number': orderNumber}).match({'id': id});
  //   return orderNumber;
  // }

  // Future<List<StorageLimitsModel>?> getStorageLimits() async {
  //   String storageProducts = 'product_1, product_2, product_3, product_4, product_5, product_6, product_7, product_8, product_9, product_10, product_11, product_12, product_13, '
  //       'product_14, product_15, product_16, product_17, product_18, product_19, product_20, product_21, product_22, product_23';

  //   final storageState = await _client.from('Storage_State').select(storageProducts).eq('munchie_id', AppConfig.instance.munchieId).limit(1);
  //   List<Map<String, dynamic>> formattedStorageState = storageState.expand((map) => map.entries.map((entry) => {'product_key': entry.key, 'quantity': entry.value})).toList();
  //   List<StorageLimitsModel> storageLimits = formattedStorageState.map((data) {
  //     return StorageLimitsModel.fromJson({
  //       'product_key': data['product_key'],
  //       'quantity': data['quantity'],
  //     });
  //   }).toList();
  //   return storageLimits;
  // }

  // Future<int> getStorageStateProduct(product) async {
  //   final storageState = await _client.from('Storage_State').select(product).eq('munchie_id', AppConfig.instance.munchieId).limit(1);
  //   final int productQuantity = storageState[0][product];
  //   return productQuantity;
  // }

  // Future<List<StorageModel>> getProductInformation() async {
  //   final productsInformation = await _clientGlobal.from('Products_Information').select('*');
  //   final bucket = _clientGlobal.storage.from('Product_Images');
  //   List<StorageModel> productsInformationList = productsInformation.map((data) {
  //     return StorageModel.fromJson({
  //       'product_key': data['product_key'],
  //       'name_pl': data['name_pl'],
  //       'name_en': data['name_en'],
  //       'ingredients_pl': data['ingredients_pl'],
  //       'ingredients_en': data['ingredients_en'],
  //       'price': data['price'],
  //       'type': data['type'],
  //       'image': bucket.getPublicUrl(data['image']),
  //     });
  //   }).toList();
  //   return productsInformationList;
  // }
}
