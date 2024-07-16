import 'dart:async';
import 'package:kiosk_flutter/models/exceptions/product_exception.dart';
import 'package:kiosk_flutter/models/menus/product.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  ProductRepository({
    SupabaseClient? client,
  }) : _client = client ?? SupabaseManager.instance.clientGlobalDB {
    _bucket = _client.storage.from('Product_Images');
  }

  final SupabaseClient _client;
  late final StorageFileApi _bucket;

  Future<List<Product>> getProducts({required String munchieId}) async {
    try {
      return await _client //
          .from('munchie_products_view')
          .select()
          .eq('munchie_id', munchieId)
          .then(_createProductWithImageUrl)
          .catchError((error) {
        print('Database error: $error');
        throw ProductException('Failed to get products due to database error');
      });
    } on ProductException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw ProductException('An error occurred while getting products: $e');
    }
  }

  // Future<List<Product>> getProducts({required List<String> ids}) async {
  //   try {
  //     return await _client //
  //         .from('products')
  //         .select()
  //         .inFilter('id', ids)
  //         .then(_createProductWithImageUrl)
  //         .catchError((error) {
  //       print('Database error: $error');
  //       throw ProductException('Failed to get products due to database error');
  //     });
  //   } on ProductException {
  //     rethrow;
  //   } catch (e) {
  //     print('Error: $e');
  //     throw ProductException('An error occurred while getting products: $e');
  //   }
  // }

  // Stream<List<Product>> munchieStream({required List<String> ids}) {
  //   return _client //
  //       .from('products')
  //       .stream(primaryKey: ['id'])
  //       .eq('id', munchieId)
  //       .limit(1)
  //       .map((munchies) => munchies.map(Munchie.fromJson).toList())
  //       .map((munchies) => munchies.first)
  //       .handleError((error) {
  //         print('Database error: $error');
  //         throw ProductException('Failed to get munchie due to database error');
  //       });
  // }

  FutureOr<List<Product>> _createProductWithImageUrl(List<Map<String, dynamic>> response) {
    return response //
        .map(Product.fromJson)
        .map((product) => (product.image == null) ? product : product.copyWith(imageBucketUrl: _bucket.getPublicUrl(product.image!)))
        .toList();
  }
}
