import 'dart:async';
import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/backend_exceptions.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFunctionRepository {
  SupabaseFunctionRepository({
    SupabaseClient? clientLocal,
  }) : _clientLocal = clientLocal ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _clientLocal;

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
      } else if (availableItemsResponse is List) {
        for (var value in availableItemsResponse) {
          availableItems.add(AvailableItem.fromJson(value as Map<String, dynamic>));
        }
      }

      return availableItems;
    } catch (e) {
      print('Error: $e');
      throw MenuException('An error occurred while fetching storage states: $e');
    }
  }
}
