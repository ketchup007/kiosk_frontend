import 'package:equatable/equatable.dart';
import 'package:kiosk_flutter/models/backend_models.dart';

class MenuItemWithDescription extends Equatable {
  final MenuItemPrice menuItemPrice;
  final ItemDescription itemDescription;

  const MenuItemWithDescription({
    required this.menuItemPrice,
    required this.itemDescription,
  });

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'menuItemPrice': menuItemPrice.toJson(),
      'itemDescription': itemDescription.toJson(),
    };
  }

  // fromJson factory
  factory MenuItemWithDescription.fromJson(Map<String, dynamic> json) {
    return MenuItemWithDescription(
      menuItemPrice: MenuItemPrice.fromJson(json['menuItemPrice']),
      itemDescription: ItemDescription.fromJson(json['itemDescription']),
    );
  }

  // copyWith method
  MenuItemWithDescription copyWith({
    MenuItemPrice? menuItemPrice,
    ItemDescription? itemDescription,
  }) {
    return MenuItemWithDescription(
      menuItemPrice: menuItemPrice ?? this.menuItemPrice,
      itemDescription: itemDescription ?? this.itemDescription,
    );
  }

  @override
  String toString() {
    return 'MenuItemWithDescription(menuItemPrice: $menuItemPrice, itemDescription: $itemDescription)';
  }

  // Equatable props
  @override
  List<Object?> get props => [menuItemPrice, itemDescription];
}
