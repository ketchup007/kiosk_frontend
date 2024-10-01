import 'package:equatable/equatable.dart';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class Storage with EquatableMixin {
  final int? id;
  final String storageName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Storage({
    this.id,
    required this.storageName,
    this.createdAt,
    this.updatedAt,
  });

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      id: json['id'],
      storageName: json['storage_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'storage_name': storageName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Storage copyWith({
    int? id,
    String? storageName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Storage(
      id: id ?? this.id,
      storageName: storageName ?? this.storageName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, storageName, createdAt, updatedAt];
}

class StorageItemSlot with EquatableMixin {
  final int storageId;
  final int? itemDescriptionId;
  final String slotName;
  final int currentQuantity;
  final int maxQuantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StorageItemSlot({
    required this.storageId,
    this.itemDescriptionId,
    required this.slotName,
    required this.currentQuantity,
    required this.maxQuantity,
    this.createdAt,
    this.updatedAt,
  });

  factory StorageItemSlot.fromJson(Map<String, dynamic> json) {
    return StorageItemSlot(
      storageId: json['storage_id'],
      itemDescriptionId: json['item_description_id'],
      slotName: json['slot_name'],
      currentQuantity: json['current_quantity'],
      maxQuantity: json['max_quantity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storage_id': storageId,
      'item_description_id': itemDescriptionId,
      'slot_name': slotName,
      'current_quantity': currentQuantity,
      'max_quantity': maxQuantity,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  StorageItemSlot copyWith({
    int? storageId,
    int? itemDescriptionId,
    String? slotName,
    int? currentQuantity,
    int? maxQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StorageItemSlot(
      storageId: storageId ?? this.storageId,
      itemDescriptionId: itemDescriptionId ?? this.itemDescriptionId,
      slotName: slotName ?? this.slotName,
      currentQuantity: currentQuantity ?? this.currentQuantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [storageId, itemDescriptionId, slotName, currentQuantity, maxQuantity, createdAt, updatedAt];
}

class ApsOrderHistory with EquatableMixin {
  final int apsOrderId;
  final int apsId;
  final DateTime timestamp;
  final OrderStatus status;

  const ApsOrderHistory({
    required this.apsOrderId,
    required this.apsId,
    required this.timestamp,
    required this.status,
  });

  factory ApsOrderHistory.fromJson(Map<String, dynamic> json) {
    return ApsOrderHistory(
      apsOrderId: json['aps_order_id'],
      apsId: json['aps_id'],
      timestamp: DateTime.parse(json['timestamp']),
      status: OrderStatus.fromString(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aps_order_id': apsOrderId,
      'aps_id': apsId,
      'timestamp': timestamp.toIso8601String(),
      'status': status.value,
    };
  }

  ApsOrderHistory copyWith({
    int? apsOrderId,
    int? apsId,
    DateTime? timestamp,
    OrderStatus? status,
  }) {
    return ApsOrderHistory(
      apsOrderId: apsOrderId ?? this.apsOrderId,
      apsId: apsId ?? this.apsId,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [apsOrderId, apsId, timestamp, status];
}

class ApsOrderItemHistory with EquatableMixin {
  final int apsOrderItemId;
  final int apsOrderId;
  final int apsId;
  final DateTime timestamp;
  final ItemStatus status;

  const ApsOrderItemHistory({
    required this.apsOrderItemId,
    required this.apsOrderId,
    required this.apsId,
    required this.timestamp,
    required this.status,
  });

  factory ApsOrderItemHistory.fromJson(Map<String, dynamic> json) {
    return ApsOrderItemHistory(
      apsOrderItemId: json['aps_order_item_id'],
      apsOrderId: json['aps_order_id'],
      apsId: json['aps_id'],
      timestamp: DateTime.parse(json['timestamp']),
      status: ItemStatus.fromString(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aps_order_item_id': apsOrderItemId,
      'aps_order_id': apsOrderId,
      'aps_id': apsId,
      'timestamp': timestamp.toIso8601String(),
      'status': status.value,
    };
  }

  ApsOrderItemHistory copyWith({
    int? apsOrderItemId,
    int? apsOrderId,
    int? apsId,
    DateTime? timestamp,
    ItemStatus? status,
  }) {
    return ApsOrderItemHistory(
      apsOrderItemId: apsOrderItemId ?? this.apsOrderItemId,
      apsOrderId: apsOrderId ?? this.apsOrderId,
      apsId: apsId ?? this.apsId,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [apsOrderItemId, apsOrderId, apsId, timestamp, status];
}

enum StorageOrderStatus {
  preparedForProduction('prepared_for_production'),
  packed('packed'),
  onTheWay('on_the_way'),
  delivered('delivered'),
  cancelled('cancelled');

  final String value;
  const StorageOrderStatus(this.value);

  factory StorageOrderStatus.fromString(String str) {
    return StorageOrderStatus.values.firstWhere((e) => e.value == str);
  }

  @override
  String toString() => value;
}

enum StorageOrderPurpose {
  restocking('restocking'),
  disposal('disposal'),
  return_('return');

  final String value;
  const StorageOrderPurpose(this.value);

  factory StorageOrderPurpose.fromString(String str) {
    return StorageOrderPurpose.values.firstWhere((e) => e.value == str);
  }

  @override
  String toString() => value;
}

class User with EquatableMixin {
  final int? id;
  final String username;
  final String email;
  final String? fullName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['full_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'username': username,
      'email': email,
      'full_name': fullName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? fullName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, username, email, fullName, createdAt, updatedAt];
}

class Vehicle with EquatableMixin {
  final int? id;
  final String vehicleIdentifier;
  final String licensePlate;
  final int? capacity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Vehicle({
    this.id,
    required this.vehicleIdentifier,
    required this.licensePlate,
    this.capacity,
    this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      vehicleIdentifier: json['vehicle_identifier'],
      licensePlate: json['license_plate'],
      capacity: json['capacity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'vehicle_identifier': vehicleIdentifier,
      'license_plate': licensePlate,
      'capacity': capacity,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Vehicle copyWith({
    int? id,
    String? vehicleIdentifier,
    String? licensePlate,
    int? capacity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Vehicle(
      id: id ?? this.id,
      vehicleIdentifier: vehicleIdentifier ?? this.vehicleIdentifier,
      licensePlate: licensePlate ?? this.licensePlate,
      capacity: capacity ?? this.capacity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, vehicleIdentifier, licensePlate, capacity, createdAt, updatedAt];
}

class Trolley with EquatableMixin {
  final int? id;
  final String trolleyNumber;
  final int? maxCapacity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Trolley({
    this.id,
    required this.trolleyNumber,
    this.maxCapacity,
    this.createdAt,
    this.updatedAt,
  });

  factory Trolley.fromJson(Map<String, dynamic> json) {
    return Trolley(
      id: json['id'],
      trolleyNumber: json['trolley_number'],
      maxCapacity: json['max_capacity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'trolley_number': trolleyNumber,
      'max_capacity': maxCapacity,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Trolley copyWith({
    int? id,
    String? trolleyNumber,
    int? maxCapacity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Trolley(
      id: id ?? this.id,
      trolleyNumber: trolleyNumber ?? this.trolleyNumber,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, trolleyNumber, maxCapacity, createdAt, updatedAt];
}

class StorageOrder with EquatableMixin {
  final int? id;
  final DateTime deliveryDay;
  final int source;
  final int destination;
  final StorageOrderStatus status;
  final int? enteredBy;
  final int? preparedBy;
  final int? packedBy;
  final int? deliveredBy;
  final int? vehicleId;
  final StorageOrderPurpose purpose;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StorageOrder({
    this.id,
    required this.deliveryDay,
    required this.source,
    required this.destination,
    required this.status,
    this.enteredBy,
    this.preparedBy,
    this.packedBy,
    this.deliveredBy,
    this.vehicleId,
    required this.purpose,
    this.createdAt,
    this.updatedAt,
  });

  factory StorageOrder.fromJson(Map<String, dynamic> json) {
    return StorageOrder(
      id: json['id'],
      deliveryDay: DateTime.parse(json['delivery_day']),
      source: json['source'],
      destination: json['destination'],
      status: StorageOrderStatus.fromString(json['storage_order_status']),
      enteredBy: json['entered_by'],
      preparedBy: json['prepared_by'],
      packedBy: json['packed_by'],
      deliveredBy: json['delivered_by'],
      vehicleId: json['vehicle_id'],
      purpose: StorageOrderPurpose.fromString(json['storage_order_purpose']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'delivery_day': deliveryDay.toIso8601String(),
      'source': source,
      'destination': destination,
      'storage_order_status': status.value,
      'entered_by': enteredBy,
      'prepared_by': preparedBy,
      'packed_by': packedBy,
      'delivered_by': deliveredBy,
      'vehicle_id': vehicleId,
      'storage_order_purpose': purpose.value,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  StorageOrder copyWith({
    int? id,
    DateTime? deliveryDay,
    int? source,
    int? destination,
    StorageOrderStatus? status,
    int? enteredBy,
    int? preparedBy,
    int? packedBy,
    int? deliveredBy,
    int? vehicleId,
    StorageOrderPurpose? purpose,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StorageOrder(
      id: id ?? this.id,
      deliveryDay: deliveryDay ?? this.deliveryDay,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      status: status ?? this.status,
      enteredBy: enteredBy ?? this.enteredBy,
      preparedBy: preparedBy ?? this.preparedBy,
      packedBy: packedBy ?? this.packedBy,
      deliveredBy: deliveredBy ?? this.deliveredBy,
      vehicleId: vehicleId ?? this.vehicleId,
      purpose: purpose ?? this.purpose,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, deliveryDay, source, destination, status, enteredBy, preparedBy, packedBy, deliveredBy, vehicleId, purpose, createdAt, updatedAt];
}

class StorageOrderItem with EquatableMixin {
  final int storageOrderId;
  final int itemDescriptionId;
  final int quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StorageOrderItem({
    required this.storageOrderId,
    required this.itemDescriptionId,
    required this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory StorageOrderItem.fromJson(Map<String, dynamic> json) {
    return StorageOrderItem(
      storageOrderId: json['storage_order_id'],
      itemDescriptionId: json['item_description_id'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storage_order_id': storageOrderId,
      'item_description_id': itemDescriptionId,
      'quantity': quantity,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  StorageOrderItem copyWith({
    int? storageOrderId,
    int? itemDescriptionId,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StorageOrderItem(
      storageOrderId: storageOrderId ?? this.storageOrderId,
      itemDescriptionId: itemDescriptionId ?? this.itemDescriptionId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [storageOrderId, itemDescriptionId, quantity, createdAt, updatedAt];
}

class StorageOrderTrolley with EquatableMixin {
  final int storageOrderId;
  final int trolleyId;
  final String? positionInVehicle;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StorageOrderTrolley({
    required this.storageOrderId,
    required this.trolleyId,
    this.positionInVehicle,
    this.createdAt,
    this.updatedAt,
  });

  factory StorageOrderTrolley.fromJson(Map<String, dynamic> json) {
    return StorageOrderTrolley(
      storageOrderId: json['storage_order_id'],
      trolleyId: json['trolley_id'],
      positionInVehicle: json['position_in_vehicle'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storage_order_id': storageOrderId,
      'trolley_id': trolleyId,
      'position_in_vehicle': positionInVehicle,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  StorageOrderTrolley copyWith({
    int? storageOrderId,
    int? trolleyId,
    String? positionInVehicle,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StorageOrderTrolley(
      storageOrderId: storageOrderId ?? this.storageOrderId,
      trolleyId: trolleyId ?? this.trolleyId,
      positionInVehicle: positionInVehicle ?? this.positionInVehicle,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [storageOrderId, trolleyId, positionInVehicle, createdAt, updatedAt];
}

enum ItemCategory {
  snack('snack'),
  drink('drink'),
  coffee('coffee'),
  takeAwayBox('take_away_box'),
  sauce('sauce'),
  paperTray('paper_tray'),
  cup('cup'),
  sugar('sugar');

  final String value;
  const ItemCategory(this.value);

  factory ItemCategory.fromString(String str) {
    return ItemCategory.values.firstWhere((e) => e.value == str);
  }

  @override
  String toString() => value;
}

class ItemDescription with EquatableMixin {
  final int? id;
  final String namePl;
  final String nameEn;
  final String nameUa;
  final String? descriptionPl;
  final String? descriptionEn;
  final String? descriptionUa;
  final String? allergensPl;
  final String? allergensEn;
  final String? allergensUa;
  final ItemCategory category;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ItemDescription({
    this.id,
    required this.namePl,
    required this.nameEn,
    required this.nameUa,
    this.descriptionPl,
    this.descriptionEn,
    this.descriptionUa,
    this.allergensPl,
    this.allergensEn,
    this.allergensUa,
    required this.category,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemDescription.fromJson(Map<String, dynamic> json) {
    return ItemDescription(
      id: json['id'],
      namePl: json['name_pl'],
      nameEn: json['name_en'],
      nameUa: json['name_ua'],
      descriptionPl: json['description_pl'],
      descriptionEn: json['description_en'],
      descriptionUa: json['description_ua'],
      allergensPl: json['allergens_pl'],
      allergensEn: json['allergens_en'],
      allergensUa: json['allergens_ua'],
      category: ItemCategory.fromString(json['category']),
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name_pl': namePl,
      'name_en': nameEn,
      'name_ua': nameUa,
      'description_pl': descriptionPl,
      'description_en': descriptionEn,
      'description_ua': descriptionUa,
      'allergens_pl': allergensPl,
      'allergens_en': allergensEn,
      'allergens_ua': allergensUa,
      'category': category.value,
      'image': image,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ItemDescription copyWith({
    int? id,
    String? namePl,
    String? nameEn,
    String? nameUa,
    String? descriptionPl,
    String? descriptionEn,
    String? descriptionUa,
    String? allergensPl,
    String? allergensEn,
    String? allergensUa,
    ItemCategory? category,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ItemDescription(
      id: id ?? this.id,
      namePl: namePl ?? this.namePl,
      nameEn: nameEn ?? this.nameEn,
      nameUa: nameUa ?? this.nameUa,
      descriptionPl: descriptionPl ?? this.descriptionPl,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionUa: descriptionUa ?? this.descriptionUa,
      allergensPl: allergensPl ?? this.allergensPl,
      allergensEn: allergensEn ?? this.allergensEn,
      allergensUa: allergensUa ?? this.allergensUa,
      category: category ?? this.category,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, namePl, nameEn, nameUa, descriptionPl, descriptionEn, descriptionUa, allergensPl, allergensEn, allergensUa, category, image, createdAt, updatedAt];

  String name(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'pl':
        return namePl;
      case 'en':
        return nameEn;
      case 'ua':
        return nameUa;
      default:
        return nameEn;
    }
  }

  String description(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'pl':
        return descriptionPl ?? '';
      case 'en':
        return descriptionEn ?? '';
      case 'ua':
        return descriptionUa ?? '';
      default:
        return descriptionEn ?? '';
    }
  }

  String allergens(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'pl':
        return allergensPl ?? '';
      case 'en':
        return allergensEn ?? '';
      case 'ua':
        return allergensUa ?? '';
      default:
        return allergensEn ?? '';
    }
  }
}

class Menu with EquatableMixin {
  final int? id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Menu({
    this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Menu copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Menu(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, description, createdAt, updatedAt];
}

class MenuItemPrice with EquatableMixin {
  final int menuId;
  final int itemId;
  final double price;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MenuItemPrice({
    required this.menuId,
    required this.itemId,
    required this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory MenuItemPrice.fromJson(Map<String, dynamic> json) {
    return MenuItemPrice(
      menuId: json['menu_id'],
      itemId: json['item_id'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_id': menuId,
      'item_id': itemId,
      'price': price,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  MenuItemPrice copyWith({
    int? menuId,
    int? itemId,
    double? price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MenuItemPrice(
      menuId: menuId ?? this.menuId,
      itemId: itemId ?? this.itemId,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [menuId, itemId, price, createdAt, updatedAt];
}

class Point {
  final double latitude;
  final double longitude;

  const Point({
    required this.latitude,
    required this.longitude,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    if (json['location'] is String) {
      // Handle WKB format
      return Point.fromWKB(json['location']);
    } else if (json['location'] is Map) {
      // Handle GeoJSON-like format
      var coords = json['location']['coordinates'];
      return Point(longitude: coords[0], latitude: coords[1]);
    } else {
      // Handle direct lat/long format
      return Point(
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'location': {
        'type': 'Point',
        'coordinates': [longitude, latitude]
      }
    };
  }

  /// Factory constructor to create a Point from a WKB (Well-Known Binary) string.
  factory Point.fromWKB(String wkb) {
    Uint8List bytes = _hexStringToBytes(wkb);
    ByteData byteData = ByteData.sublistView(bytes);

    // Check endian format
    int endian = byteData.getUint8(0);
    Endian byteOrder = (endian == 0) ? Endian.big : Endian.little;

    // The next 4 bytes (1-4) are the geometry type, which includes SRID if 0x20 is set.
    int geometryType = byteData.getUint32(1, Endian.little);

    // Check if the SRID flag is present (0x20 in the geometry type field)
    bool hasSRID = (geometryType & 0x20000000) != 0;

    int offset = 5; // Initial offset after reading endian and geometry type

    if (hasSRID) {
      offset += 4; // SRID occupies 4 bytes, move offset past it
    }

    // Read longitude and latitude
    double longitude = byteData.getFloat64(offset, byteOrder);
    double latitude = byteData.getFloat64(offset + 8, byteOrder);

    return Point(latitude: latitude, longitude: longitude);
  }

  /// Converts this Point into WKB (Well-Known Binary) format.
  String toWKB() {
    ByteData byteData = ByteData(21); // 1 byte for byte order, 4 bytes for type, 4 bytes for SRID, 8 bytes each for longitude and latitude

    // Set the byte order to little-endian (1 byte)
    byteData.setUint8(0, 1);

    // Set the type to Point with SRID (4 bytes)
    byteData.setUint32(1, 0x20000001, Endian.little);

    // Set the SRID to 4326 (WGS84) (4 bytes)
    byteData.setUint32(5, 4326, Endian.little);

    // Set the longitude (8 bytes)
    byteData.setFloat64(9, longitude, Endian.little);

    // Set the latitude (8 bytes)
    byteData.setFloat64(17, latitude, Endian.little);

    // Convert ByteData to a hexadecimal string
    return _bytesToHexString(byteData.buffer.asUint8List());
  }

  /// Helper function to convert a hex string to bytes.
  static Uint8List _hexStringToBytes(String hex) {
    List<int> bytes = [];
    for (int i = 0; i < hex.length; i += 2) {
      String byteString = hex.substring(i, i + 2);
      int byte = int.parse(byteString, radix: 16);
      bytes.add(byte);
    }
    return Uint8List.fromList(bytes);
  }

  /// Helper function to convert bytes to a hexadecimal string.
  static String _bytesToHexString(Uint8List bytes) {
    StringBuffer buffer = StringBuffer();
    for (int byte in bytes) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }

  @override
  String toString() {
    return 'POINT($longitude $latitude)';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is Point && runtimeType == other.runtimeType && latitude == other.latitude && longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  Point copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Point(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

enum ApsState {
  active('active'),
  inactive('inactive'),
  malfunction('malfunction'),
  duringDelivery('during_delivery');

  final String value;
  const ApsState(this.value);

  factory ApsState.fromString(String str) {
    return ApsState.values.firstWhere((e) => e.value == str);
  }

  @override
  String toString() => value;
}

class ApsDescription with EquatableMixin {
  final int? id;
  final String name;
  final String address;
  final Point location;
  final int storageId;
  final int menuId;
  final ApsState state;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ApsDescription({
    this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.storageId,
    required this.menuId,
    required this.state,
    this.createdAt,
    this.updatedAt,
  });

  factory ApsDescription.fromJson(Map<String, dynamic> json) {
    return ApsDescription(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      location: Point.fromWKB(json['location']),
      storageId: json['storage_id'],
      menuId: json['menu_id'],
      state: ApsState.fromString(json['state']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'address': address,
      'location': location.toString(),
      'storage_id': storageId,
      'menu_id': menuId,
      'state': state.value,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ApsDescription copyWith({
    int? id,
    String? name,
    String? address,
    Point? location,
    int? storageId,
    int? menuId,
    ApsState? state,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ApsDescription(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      storageId: storageId ?? this.storageId,
      menuId: menuId ?? this.menuId,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, address, location, storageId, menuId, state, createdAt, updatedAt];
}

enum OriginType {
  kiosk('kiosk'),
  phone('phone');

  final String value;
  const OriginType(this.value);

  factory OriginType.fromString(String str) {
    return OriginType.values.firstWhere((e) => e.value == str);
  }

  @override
  String toString() => value;
}

enum OrderStatus {
  duringOrdering('during_ordering'),
  paymentInProgress('payment_in_progress'),
  paid('paid'),
  acceptedForExecution('accepted_for_execution'),
  orderProcessingHasStarted('order_processing_has_started'),
  firstItemWaitingForRecipient('first_item_waiting_for_recipient'),
  readyForPickup('ready_for_pickup'),
  pickedUp('picked_up'),
  canceled('canceled');

  final String value;
  const OrderStatus(this.value);

  factory OrderStatus.fromString(String str) {
    return OrderStatus.values.firstWhere((e) => e.value == str);
  }

  @override
  String toString() => value;
}

enum PickupNumber {
  one('1'),
  two('2'),
  three('3');

  final String value;
  const PickupNumber(this.value);

  factory PickupNumber.fromString(String str) {
    return PickupNumber.values.firstWhere((e) => e.value == str);
  }

  @override
  String toString() => value;
}

class ApsOrder with EquatableMixin {
  final int? id;
  final int apsId;
  final OriginType origin;
  final OrderStatus status;
  final PickupNumber? pickupNumber;
  final int? kdsOrderNumber;
  final String? clientPhoneNumber;
  final int estimatedTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ApsOrder({
    this.id,
    required this.apsId,
    required this.origin,
    required this.status,
    this.pickupNumber,
    this.kdsOrderNumber,
    this.clientPhoneNumber,
    required this.estimatedTime,
    this.createdAt,
    this.updatedAt,
  });

  factory ApsOrder.fromJson(Map<String, dynamic> json) {
    return ApsOrder(
      id: json['id'],
      apsId: json['aps_id'],
      origin: OriginType.fromString(json['origin']),
      status: OrderStatus.fromString(json['status']),
      pickupNumber: PickupNumber.fromString(json['pickup_number']),
      kdsOrderNumber: json['kds_order_number'],
      clientPhoneNumber: json['client_phone_number'],
      estimatedTime: json['estimated_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'aps_id': apsId,
      'origin': origin.value,
      'status': status.value,
      'pickup_number': pickupNumber?.value,
      'kds_order_number': kdsOrderNumber,
      'client_phone_number': clientPhoneNumber,
      'estimated_time': estimatedTime,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ApsOrder copyWith({
    int? id,
    int? apsId,
    OriginType? origin,
    OrderStatus? status,
    PickupNumber? pickupNumber,
    int? kdsOrderNumber,
    String? clientPhoneNumber,
    int? estimatedTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ApsOrder(
      id: id ?? this.id,
      apsId: apsId ?? this.apsId,
      origin: origin ?? this.origin,
      status: status ?? this.status,
      pickupNumber: pickupNumber ?? this.pickupNumber,
      kdsOrderNumber: kdsOrderNumber ?? this.kdsOrderNumber,
      clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, apsId, origin, status, pickupNumber, kdsOrderNumber, clientPhoneNumber, estimatedTime, createdAt, updatedAt];
}

enum ItemStatus {
  reserved('reserved'),
  queued('queued'),
  placingTray('placing_tray'),
  trayPlaced('tray_placed'),
  drinkPositionReserved('drink_position_reserved'),
  coffeePositionReserved('coffee_position_reserved'),
  bagPositionReserved('bag_position_reserved'),
  inR1Arm('in_r1_arm'),
  preBaking('pre_baking'),
  remainingBaking('remaining_baking'),
  readyToCreateData('ready_to_create_data'),
  readyToPickR2('ready_to_pick_R2'),
  inR2Arm('in_r2_arm'),
  onConveyor('on_conveyor'),
  readyToReceive('ready_to_receive'),
  waitingForClient('waiting_for_client'),
  received('received'),
  canceled('canceled');

  final String value;
  const ItemStatus(this.value);

  factory ItemStatus.fromString(String str) {
    return ItemStatus.values.firstWhere((e) => e.value == str);
  }

  @override
  String toString() => value;
}

class ApsOrderItem with EquatableMixin {
  final int? id;
  final int apsOrderId;
  final int apsId;
  final int itemId;
  final ItemStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ApsOrderItem({
    this.id,
    required this.apsOrderId,
    required this.apsId,
    required this.itemId,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ApsOrderItem.fromJson(Map<String, dynamic> json) {
    return ApsOrderItem(
      id: json['id'],
      apsOrderId: json['aps_order_id'],
      apsId: json['aps_id'],
      itemId: json['item_id'],
      status: ItemStatus.fromString(json['status']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'aps_order_id': apsOrderId,
      'aps_id': apsId,
      'item_id': itemId,
      'status': status.value,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ApsOrderItem copyWith({
    int? id,
    int? apsOrderId,
    int? apsId,
    int? itemId,
    ItemStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ApsOrderItem(
      id: id ?? this.id,
      apsOrderId: apsOrderId ?? this.apsOrderId,
      apsId: apsId ?? this.apsId,
      itemId: itemId ?? this.itemId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, apsOrderId, apsId, itemId, status, createdAt, updatedAt];
}

class Waypoint with EquatableMixin {
  final int? id;
  final String? waypointName;
  final double x;
  final double y;
  final double z;
  final double qx;
  final double qy;
  final double qz;
  final double qw;
  final double? offsetX;
  final double? offsetY;
  final double? offsetZ;
  final double? offsetQx;
  final double? offsetQy;
  final double? offsetQz;
  final double? offsetQw;
  final double? qrRotation;
  final double? ovenRotation;

  Waypoint({
    this.id,
    this.waypointName,
    required this.x,
    required this.y,
    required this.z,
    required this.qx,
    required this.qy,
    required this.qz,
    required this.qw,
    this.offsetX,
    this.offsetY,
    this.offsetZ,
    this.offsetQx,
    this.offsetQy,
    this.offsetQz,
    this.offsetQw,
    this.qrRotation,
    this.ovenRotation,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) {
    return Waypoint(
      id: json['id'],
      waypointName: json['waypoint_name'],
      x: json['x'],
      y: json['y'],
      z: json['z'],
      qx: json['qx'],
      qy: json['qy'],
      qz: json['qz'],
      qw: json['qw'],
      offsetX: json['offset_x'],
      offsetY: json['offset_y'],
      offsetZ: json['offset_z'],
      offsetQx: json['offset_qx'],
      offsetQy: json['offset_qy'],
      offsetQz: json['offset_qz'],
      offsetQw: json['offset_qw'],
      qrRotation: json['qr_rotation'],
      ovenRotation: json['oven_rotation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'waypoint_name': waypointName,
      'x': x,
      'y': y,
      'z': z,
      'qx': qx,
      'qy': qy,
      'qz': qz,
      'qw': qw,
      'offset_x': offsetX,
      'offset_y': offsetY,
      'offset_z': offsetZ,
      'offset_qx': offsetQx,
      'offset_qy': offsetQy,
      'offset_qz': offsetQz,
      'offset_qw': offsetQw,
      'qr_rotation': qrRotation,
      'oven_rotation': ovenRotation,
    };
  }

  Waypoint copyWith({
    int? id,
    String? waypointName,
    double? x,
    double? y,
    double? z,
    double? qx,
    double? qy,
    double? qz,
    double? qw,
    double? offsetX,
    double? offsetY,
    double? offsetZ,
    double? offsetQx,
    double? offsetQy,
    double? offsetQz,
    double? offsetQw,
    double? qrRotation,
    double? ovenRotation,
  }) {
    return Waypoint(
      id: id ?? this.id,
      waypointName: waypointName ?? this.waypointName,
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
      qx: qx ?? this.qx,
      qy: qy ?? this.qy,
      qz: qz ?? this.qz,
      qw: qw ?? this.qw,
      offsetX: offsetX ?? this.offsetX,
      offsetY: offsetY ?? this.offsetY,
      offsetZ: offsetZ ?? this.offsetZ,
      offsetQx: offsetQx ?? this.offsetQx,
      offsetQy: offsetQy ?? this.offsetQy,
      offsetQz: offsetQz ?? this.offsetQz,
      offsetQw: offsetQw ?? this.offsetQw,
      qrRotation: qrRotation ?? this.qrRotation,
      ovenRotation: ovenRotation ?? this.ovenRotation,
    );
  }

  @override
  List<Object?> get props => [id, waypointName, x, y, z, qx, qy, qz, qw, offsetX, offsetY, offsetZ, offsetQx, offsetQy, offsetQz, offsetQw, qrRotation, ovenRotation];
}

class Path with EquatableMixin {
  final int? id;
  final int? fromWaypointId;
  final int? toWaypointId;

  Path({
    this.id,
    this.fromWaypointId,
    this.toWaypointId,
  });

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
      id: json['id'],
      fromWaypointId: json['from_waypoint_id'],
      toWaypointId: json['to_waypoint_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'from_waypoint_id': fromWaypointId,
      'to_waypoint_id': toWaypointId,
    };
  }

  Path copyWith({
    int? id,
    int? fromWaypointId,
    int? toWaypointId,
  }) {
    return Path(
      id: id ?? this.id,
      fromWaypointId: fromWaypointId ?? this.fromWaypointId,
      toWaypointId: toWaypointId ?? this.toWaypointId,
    );
  }

  @override
  List<Object?> get props => [id, fromWaypointId, toWaypointId];
}

class PathWaypoint with EquatableMixin {
  final int? id;
  final int? sequence;
  final int? waypointId;
  final int? pathId;

  PathWaypoint({
    this.id,
    this.sequence,
    this.waypointId,
    this.pathId,
  });

  factory PathWaypoint.fromJson(Map<String, dynamic> json) {
    return PathWaypoint(
      id: json['id'],
      sequence: json['sequence'],
      waypointId: json['waypoint_id'],
      pathId: json['path_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'sequence': sequence,
      'waypoint_id': waypointId,
      'path_id': pathId,
    };
  }

  PathWaypoint copyWith({
    int? id,
    int? sequence,
    int? waypointId,
    int? pathId,
  }) {
    return PathWaypoint(
      id: id ?? this.id,
      sequence: sequence ?? this.sequence,
      waypointId: waypointId ?? this.waypointId,
      pathId: pathId ?? this.pathId,
    );
  }

  @override
  List<Object?> get props => [id, sequence, waypointId, pathId];
}

class AvailableItem {
  final int itemId;
  final int availableQuantity;

  AvailableItem({
    required this.itemId,
    required this.availableQuantity,
  });

  // Factory constructor to create AvailableItem from a JSON object
  factory AvailableItem.fromJson(Map<String, dynamic> json) {
    return AvailableItem(
      itemId: json['item_id'] as int,
      availableQuantity: json['available_quantity'] as int,
    );
  }

  // Method to convert AvailableItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'available_quantity': availableQuantity,
    };
  }

  AvailableItem copyWith({
    int? itemId,
    int? availableQuantity,
  }) {
    return AvailableItem(
      itemId: itemId ?? this.itemId,
      availableQuantity: availableQuantity ?? this.availableQuantity,
    );
  }

  @override
  String toString() {
    return 'AvailableItem(itemId: $itemId, availableQuantity: $availableQuantity)';
  }
}
