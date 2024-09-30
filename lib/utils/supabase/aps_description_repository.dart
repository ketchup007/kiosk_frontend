import 'dart:async';
import 'package:kiosk_flutter/models/backend_exceptions.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository to handle operations related to APS descriptions in the database.
class ApsDescriptionRepository {
  static const String _tableName = 'aps_description';

  // Supabase client used to interact with the database
  final SupabaseClient _clientGlobal;

  /// Constructor that accepts an optional [clientGlobal]. If none is provided,
  /// the default client from [SupabaseManager] is used.
  ApsDescriptionRepository({
    SupabaseClient? clientGlobal,
  }) : _clientGlobal = clientGlobal ?? SupabaseManager.instance.clientLocalDB;

  /// Fetches an APS description by [apsId].
  ///
  /// [apsId] the ID of the APS description to fetch.
  ///
  /// Throws [ApsException] if any error occurs during the fetching process.
  Future<ApsDescription> getAps({required String apsId}) async {
    try {
      // Fetch the APS description by its ID
      final response = await _clientGlobal.from(_tableName).select().eq('id', apsId).limit(1).single();

      // Parse the response into an ApsDescription object
      return ApsDescription.fromJson(response);
    } catch (error) {
      print('Error fetching APS description: $error');
      throw ApsException('Failed to retrieve APS data: $error');
    }
  }

  /// Returns a stream of real-time updates for an APS description by [apsId].
  ///
  /// [apsId] the ID of the APS description to stream.
  ///
  /// Emits [ApsDescription] objects as updates occur in the database.
  Stream<ApsDescription> apsStream({required String apsId}) {
    return _clientGlobal
        .from(_tableName)
        .stream(primaryKey: ['id'])
        .eq('id', apsId)
        .limit(1)
        .map((data) {
          // Convert the data from JSON to a list of ApsDescription objects
          final apsDescriptions = data.map(ApsDescription.fromJson).toList();

          // Return the first (and only) APS description from the stream
          return apsDescriptions.first;
        })
        .handleError((error) {
          print('Error in APS stream: $error');
          throw ApsException('Failed to stream APS data: $error');
        });
  }
}
