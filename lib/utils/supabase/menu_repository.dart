import 'dart:async';
import 'package:kiosk_flutter/models/backend_exceptions.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MenuRepository {
  static const String _tableMenu = 'menu';
  static const String _tableMenuItemPrice = 'menu_item_price';

  MenuRepository({
    SupabaseClient? clientLocal,
  }) : _clientLocal = clientLocal ?? SupabaseManager.instance.clientLocalDB;

  final SupabaseClient _clientLocal;

  Future<Menu> getMenu({required int menuId}) async {
    try {
      return await _clientLocal //
          .from(_tableMenu)
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

  Stream<Menu> menuStream({required int menuId}) {
    return _clientLocal //
        .from(_tableMenu)
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

  Future<List<MenuItemPrice>> getMenuItems({required int menuId}) async {
    try {
      return await _clientLocal //
          .from(_tableMenuItemPrice)
          .select()
          .eq('id', menuId)
          .then((items) => items.map(MenuItemPrice.fromJson).toList())
          .catchError((error) {
        print('Database error: $error');
        throw MenuException('Failed to get menu products due to database error');
      });
    } on MenuException {
      rethrow;
    } catch (e) {
      print('Error: $e');
      throw MenuException('An error occurred while menu products: $e');
    }
  }

  Stream<List<MenuItemPrice>> menuItemPriceStream({required int menuId}) {
    return _clientLocal //
        .from(_tableMenuItemPrice)
        .stream(primaryKey: ['menu_id', 'item_id']) // Klucz główny
        .eq('menu_id', menuId)
        .map((items) => items.map(MenuItemPrice.fromJson).toList())
        .handleError((error) {
          print('Database error: $error');
          throw MenuException('Failed to get menu items due to database error');
        });
  }
}
