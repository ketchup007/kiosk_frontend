import 'dart:async';
import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/backend_exceptions.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageStateRepository {
  StorageStateRepository({
    SupabaseClient? clientLocal,
  }) : _clientLocal = clientLocal ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _clientLocal;

  // Future<List<StorageState>> getStorageState() async {
  //   try {
  //     return await _clientLocal //
  //         .from('storage_state')
  //         .select()
  //         .eq('munchie_id', AppConfig.instance.munchieId)
  //         .then((storageStates) => storageStates.map(StorageState.fromJson).toList())
  //         .catchError((error) {
  //       print('Database error: $error');
  //       throw MenuException('Failed to get storage states due to database error');
  //     });
  //   } on MenuException {
  //     rethrow;
  //   } catch (e) {
  //     print('Error: $e');
  //     throw MenuException('An error occurred while storage states: $e');
  //   }
  // }

  // Stream<List<StorageState>> menuStream({required String menuId}) {
  //   return _clientLocal //
  //       .from('storage_state')
  //       .stream(primaryKey: ['id'])
  //       .map((storageStates) => storageStates.map(StorageState.fromJson).toList())
  //       .handleError((error) {
  //         print('Database error: $error');
  //         throw MenuException('Failed to get menu due to database error');
  //       });
  // }

  Future<List<AvailableItem>> getAvailableItems({required List<int> itemIds}) async {
    try {
      final apsId = AppConfig.instance.apsId;

      final availableItemsResponse = await _clientLocal.rpc(
        'get_available_items',
        params: {
          'aps_id_input': apsId,
          'item_ids': itemIds,
        },
      );

      List<AvailableItem> availableItems = [];

      if (availableItemsResponse is Map) {
        availableItemsResponse.forEach((key, value) {
          availableItems.add(AvailableItem.fromJson(value as Map<String, dynamic>));
        });
      } else {
        availableItemsResponse.forEach((value) {
          availableItems.add(AvailableItem.fromJson(value as Map<String, dynamic>));
        });
      }

      return availableItems;
    } catch (e) {
      print('Error: $e');
      throw MenuException('An error occurred while fetching storage states: $e');
    }
  }
}
