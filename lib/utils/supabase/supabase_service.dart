import '../../models/storage_limits_model.dart';
import '../../models/storage_model.dart';
import 'supabase_manager.dart';
import 'supabase_constants.dart';


class DatabaseService {
  Future<int> createOrder() async {
    final List<Map<String, dynamic>> data = await SupabaseManager.instance.clientLocalDB.from('Orders').insert({'kiosk_id': SupabaseConstants.kioskID}).select();
    final int orderId = data[0]['id'];
    return orderId;
  }

  Future<bool> updateOrderProduct(int id, String orderName, int value) async {
    await SupabaseManager.instance.clientLocalDB.from('Orders').update({ orderName: value }).match({ 'id': id});
    return true;
  }

  Future<bool> updateOrderStatus(int id, int value) async {
    await SupabaseManager.instance.clientLocalDB.from('Orders').update({'status': value}).match({'id': id});
    return true;
  }

  Future<bool> updateOrderClientPhoneNumber(int id, String phoneNumber) async {
    await SupabaseManager.instance.clientLocalDB.from('Orders').update({'status': 1, 'client_phone_number': phoneNumber}).match({'id': id});
    return true;
  }

  Future<int> updateOrderNumber(int id) async {
    final lastOrders = await SupabaseManager.instance.clientLocalDB.from('Orders').select('KDS_order_number').eq('kiosk_id', SupabaseConstants.kioskID).order('id', ascending: false).limit(2);
    int orderNumber;
    if (lastOrders.length == 2) {
      final int lastOrderNumber = lastOrders[1]['KDS_order_number'];
      if (lastOrderNumber < 99) {
        orderNumber = lastOrderNumber + 1;
      } else {
        orderNumber = 1;
      }
    } else {
      orderNumber = 1;
    }
    await SupabaseManager.instance.clientLocalDB.from('Orders').update({'status': 2, 'KDS_order_number': orderNumber}).match({'id': id});
    return orderNumber;
  }

  Future<List<StorageLimitsModel>?> getStorageLimits() async {
    String storageProducts = 'product_1, product_2, product_3, product_4, product_5, product_6, product_7, product_8, product_9, product_10, product_11, product_12, product_13, '
        'product_14, product_15, product_16, product_17, product_18, product_19, product_20, product_21, product_22, product_23';
    final storageState = await SupabaseManager.instance.clientLocalDB.from('Storage_State').select(storageProducts).eq('kiosk_id', SupabaseConstants.kioskID).limit(1);
    List<Map<String, dynamic>> formattedStorageState = storageState.expand((map) => map.entries.map((entry) => {
      'product_key': entry.key,
      'quantity': entry.value
    })).toList();
    List<StorageLimitsModel> storageLimits = formattedStorageState.map((data) {
      return StorageLimitsModel.fromJson({
        'product_key': data['product_key'],
        'quantity': data['quantity'],
      });
    }).toList();
    return storageLimits;
  }

  Future<int> getStorageStateProduct(product) async {
    final storageState = await SupabaseManager.instance.clientLocalDB.from('Storage_State').select(product).eq('kiosk_id', SupabaseConstants.kioskID).limit(1);
    final int productQuantity = storageState[0][product];
    return productQuantity;
  }

  Future<List<StorageModel>>  getProductInformation() async {
     final productsInformation = await SupabaseManager.instance.clientGlobalDB.from('Products_Information').select('*');
     List<StorageModel> productsInformationList = productsInformation.map( (data) {
       return StorageModel.fromJson({
         'product_key': data['product_key'],
         'name_pl': data['name_pl'],
         'name_en': data['name_en'],
         'ingredients_pl': data['ingredients_pl'],
         'ingredients_en': data['ingredients_en'],
         'price': data['price'],
         'type': data['type'],
         'image': data['image']
       });
     }).toList();
     return productsInformationList;
  }
}

