// ignore_for_file: invalid_annotation_target

import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/backend_models_freezed.freezed.dart';
part 'generated/backend_models_freezed.g.dart';

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

@freezed
class Storage with _$Storage {
  const factory Storage({
    int? id,
    @JsonKey(name: 'storage_name') required String storageName,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Storage;

  factory Storage.fromJson(Map<String, dynamic> json) => _$StorageFromJson(json);
}

@freezed
class StorageItemSlot with _$StorageItemSlot {
  const factory StorageItemSlot({
    @JsonKey(name: 'storage_id') required int storageId,
    @JsonKey(name: 'item_description_id') int? itemDescriptionId,
    @JsonKey(name: 'slot_name') required String slotName,
    @JsonKey(name: 'current_quantity') required int currentQuantity,
    @JsonKey(name: 'max_quantity') required int maxQuantity,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _StorageItemSlot;

  factory StorageItemSlot.fromJson(Map<String, dynamic> json) => _$StorageItemSlotFromJson(json);
}

@freezed
class ApsOrderHistory with _$ApsOrderHistory {
  const factory ApsOrderHistory({
    @JsonKey(name: 'aps_order_id') required int apsOrderId,
    @JsonKey(name: 'aps_id') required int apsId,
    @JsonKey(name: 'timestamp') required DateTime timestamp,
    @JsonKey(name: 'status') required OrderStatus status,
  }) = _ApsOrderHistory;

  factory ApsOrderHistory.fromJson(Map<String, dynamic> json) => _$ApsOrderHistoryFromJson(json);
}

@freezed
class ApsOrderItemHistory with _$ApsOrderItemHistory {
  const factory ApsOrderItemHistory({
    @JsonKey(name: 'aps_order_item_id') required int apsOrderItemId,
    @JsonKey(name: 'aps_order_id') required int apsOrderId,
    @JsonKey(name: 'aps_id') required int apsId,
    @JsonKey(name: 'timestamp') required DateTime timestamp,
    @JsonKey(name: 'status') required ItemStatus status,
  }) = _ApsOrderItemHistory;

  factory ApsOrderItemHistory.fromJson(Map<String, dynamic> json) => _$ApsOrderItemHistoryFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    int? id,
    required String username,
    required String email,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Vehicle with _$Vehicle {
  const factory Vehicle({
    int? id,
    @JsonKey(name: 'vehicle_identifier') required String vehicleIdentifier,
    @JsonKey(name: 'license_plate') required String licensePlate,
    int? capacity,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
}

@freezed
class Trolley with _$Trolley {
  const factory Trolley({
    int? id,
    @JsonKey(name: 'trolley_number') required String trolleyNumber,
    @JsonKey(name: 'max_capacity') int? maxCapacity,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Trolley;

  factory Trolley.fromJson(Map<String, dynamic> json) => _$TrolleyFromJson(json);
}

@freezed
class StorageOrder with _$StorageOrder {
  const factory StorageOrder({
    int? id,
    @JsonKey(name: 'delivery_day') required DateTime deliveryDay,
    required int source,
    required int destination,
    @JsonKey(name: 'storage_order_status') required StorageOrderStatus status,
    @JsonKey(name: 'entered_by') int? enteredBy,
    @JsonKey(name: 'prepared_by') int? preparedBy,
    @JsonKey(name: 'packed_by') int? packedBy,
    @JsonKey(name: 'delivered_by') int? deliveredBy,
    @JsonKey(name: 'vehicle_id') int? vehicleId,
    @JsonKey(name: 'storage_order_purpose') required StorageOrderPurpose purpose,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _StorageOrder;

  factory StorageOrder.fromJson(Map<String, dynamic> json) => _$StorageOrderFromJson(json);
}

@freezed
class StorageOrderItem with _$StorageOrderItem {
  const factory StorageOrderItem({
    @JsonKey(name: 'storage_order_id') required int storageOrderId,
    @JsonKey(name: 'item_description_id') required int itemDescriptionId,
    required int quantity,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _StorageOrderItem;

  factory StorageOrderItem.fromJson(Map<String, dynamic> json) => _$StorageOrderItemFromJson(json);
}

@freezed
class StorageOrderTrolley with _$StorageOrderTrolley {
  const factory StorageOrderTrolley({
    @JsonKey(name: 'storage_order_id') required int storageOrderId,
    @JsonKey(name: 'trolley_id') required int trolleyId,
    @JsonKey(name: 'position_in_vehicle') String? positionInVehicle,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _StorageOrderTrolley;

  factory StorageOrderTrolley.fromJson(Map<String, dynamic> json) => _$StorageOrderTrolleyFromJson(json);
}

@freezed
class ItemDescription with _$ItemDescription {
  const factory ItemDescription({
    int? id,
    @JsonKey(name: 'name_pl') required String namePl,
    @JsonKey(name: 'name_en') required String nameEn,
    @JsonKey(name: 'name_ua') required String nameUa,
    @JsonKey(name: 'description_pl') String? descriptionPl,
    @JsonKey(name: 'description_en') String? descriptionEn,
    @JsonKey(name: 'description_ua') String? descriptionUa,
    @JsonKey(name: 'allergens_pl') String? allergensPl,
    @JsonKey(name: 'allergens_en') String? allergensEn,
    @JsonKey(name: 'allergens_ua') String? allergensUa,
    @JsonKey(name: 'category') required ItemCategory category,
    String? image,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ItemDescription;

  factory ItemDescription.fromJson(Map<String, dynamic> json) => _$ItemDescriptionFromJson(json);
}

@freezed
class Menu with _$Menu {
  const factory Menu({
    int? id,
    required String name,
    String? description,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Menu;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}

@freezed
class MenuItemPrice with _$MenuItemPrice {
  const factory MenuItemPrice({
    @JsonKey(name: 'menu_id') required int menuId,
    @JsonKey(name: 'item_id') required int itemId,
    required double price,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _MenuItemPrice;

  factory MenuItemPrice.fromJson(Map<String, dynamic> json) => _$MenuItemPriceFromJson(json);
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

class PointWkbConverter implements JsonConverter<Point, String> {
  const PointWkbConverter();

  @override
  Point fromJson(String wkb) {
    return Point.fromWKB(wkb);
  }

  @override
  String toJson(Point point) {
    return point.toString();
  }
}

@freezed
class ApsDescription with _$ApsDescription {
  const factory ApsDescription({
    int? id,
    required String name,
    required String address,
    @PointWkbConverter() required Point location,
    @JsonKey(name: 'storage_id') required int storageId,
    @JsonKey(name: 'menu_id') required int menuId,
    required ApsState state,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ApsDescription;

  factory ApsDescription.fromJson(Map<String, dynamic> json) => _$ApsDescriptionFromJson(json);
}

@freezed
class ApsOrder with _$ApsOrder {
  const factory ApsOrder({
    int? id,
    @JsonKey(name: 'aps_id') required int apsId,
    required OriginType origin,
    required OrderStatus status,
    @JsonKey(name: 'pickup_number') PickupNumber? pickupNumber,
    @JsonKey(name: 'kds_order_number') int? kdsOrderNumber,
    @JsonKey(name: 'client_phone_number') String? clientPhoneNumber,
    @JsonKey(name: 'estimated_time') required int estimatedTime,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ApsOrder;

  factory ApsOrder.fromJson(Map<String, dynamic> json) => _$ApsOrderFromJson(json);
}

@freezed
class ApsOrderItem with _$ApsOrderItem {
  const factory ApsOrderItem({
    int? id,
    @JsonKey(name: 'aps_order_id') required int apsOrderId,
    @JsonKey(name: 'aps_id') required int apsId,
    @JsonKey(name: 'item_id') required int itemId,
    required ItemStatus status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ApsOrderItem;

  factory ApsOrderItem.fromJson(Map<String, dynamic> json) => _$ApsOrderItemFromJson(json);
}

@freezed
class Waypoint with _$Waypoint {
  const factory Waypoint({
    int? id,
    @JsonKey(name: 'waypoint_name') String? waypointName,
    required double x,
    required double y,
    required double z,
    required double qx,
    required double qy,
    required double qz,
    required double qw,
    @JsonKey(name: 'offset_x') double? offsetX,
    @JsonKey(name: 'offset_y') double? offsetY,
    @JsonKey(name: 'offset_z') double? offsetZ,
    @JsonKey(name: 'offset_qx') double? offsetQx,
    @JsonKey(name: 'offset_qy') double? offsetQy,
    @JsonKey(name: 'offset_qz') double? offsetQz,
    @JsonKey(name: 'offset_qw') double? offsetQw,
    @JsonKey(name: 'qr_rotation') double? qrRotation,
    @JsonKey(name: 'oven_rotation') double? ovenRotation,
  }) = _Waypoint;

  factory Waypoint.fromJson(Map<String, dynamic> json) => _$WaypointFromJson(json);
}

@freezed
class Path with _$Path {
  const factory Path({
    int? id,
    @JsonKey(name: 'from_waypoint_id') int? fromWaypointId,
    @JsonKey(name: 'to_waypoint_id') int? toWaypointId,
  }) = _Path;

  factory Path.fromJson(Map<String, dynamic> json) => _$PathFromJson(json);
}

@freezed
class PathWaypoint with _$PathWaypoint {
  const factory PathWaypoint({
    int? id,
    int? sequence,
    @JsonKey(name: 'waypoint_id') int? waypointId,
    @JsonKey(name: 'path_id') int? pathId,
  }) = _PathWaypoint;

  factory PathWaypoint.fromJson(Map<String, dynamic> json) => _$PathWaypointFromJson(json);
}

@freezed
class AvailableItem with _$AvailableItem {
  const factory AvailableItem({
    @JsonKey(name: 'item_id') required int itemId,
    @JsonKey(name: 'available_quantity') required int availableQuantity,
  }) = _AvailableItem;

  factory AvailableItem.fromJson(Map<String, dynamic> json) => _$AvailableItemFromJson(json);
}
