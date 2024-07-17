import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/menus/munchie_product.dart';
import 'package:kiosk_flutter/models/storage/storage_state.dart';
import 'package:kiosk_flutter/utils/supabase/order_repository.dart';
import 'package:kiosk_flutter/utils/supabase/product_repository.dart';
import 'package:kiosk_flutter/utils/supabase/storage_state_repository.dart';

class DatabaseService {
  DatabaseService({
    // MunchieRepository? munchieRepostiory,
    // MenuRepository? menuRepository,
    ProductRepository? productRepository,
    OrderRepository? orderRepostiory,
    StorageStateRepository? storageStateRepository,
    String? munchieId,
  })  :
        // _munchieRepostiory = munchieRepostiory ?? MunchieRepository(),
        // _menuRepository = menuRepository ?? MenuRepository(),
        _productRepository = productRepository ?? ProductRepository(),
        _orderRepository = orderRepostiory ?? OrderRepository(),
        _storageStateRepository = storageStateRepository ?? StorageStateRepository(),
        _munchieId = AppConfig.instance.munchieId;

  // final MunchieRepository _munchieRepostiory;
  // final MenuRepository _menuRepository;
  final ProductRepository _productRepository;
  final OrderRepository _orderRepository;
  final StorageStateRepository _storageStateRepository;
  final String _munchieId;

  Future<List<MunchieProduct>> getProduct({String languageId = 'pl'}) async {
    return await _productRepository.getProducts(munchieId: _munchieId, languageId: languageId);
  }

  Future<String> createOrder() async {
    return await _orderRepository.createOrder();
  }

  Future<List<StorageState>> getStorageLimits() async {
    return await _storageStateRepository.getStorageState();
  }
}
