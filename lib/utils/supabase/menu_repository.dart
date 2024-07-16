import 'dart:async';
import 'package:kiosk_flutter/models/exceptions/menu_exception.dart';
import 'package:kiosk_flutter/models/menus/menu.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MenuRepository {
  MenuRepository({
    SupabaseClient? clientGlobal,
  }) : _clientGlobal = clientGlobal ?? SupabaseManager.instance.clientGlobalDB;

  final SupabaseClient _clientGlobal;

  Future<Menu> getMenu({required String menuId}) async {
    try {
      // TODO: nie z lokalnej?
      return await _clientGlobal //
          .from('menus')
          .select()
          .eq('id', menuId)
          .limit(1)
          .single()
          .then((value) => Menu.fromJson(value))
          .catchError((error) {
        print('Database error: $error');
        throw MenuException('Failed to get menu due to database error');
      });
    } on MenuException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw MenuException('An error occurred while menu: $e');
    }
  }

  Stream<Menu> menuStream({required String menuId}) {
    return _clientGlobal //
        .from('menus')
        .stream(primaryKey: ['id'])
        .eq('id', menuId)
        .limit(1)
        .map((menus) => menus.map(Menu.fromJson).toList())
        .map((menus) => menus.first)
        .handleError((error) {
          print('Database error: $error');
          throw MenuException('Failed to get menu due to database error');
        });
  }
}
