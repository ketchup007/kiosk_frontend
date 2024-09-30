import 'dart:async';
import 'package:kiosk_flutter/models/backend_exceptions.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kiosk_flutter/models/backend_models.dart';

class ItemDescriptionRepository {
  static const String _tableName = 'item_description';

  final SupabaseClient _client;

  /// Constructor that accepts an optional SupabaseClient. If none is provided,
  /// the default client from SupabaseManager is used.
  ItemDescriptionRepository({
    SupabaseClient? client,
  }) : _client = client ?? SupabaseManager.instance.clientLocalDB;

  /// Fetch a single item description by [id].
  ///
  /// [id] The ID of the item description to fetch.
  ///
  /// Returns an [ItemDescription] object.
  Future<ItemDescription> getItemDescriptionById(int id) async {
    try {
      final response = await _client.from(_tableName).select().eq('id', id).single();

      return ItemDescription.fromJson(response);
    } catch (error) {
      print('Database error: $error');
      throw ItemDescriptionException('Failed to fetch item description: $error');
    }
  }

  /// Stream that returns a list of ItemDescription objects based on a list of IDs.
  ///
  /// [ids] A list of IDs for which the item descriptions should be fetched.
  ///
  /// Returns a Stream of List<ItemDescription>.
  Stream<List<ItemDescription>> itemDescriptionsStream([List<int>? ids]) {
    final query = _client.from(_tableName).stream(primaryKey: ['id']);

    if (ids != null && ids.isNotEmpty) {
      query.inFilter('id', ids);
    }

    return query.map((items) => items.map<ItemDescription>((item) => ItemDescription.fromJson(item)).toList()).handleError((error) {
      print('Database stream error: $error');
      throw ItemDescriptionException('Failed to stream item descriptions: $error');
    });
  }

  /// Fetch all item descriptions.
  ///
  /// Returns a list of [ItemDescription] objects.
  Future<List<ItemDescription>> getAllItemDescriptions() async {
    try {
      final response = await _client.from(_tableName).select();

      return (response as List).map((item) => ItemDescription.fromJson(item)).toList();
    } catch (error) {
      print('Database error: $error');
      throw ItemDescriptionException('Failed to fetch item descriptions: $error');
    }
  }

  /// Create a new item description.
  ///
  /// [itemDescription] The [ItemDescription] object to create in the database.
  ///
  /// Returns nothing but throws an error if creation fails.
  Future<void> createItemDescription(ItemDescription itemDescription) async {
    try {
      await _client.from(_tableName).insert(itemDescription.toJson()).catchError((error) {
        print('Database error: $error');
        throw ItemDescriptionException('Failed to create item description: $error');
      });
    } catch (e) {
      print('Error: $e');
      throw ItemDescriptionException('An error occurred while creating the item description: $e');
    }
  }

  /// Update an existing item description.
  ///
  /// [id] The ID of the item description to update.
  /// [data] A map of updated key-value pairs (e.g., {'name_pl': 'New Name'}).
  ///
  /// Returns nothing but throws an error if updating fails.
  Future<void> updateItemDescription(int id, Map<String, dynamic> data) async {
    try {
      await _client.from(_tableName).update(data).eq('id', id).catchError((error) {
        print('Database error: $error');
        throw ItemDescriptionException('Failed to update item description: $error');
      });
    } catch (e) {
      print('Error: $e');
      throw ItemDescriptionException('An error occurred while updating the item description: $e');
    }
  }

  /// Delete an item description by [id].
  ///
  /// [id] The ID of the item description to delete.
  ///
  /// Returns nothing but throws an error if deletion fails.
  Future<void> deleteItemDescription(int id) async {
    try {
      await _client.from(_tableName).delete().eq('id', id).catchError((error) {
        print('Database error: $error');
        throw ItemDescriptionException('Failed to delete item description: $error');
      });
    } catch (e) {
      print('Error: $e');
      throw ItemDescriptionException('An error occurred while deleting the item description: $e');
    }
  }
}
