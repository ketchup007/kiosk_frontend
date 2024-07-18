import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/menus/munchie_product.dart';
import 'package:kiosk_flutter/models/orders/order.dart';
import 'package:kiosk_flutter/models/orders/order_product.dart';
import 'package:kiosk_flutter/models/orders/order_status.dart';
import 'package:kiosk_flutter/models/storage/storage_state.dart';
import 'package:kiosk_flutter/utils/supabase/order_products_repository.dart';
import 'package:kiosk_flutter/utils/supabase/order_repository.dart';
import 'package:kiosk_flutter/utils/supabase/product_repository.dart';
import 'package:kiosk_flutter/utils/supabase/storage_state_repository.dart';

class DatabaseService {
  DatabaseService({
    // MunchieRepository? munchieRepostiory,
    // MenuRepository? menuRepository,
    ProductRepository? productRepository,
    OrderRepository? orderRepostiory,
    OrderProductsRepository? orderProductsRepository,
    StorageStateRepository? storageStateRepository,
    String? munchieId,
  })  :
        // _munchieRepostiory = munchieRepostiory ?? MunchieRepository(),
        // _menuRepository = menuRepository ?? MenuRepository(),
        _productRepository = productRepository ?? ProductRepository(),
        _orderRepository = orderRepostiory ?? OrderRepository(),
        _orderProductsRepository = orderProductsRepository ?? OrderProductsRepository(),
        _storageStateRepository = storageStateRepository ?? StorageStateRepository(),
        _munchieId = AppConfig.instance.munchieId;

  // final MunchieRepository _munchieRepostiory;
  // final MenuRepository _menuRepository;
  final ProductRepository _productRepository;
  final OrderRepository _orderRepository;
  final StorageStateRepository _storageStateRepository;
  final OrderProductsRepository _orderProductsRepository;
  final String _munchieId;

  Future<List<MunchieProduct>> getProduct({String languageId = 'pl'}) async {
    return await _productRepository.getProducts(munchieId: _munchieId, languageId: languageId);
  }

  Future<void> createOrder(Order order) async {
    await _orderRepository.createOrder(order);
  }

  Future<List<StorageState>> getStorageLimits() async {
    return await _storageStateRepository.getStorageState();
  }

  Future<void> updateOrderStatus(String id, OrderStatus status) async {
    await _orderRepository.updateOrder(id, {
      'status': status.toJson(),
    });
  }

  Future<void> updateOrderClientPhoneNumber(String id, String? phoneNumber) async {
    await _orderRepository.updateOrder(id, {
      'client_phone_number': phoneNumber,
    });
  }

  Future<int> updateOrderNumber(String id) async {
    final int orderNumber = await _orderRepository.getOrderNumber();
    await _orderRepository.updateOrder(id, {
      'kds_order_number': orderNumber,
    });
    return orderNumber;
  }

  Future<int> getStorageStateProduct(String productId) async {
    return await _storageStateRepository.getStorageStateProduct(productId);
  }

  Future<void> createOrderProducts(List<OrderProduct> orderProducts) async {
    await _orderProductsRepository.createOrderProducts(orderProducts);
  }
}
