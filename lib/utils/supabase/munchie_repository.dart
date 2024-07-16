import 'dart:async';
import 'package:kiosk_flutter/models/exceptions/product_exception.dart';
import 'package:kiosk_flutter/models/munchies/munchie.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MunchieRepository {
  MunchieRepository({
    SupabaseClient? clientGlobal,
  }) : _clientGlobal = clientGlobal ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _clientGlobal;

  Future<Munchie> getMunchie({required String munchieId}) async {
    try {
      return await _clientGlobal //
          .from('munchies')
          .select()
          .eq('id', munchieId)
          .limit(1)
          .single()
          .then((value) => Munchie.fromJson(value))
          .catchError((error) {
        print('Database error: $error');
        throw ProductException('Failed to get munchie due to database error');
      });
    } on ProductException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw ProductException('An error occurred while getting munchie: $e');
    }
  }

  Stream<Munchie> munchieStream({required String munchieId}) {
    return _clientGlobal //
        .from('munchies')
        .stream(primaryKey: ['id'])
        .eq('id', munchieId)
        .limit(1)
        .map((munchies) => munchies.map(Munchie.fromJson).toList())
        .map((munchies) => munchies.first)
        .handleError((error) {
          print('Database error: $error');
          throw ProductException('Failed to get munchie due to database error');
        });
  }
}
