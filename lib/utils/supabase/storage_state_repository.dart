import 'dart:async';
import 'package:kiosk_flutter/models/exceptions/menu_exception.dart';
import 'package:kiosk_flutter/models/storage/storage_state.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageStateRepository {
  StorageStateRepository({
    SupabaseClient? clientGlobal,
  }) : _clientGlobal = clientGlobal ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _clientGlobal;

  Future<List<StorageState>> getStorageState() async {
    try {
      // TODO: nie z lokalnej?
      return await _clientGlobal //
          .from('storage_state')
          .select()
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
    return _clientGlobal //
        .from('storage_state')
        .stream(primaryKey: ['id'])
        .map((storageStates) => storageStates.map(StorageState.fromJson).toList())
        .handleError((error) {
          print('Database error: $error');
          throw MenuException('Failed to get menu due to database error');
        });
  }
}
