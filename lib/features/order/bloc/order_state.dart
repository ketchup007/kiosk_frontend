part of 'order_bloc.dart';

enum TabCategory { snack, drink, coffee, takeAwayBox, sauce, summary }

@freezedState
class OrderState with _$OrderState {
  const OrderState._();

  factory OrderState({
    @Default(LoadingStatus.none) LoadingStatus newOrderStatus,
    @Default(LoadingStatus.none) LoadingStatus availableItemsStatus,
    @Default(LoadingStatus.none) LoadingStatus menuItemsStatus,
    @Default(LoadingStatus.none) LoadingStatus orderItemsStatus,
    @Default(LoadingStatus.none) LoadingStatus orderChangeStatus,
    @Default(LoadingStatus.none) LoadingStatus kdsOrderNumberStatus,
    @Default(LoadingStatus.none) LoadingStatus cancelOrderStatus,
    @Default(LoadingStatus.none) LoadingStatus addItemStatus,
    @Default(LoadingStatus.none) LoadingStatus removeItemStatus,
    @Default(null) ApsOrder? order,
    @Default(TabCategory.snack) TabCategory selectedTab,
    @Default([]) List<AvailableItem> availableItems,
    @Default([]) List<MenuItemWithDescription> menuItemsWithDescriptions,
    @Default([]) List<ApsOrderItem> orderItems,
  }) = _OrderState;

  LoadingStatus get pageStatus => LoadingStatus.merge([
        newOrderStatus,
        availableItemsStatus,
        menuItemsStatus,
        orderItemsStatus,
      ]);

  LoadingStatus get buttonStatus => LoadingStatus.merge([
        cancelOrderStatus,
        addItemStatus,
        removeItemStatus,
      ]);

  List<MenuItemWithDescription> menuItemsByCategory(ItemCategory category) {
    return menuItemsWithDescriptions //
        .where((menuItem) => menuItem.itemDescription.category == category)
        .toList();
  }

  List<MenuItemWithDescription> menuItemsBySelectedTab() {
    return switch (selectedTab) {
      TabCategory.snack => menuItemsByCategory(ItemCategory.snack),
      TabCategory.drink => menuItemsByCategory(ItemCategory.drink),
      TabCategory.coffee => menuItemsByCategory(ItemCategory.coffee),
      TabCategory.takeAwayBox => menuItemsByCategory(ItemCategory.takeAwayBox),
      TabCategory.sauce => menuItemsByCategory(ItemCategory.sauce),
      TabCategory.summary => [],
    };
  }

  // Nowa funkcja obliczająca sumaryczną kwotę zamówienia
  double get totalOrderAmount {
    double total = 0.0;

    for (final orderItem in orderItems) {
      final menuItem = menuItemsWithDescriptions.firstWhereOrNull(
        (menuItem) => menuItem.menuItemPrice.itemId == orderItem.itemId,
      );

      if (menuItem != null) {
        total += menuItem.menuItemPrice.price;
      }
    }

    return total;
  }

  List<MenuItemWithDescription> suggestItemsForPurchase() {
    List<MenuItemWithDescription> suggestedItems = [];

    // Kategorię odpowiadające różnym typom produktów
    final List<ItemCategory> categories = [
      ItemCategory.snack,
      ItemCategory.drink,
      ItemCategory.coffee,
      ItemCategory.takeAwayBox,
      ItemCategory.sauce,
    ];

    for (final category in categories) {
      final categoryItems = menuItemsByCategory(category);

      // Sprawdzenie, czy jakikolwiek element z tej kategorii jest zamówiony
      bool hasOrder = categoryItems.any((menuItem) => orderItems.any((orderItem) => orderItem.itemId == menuItem.menuItemPrice.itemId));

      if (!hasOrder && categoryItems.isNotEmpty) {
        // Jeśli w zamówieniu nie ma elementów z tej kategorii, sprawdzamy dostępność
        final availableItem =
            categoryItems.firstWhereOrNull((menuItem) => availableItems.any((availableItem) => availableItem.itemId == menuItem.menuItemPrice.itemId && availableItem.availableQuantity > 0));

        // Dodaj pierwszy dostępny element do listy sugerowanych elementów
        if (availableItem != null) {
          suggestedItems.add(availableItem);
        }
      }
    }

    return suggestedItems;
  }

  int getQuantityOfItemInOrder(int itemId) {
    final orderedItems = orderItems.where((orderItem) => orderItem.itemId == itemId).toList();
    return orderedItems.length;
  }

  // Funkcja, która zwraca dostępny stan magazynowy dla danego itemId
  int getAvailableQuantity(int itemId) {
    final availableItem = availableItems.firstWhereOrNull(
      (item) => item.itemId == itemId,
    );

    return availableItem?.availableQuantity ?? 0;
  }

  List<MenuItemWithDescription> getOrderList() {
    List<MenuItemWithDescription> orderList = [];

    for (final menuItem in menuItemsWithDescriptions) {
      int itemQuantity = getQuantityOfItemInOrder(menuItem.itemDescription.id!);

      if (itemQuantity > 0) {
        orderList.add(menuItem);
      }
    }

    return orderList;
  }
}
