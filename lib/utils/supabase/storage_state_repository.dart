import 'dart:async';
import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/exceptions/menu_exception.dart';
import 'package:kiosk_flutter/models/storage/storage_state.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageStateRepository {
  StorageStateRepository({
    SupabaseClient? clientLocal,
  }) : _clientLocal = clientLocal ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _clientLocal;

  Future<List<StorageState>> getStorageState() async {
    try {
      return await _clientLocal //
          .from('storage_state')
          .select()
          .eq('munchie_id', AppConfig.instance.munchieId)
          .then((storageStates) => storageStates.map(StorageState.fromJson).toList())
          .catchError((error) {
        print('Database error: $error');
        throw MenuException('Failed to get storage states due to database error');
      });
    } on MenuException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw MenuException('An error occurred while storage states: $e');
    }
  }

  Stream<List<StorageState>> menuStream({required String menuId}) {
    return _clientLocal //
        .from('storage_state')
        .stream(primaryKey: ['id'])
        .map((storageStates) => storageStates.map(StorageState.fromJson).toList())
        .handleError((error) {
          print('Database error: $error');
          throw MenuException('Failed to get menu due to database error');
        });
  }

  Future<int> getStorageStateProduct(String productId) async {
    try {
      return await _clientLocal //
          .from('storage_state')
          .select()
          .eq('munchie_id', AppConfig.instance.munchieId)
          .eq('product_id', productId)
          .limit(1)
          .single()
          .then((value) => StorageState.fromJson(value))
          .then((value) => value.amount)
          .catchError((error) {
        print('Database error: $error');
        throw MenuException('Failed to get storage states due to database error');
      });
    } on MenuException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw MenuException('An error occurred while storage states: $e');
    }
  }
}
