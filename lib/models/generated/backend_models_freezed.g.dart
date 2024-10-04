// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../backend_models_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StorageImpl _$$StorageImplFromJson(Map<String, dynamic> json) =>
    _$StorageImpl(
      id: (json['id'] as num?)?.toInt(),
      storageName: json['storage_name'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$StorageImplToJson(_$StorageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storage_name': instance.storageName,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$StorageItemSlotImpl _$$StorageItemSlotImplFromJson(
        Map<String, dynamic> json) =>
    _$StorageItemSlotImpl(
      storageId: (json['storage_id'] as num).toInt(),
      itemDescriptionId: (json['item_description_id'] as num?)?.toInt(),
      slotName: json['slot_name'] as String,
      currentQuantity: (json['current_quantity'] as num).toInt(),
      maxQuantity: (json['max_quantity'] as num).toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$StorageItemSlotImplToJson(
        _$StorageItemSlotImpl instance) =>
    <String, dynamic>{
      'storage_id': instance.storageId,
      'item_description_id': instance.itemDescriptionId,
      'slot_name': instance.slotName,
      'current_quantity': instance.currentQuantity,
      'max_quantity': instance.maxQuantity,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$ApsOrderHistoryImpl _$$ApsOrderHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$ApsOrderHistoryImpl(
      apsOrderId: (json['aps_order_id'] as num).toInt(),
      apsId: (json['aps_id'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$ApsOrderHistoryImplToJson(
        _$ApsOrderHistoryImpl instance) =>
    <String, dynamic>{
      'aps_order_id': instance.apsOrderId,
      'aps_id': instance.apsId,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': _$OrderStatusEnumMap[instance.status]!,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.duringOrdering: 'duringOrdering',
  OrderStatus.paymentInProgress: 'paymentInProgress',
  OrderStatus.paid: 'paid',
  OrderStatus.acceptedForExecution: 'acceptedForExecution',
  OrderStatus.orderProcessingHasStarted: 'orderProcessingHasStarted',
  OrderStatus.firstItemWaitingForRecipient: 'firstItemWaitingForRecipient',
  OrderStatus.readyForPickup: 'readyForPickup',
  OrderStatus.pickedUp: 'pickedUp',
  OrderStatus.canceled: 'canceled',
};

_$ApsOrderItemHistoryImpl _$$ApsOrderItemHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$ApsOrderItemHistoryImpl(
      apsOrderItemId: (json['aps_order_item_id'] as num).toInt(),
      apsOrderId: (json['aps_order_id'] as num).toInt(),
      apsId: (json['aps_id'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: $enumDecode(_$ItemStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$ApsOrderItemHistoryImplToJson(
        _$ApsOrderItemHistoryImpl instance) =>
    <String, dynamic>{
      'aps_order_item_id': instance.apsOrderItemId,
      'aps_order_id': instance.apsOrderId,
      'aps_id': instance.apsId,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': _$ItemStatusEnumMap[instance.status]!,
    };

const _$ItemStatusEnumMap = {
  ItemStatus.reserved: 'reserved',
  ItemStatus.queued: 'queued',
  ItemStatus.placingTray: 'placingTray',
  ItemStatus.trayPlaced: 'trayPlaced',
  ItemStatus.drinkPositionReserved: 'drinkPositionReserved',
  ItemStatus.coffeePositionReserved: 'coffeePositionReserved',
  ItemStatus.bagPositionReserved: 'bagPositionReserved',
  ItemStatus.inR1Arm: 'inR1Arm',
  ItemStatus.preBaking: 'preBaking',
  ItemStatus.remainingBaking: 'remainingBaking',
  ItemStatus.readyToCreateData: 'readyToCreateData',
  ItemStatus.readyToPickR2: 'readyToPickR2',
  ItemStatus.inR2Arm: 'inR2Arm',
  ItemStatus.onConveyor: 'onConveyor',
  ItemStatus.readyToReceive: 'readyToReceive',
  ItemStatus.waitingForClient: 'waitingForClient',
  ItemStatus.received: 'received',
  ItemStatus.canceled: 'canceled',
};

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'full_name': instance.fullName,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$VehicleImpl _$$VehicleImplFromJson(Map<String, dynamic> json) =>
    _$VehicleImpl(
      id: (json['id'] as num?)?.toInt(),
      vehicleIdentifier: json['vehicle_identifier'] as String,
      licensePlate: json['license_plate'] as String,
      capacity: (json['capacity'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$VehicleImplToJson(_$VehicleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicle_identifier': instance.vehicleIdentifier,
      'license_plate': instance.licensePlate,
      'capacity': instance.capacity,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$TrolleyImpl _$$TrolleyImplFromJson(Map<String, dynamic> json) =>
    _$TrolleyImpl(
      id: (json['id'] as num?)?.toInt(),
      trolleyNumber: json['trolley_number'] as String,
      maxCapacity: (json['max_capacity'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$TrolleyImplToJson(_$TrolleyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trolley_number': instance.trolleyNumber,
      'max_capacity': instance.maxCapacity,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$StorageOrderImpl _$$StorageOrderImplFromJson(Map<String, dynamic> json) =>
    _$StorageOrderImpl(
      id: (json['id'] as num?)?.toInt(),
      deliveryDay: DateTime.parse(json['delivery_day'] as String),
      source: (json['source'] as num).toInt(),
      destination: (json['destination'] as num).toInt(),
      status: $enumDecode(
          _$StorageOrderStatusEnumMap, json['storage_order_status']),
      enteredBy: (json['entered_by'] as num?)?.toInt(),
      preparedBy: (json['prepared_by'] as num?)?.toInt(),
      packedBy: (json['packed_by'] as num?)?.toInt(),
      deliveredBy: (json['delivered_by'] as num?)?.toInt(),
      vehicleId: (json['vehicle_id'] as num?)?.toInt(),
      purpose: $enumDecode(
          _$StorageOrderPurposeEnumMap, json['storage_order_purpose']),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$StorageOrderImplToJson(_$StorageOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'delivery_day': instance.deliveryDay.toIso8601String(),
      'source': instance.source,
      'destination': instance.destination,
      'storage_order_status': _$StorageOrderStatusEnumMap[instance.status]!,
      'entered_by': instance.enteredBy,
      'prepared_by': instance.preparedBy,
      'packed_by': instance.packedBy,
      'delivered_by': instance.deliveredBy,
      'vehicle_id': instance.vehicleId,
      'storage_order_purpose': _$StorageOrderPurposeEnumMap[instance.purpose]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$StorageOrderStatusEnumMap = {
  StorageOrderStatus.preparedForProduction: 'preparedForProduction',
  StorageOrderStatus.packed: 'packed',
  StorageOrderStatus.onTheWay: 'onTheWay',
  StorageOrderStatus.delivered: 'delivered',
  StorageOrderStatus.cancelled: 'cancelled',
};

const _$StorageOrderPurposeEnumMap = {
  StorageOrderPurpose.restocking: 'restocking',
  StorageOrderPurpose.disposal: 'disposal',
  StorageOrderPurpose.return_: 'return_',
};

_$StorageOrderItemImpl _$$StorageOrderItemImplFromJson(
        Map<String, dynamic> json) =>
    _$StorageOrderItemImpl(
      storageOrderId: (json['storage_order_id'] as num).toInt(),
      itemDescriptionId: (json['item_description_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$StorageOrderItemImplToJson(
        _$StorageOrderItemImpl instance) =>
    <String, dynamic>{
      'storage_order_id': instance.storageOrderId,
      'item_description_id': instance.itemDescriptionId,
      'quantity': instance.quantity,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$StorageOrderTrolleyImpl _$$StorageOrderTrolleyImplFromJson(
        Map<String, dynamic> json) =>
    _$StorageOrderTrolleyImpl(
      storageOrderId: (json['storage_order_id'] as num).toInt(),
      trolleyId: (json['trolley_id'] as num).toInt(),
      positionInVehicle: json['position_in_vehicle'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$StorageOrderTrolleyImplToJson(
        _$StorageOrderTrolleyImpl instance) =>
    <String, dynamic>{
      'storage_order_id': instance.storageOrderId,
      'trolley_id': instance.trolleyId,
      'position_in_vehicle': instance.positionInVehicle,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$ItemDescriptionImpl _$$ItemDescriptionImplFromJson(
        Map<String, dynamic> json) =>
    _$ItemDescriptionImpl(
      id: (json['id'] as num?)?.toInt(),
      namePl: json['name_pl'] as String,
      nameEn: json['name_en'] as String,
      nameUa: json['name_ua'] as String,
      descriptionPl: json['description_pl'] as String?,
      descriptionEn: json['description_en'] as String?,
      descriptionUa: json['description_ua'] as String?,
      allergensPl: json['allergens_pl'] as String?,
      allergensEn: json['allergens_en'] as String?,
      allergensUa: json['allergens_ua'] as String?,
      category: $enumDecode(_$ItemCategoryEnumMap, json['category']),
      image: json['image'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ItemDescriptionImplToJson(
        _$ItemDescriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_pl': instance.namePl,
      'name_en': instance.nameEn,
      'name_ua': instance.nameUa,
      'description_pl': instance.descriptionPl,
      'description_en': instance.descriptionEn,
      'description_ua': instance.descriptionUa,
      'allergens_pl': instance.allergensPl,
      'allergens_en': instance.allergensEn,
      'allergens_ua': instance.allergensUa,
      'category': _$ItemCategoryEnumMap[instance.category]!,
      'image': instance.image,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$ItemCategoryEnumMap = {
  ItemCategory.snack: 'snack',
  ItemCategory.drink: 'drink',
  ItemCategory.coffee: 'coffee',
  ItemCategory.takeAwayBox: 'takeAwayBox',
  ItemCategory.sauce: 'sauce',
  ItemCategory.paperTray: 'paperTray',
  ItemCategory.cup: 'cup',
  ItemCategory.sugar: 'sugar',
};

_$MenuImpl _$$MenuImplFromJson(Map<String, dynamic> json) => _$MenuImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MenuImplToJson(_$MenuImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$MenuItemPriceImpl _$$MenuItemPriceImplFromJson(Map<String, dynamic> json) =>
    _$MenuItemPriceImpl(
      menuId: (json['menu_id'] as num).toInt(),
      itemId: (json['item_id'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MenuItemPriceImplToJson(_$MenuItemPriceImpl instance) =>
    <String, dynamic>{
      'menu_id': instance.menuId,
      'item_id': instance.itemId,
      'price': instance.price,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$ApsDescriptionImpl _$$ApsDescriptionImplFromJson(Map<String, dynamic> json) =>
    _$ApsDescriptionImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      location: const PointWkbConverter().fromJson(json['location'] as String),
      storageId: (json['storage_id'] as num).toInt(),
      menuId: (json['menu_id'] as num).toInt(),
      state: $enumDecode(_$ApsStateEnumMap, json['state']),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ApsDescriptionImplToJson(
        _$ApsDescriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'location': const PointWkbConverter().toJson(instance.location),
      'storage_id': instance.storageId,
      'menu_id': instance.menuId,
      'state': _$ApsStateEnumMap[instance.state]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$ApsStateEnumMap = {
  ApsState.active: 'active',
  ApsState.inactive: 'inactive',
  ApsState.malfunction: 'malfunction',
  ApsState.duringDelivery: 'duringDelivery',
};

_$ApsOrderImpl _$$ApsOrderImplFromJson(Map<String, dynamic> json) =>
    _$ApsOrderImpl(
      id: (json['id'] as num?)?.toInt(),
      apsId: (json['aps_id'] as num).toInt(),
      origin: $enumDecode(_$OriginTypeEnumMap, json['origin']),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      pickupNumber:
          $enumDecodeNullable(_$PickupNumberEnumMap, json['pickup_number']),
      kdsOrderNumber: (json['kds_order_number'] as num?)?.toInt(),
      clientPhoneNumber: json['client_phone_number'] as String?,
      estimatedTime: (json['estimated_time'] as num).toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ApsOrderImplToJson(_$ApsOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aps_id': instance.apsId,
      'origin': _$OriginTypeEnumMap[instance.origin]!,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'pickup_number': _$PickupNumberEnumMap[instance.pickupNumber],
      'kds_order_number': instance.kdsOrderNumber,
      'client_phone_number': instance.clientPhoneNumber,
      'estimated_time': instance.estimatedTime,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$OriginTypeEnumMap = {
  OriginType.kiosk: 'kiosk',
  OriginType.phone: 'phone',
};

const _$PickupNumberEnumMap = {
  PickupNumber.one: 'one',
  PickupNumber.two: 'two',
  PickupNumber.three: 'three',
};

_$ApsOrderItemImpl _$$ApsOrderItemImplFromJson(Map<String, dynamic> json) =>
    _$ApsOrderItemImpl(
      id: (json['id'] as num?)?.toInt(),
      apsOrderId: (json['aps_order_id'] as num).toInt(),
      apsId: (json['aps_id'] as num).toInt(),
      itemId: (json['item_id'] as num).toInt(),
      status: $enumDecode(_$ItemStatusEnumMap, json['status']),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ApsOrderItemImplToJson(_$ApsOrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aps_order_id': instance.apsOrderId,
      'aps_id': instance.apsId,
      'item_id': instance.itemId,
      'status': _$ItemStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$WaypointImpl _$$WaypointImplFromJson(Map<String, dynamic> json) =>
    _$WaypointImpl(
      id: (json['id'] as num?)?.toInt(),
      waypointName: json['waypoint_name'] as String?,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      z: (json['z'] as num).toDouble(),
      qx: (json['qx'] as num).toDouble(),
      qy: (json['qy'] as num).toDouble(),
      qz: (json['qz'] as num).toDouble(),
      qw: (json['qw'] as num).toDouble(),
      offsetX: (json['offset_x'] as num?)?.toDouble(),
      offsetY: (json['offset_y'] as num?)?.toDouble(),
      offsetZ: (json['offset_z'] as num?)?.toDouble(),
      offsetQx: (json['offset_qx'] as num?)?.toDouble(),
      offsetQy: (json['offset_qy'] as num?)?.toDouble(),
      offsetQz: (json['offset_qz'] as num?)?.toDouble(),
      offsetQw: (json['offset_qw'] as num?)?.toDouble(),
      qrRotation: (json['qr_rotation'] as num?)?.toDouble(),
      ovenRotation: (json['oven_rotation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WaypointImplToJson(_$WaypointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'waypoint_name': instance.waypointName,
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'qx': instance.qx,
      'qy': instance.qy,
      'qz': instance.qz,
      'qw': instance.qw,
      'offset_x': instance.offsetX,
      'offset_y': instance.offsetY,
      'offset_z': instance.offsetZ,
      'offset_qx': instance.offsetQx,
      'offset_qy': instance.offsetQy,
      'offset_qz': instance.offsetQz,
      'offset_qw': instance.offsetQw,
      'qr_rotation': instance.qrRotation,
      'oven_rotation': instance.ovenRotation,
    };

_$PathImpl _$$PathImplFromJson(Map<String, dynamic> json) => _$PathImpl(
      id: (json['id'] as num?)?.toInt(),
      fromWaypointId: (json['from_waypoint_id'] as num?)?.toInt(),
      toWaypointId: (json['to_waypoint_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PathImplToJson(_$PathImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_waypoint_id': instance.fromWaypointId,
      'to_waypoint_id': instance.toWaypointId,
    };

_$PathWaypointImpl _$$PathWaypointImplFromJson(Map<String, dynamic> json) =>
    _$PathWaypointImpl(
      id: (json['id'] as num?)?.toInt(),
      sequence: (json['sequence'] as num?)?.toInt(),
      waypointId: (json['waypoint_id'] as num?)?.toInt(),
      pathId: (json['path_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PathWaypointImplToJson(_$PathWaypointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sequence': instance.sequence,
      'waypoint_id': instance.waypointId,
      'path_id': instance.pathId,
    };

_$AvailableItemImpl _$$AvailableItemImplFromJson(Map<String, dynamic> json) =>
    _$AvailableItemImpl(
      itemId: (json['item_id'] as num).toInt(),
      availableQuantity: (json['available_quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$AvailableItemImplToJson(_$AvailableItemImpl instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'available_quantity': instance.availableQuantity,
    };
