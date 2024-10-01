import 'dart:collection';

import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/utils/supabase/aps_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/item_description_repository.dart';
import 'package:kiosk_flutter/utils/supabase/menu_repository.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_function_repository.dart';
import 'package:rxdart/rxdart.dart';

class MenuService {
  MenuService({
    required MenuRepository menuRepository,
    required ItemDescriptionRepository itemRepository,
    required ApsDescriptionRepository apsRepository,
    required SupabaseFunctionRepository supabaseFunctionRepository,
  })  : _menuRepository = menuRepository,
        _itemRepository = itemRepository,
        _apsRepository = apsRepository,
        _supabaseFunctionRepository = supabaseFunctionRepository;

  final ItemDescriptionRepository _itemRepository;
  final MenuRepository _menuRepository;
  final ApsDescriptionRepository _apsRepository;
  final SupabaseFunctionRepository _supabaseFunctionRepository;

  final Map<int, int> _limits = HashMap();

  Stream<List<MenuItemWithDescription>> menuItemsWithDescriptionsStream({
    required int apsId,
  }) {
    final apsStream = _apsRepository.apsStream(apsId: apsId);

    return apsStream.switchMap((apsDescription) {
      final menuId = apsDescription.menuId;

      final menuItemPricesStream = _menuRepository.menuItemPriceStream(menuId: menuId);

      return menuItemPricesStream.switchMap((menuItems) {
        List<int> itemIds = menuItems.map((menuItem) => menuItem.itemId).toList();

        final itemDescriptionsStream = _itemRepository.itemDescriptionsStream(itemIds);

        return Rx.combineLatest2<List<MenuItemPrice>, List<ItemDescription>, List<MenuItemWithDescription>>(
          menuItemPricesStream,
          itemDescriptionsStream,
          (menuItems, itemDescriptions) {
            return menuItems.map((menuItem) {
              final itemDescription = itemDescriptions.firstWhere(
                (description) => description.id == menuItem.itemId,
              );
              return MenuItemWithDescription(
                menuItemPrice: menuItem,
                itemDescription: itemDescription,
              );
            }).toList();
          },
        );
      });
    });
  }

  //TODO: przeniesc raczej do order i po nasluchiwaniu zmiany zamowienia aktualizowac limity
  Future<void> refreshLimit(List<int> itemIds) async {
    return await _supabaseFunctionRepository.getAvailableItems(itemIds: itemIds).then((availableItems) {
      for (final availableItem in availableItems) {
        _limits[availableItem.itemId] = availableItem.availableQuantity;
      }
    });
  }
}
