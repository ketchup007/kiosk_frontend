// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../backend_models_freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Storage _$StorageFromJson(Map<String, dynamic> json) {
  return _Storage.fromJson(json);
}

/// @nodoc
mixin _$Storage {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_name')
  String get storageName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Storage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorageCopyWith<Storage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageCopyWith<$Res> {
  factory $StorageCopyWith(Storage value, $Res Function(Storage) then) =
      _$StorageCopyWithImpl<$Res, Storage>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'storage_name') String storageName,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$StorageCopyWithImpl<$Res, $Val extends Storage>
    implements $StorageCopyWith<$Res> {
  _$StorageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? storageName = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      storageName: null == storageName
          ? _value.storageName
          : storageName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorageImplCopyWith<$Res> implements $StorageCopyWith<$Res> {
  factory _$$StorageImplCopyWith(
          _$StorageImpl value, $Res Function(_$StorageImpl) then) =
      __$$StorageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'storage_name') String storageName,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$StorageImplCopyWithImpl<$Res>
    extends _$StorageCopyWithImpl<$Res, _$StorageImpl>
    implements _$$StorageImplCopyWith<$Res> {
  __$$StorageImplCopyWithImpl(
      _$StorageImpl _value, $Res Function(_$StorageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? storageName = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StorageImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      storageName: null == storageName
          ? _value.storageName
          : storageName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StorageImpl implements _Storage {
  const _$StorageImpl(
      {this.id,
      @JsonKey(name: 'storage_name') required this.storageName,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$StorageImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorageImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'storage_name')
  final String storageName;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Storage(id: $id, storageName: $storageName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storageName, storageName) ||
                other.storageName == storageName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, storageName, createdAt, updatedAt);

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageImplCopyWith<_$StorageImpl> get copyWith =>
      __$$StorageImplCopyWithImpl<_$StorageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorageImplToJson(
      this,
    );
  }
}

abstract class _Storage implements Storage {
  const factory _Storage(
      {final int? id,
      @JsonKey(name: 'storage_name') required final String storageName,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$StorageImpl;

  factory _Storage.fromJson(Map<String, dynamic> json) = _$StorageImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'storage_name')
  String get storageName;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Storage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageImplCopyWith<_$StorageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StorageItemSlot _$StorageItemSlotFromJson(Map<String, dynamic> json) {
  return _StorageItemSlot.fromJson(json);
}

/// @nodoc
mixin _$StorageItemSlot {
  @JsonKey(name: 'storage_id')
  int get storageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_description_id')
  int? get itemDescriptionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'slot_name')
  String get slotName => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_quantity')
  int get currentQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_quantity')
  int get maxQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this StorageItemSlot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StorageItemSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorageItemSlotCopyWith<StorageItemSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageItemSlotCopyWith<$Res> {
  factory $StorageItemSlotCopyWith(
          StorageItemSlot value, $Res Function(StorageItemSlot) then) =
      _$StorageItemSlotCopyWithImpl<$Res, StorageItemSlot>;
  @useResult
  $Res call(
      {@JsonKey(name: 'storage_id') int storageId,
      @JsonKey(name: 'item_description_id') int? itemDescriptionId,
      @JsonKey(name: 'slot_name') String slotName,
      @JsonKey(name: 'current_quantity') int currentQuantity,
      @JsonKey(name: 'max_quantity') int maxQuantity,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$StorageItemSlotCopyWithImpl<$Res, $Val extends StorageItemSlot>
    implements $StorageItemSlotCopyWith<$Res> {
  _$StorageItemSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorageItemSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storageId = null,
    Object? itemDescriptionId = freezed,
    Object? slotName = null,
    Object? currentQuantity = null,
    Object? maxQuantity = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      storageId: null == storageId
          ? _value.storageId
          : storageId // ignore: cast_nullable_to_non_nullable
              as int,
      itemDescriptionId: freezed == itemDescriptionId
          ? _value.itemDescriptionId
          : itemDescriptionId // ignore: cast_nullable_to_non_nullable
              as int?,
      slotName: null == slotName
          ? _value.slotName
          : slotName // ignore: cast_nullable_to_non_nullable
              as String,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      maxQuantity: null == maxQuantity
          ? _value.maxQuantity
          : maxQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorageItemSlotImplCopyWith<$Res>
    implements $StorageItemSlotCopyWith<$Res> {
  factory _$$StorageItemSlotImplCopyWith(_$StorageItemSlotImpl value,
          $Res Function(_$StorageItemSlotImpl) then) =
      __$$StorageItemSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'storage_id') int storageId,
      @JsonKey(name: 'item_description_id') int? itemDescriptionId,
      @JsonKey(name: 'slot_name') String slotName,
      @JsonKey(name: 'current_quantity') int currentQuantity,
      @JsonKey(name: 'max_quantity') int maxQuantity,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$StorageItemSlotImplCopyWithImpl<$Res>
    extends _$StorageItemSlotCopyWithImpl<$Res, _$StorageItemSlotImpl>
    implements _$$StorageItemSlotImplCopyWith<$Res> {
  __$$StorageItemSlotImplCopyWithImpl(
      _$StorageItemSlotImpl _value, $Res Function(_$StorageItemSlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of StorageItemSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storageId = null,
    Object? itemDescriptionId = freezed,
    Object? slotName = null,
    Object? currentQuantity = null,
    Object? maxQuantity = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StorageItemSlotImpl(
      storageId: null == storageId
          ? _value.storageId
          : storageId // ignore: cast_nullable_to_non_nullable
              as int,
      itemDescriptionId: freezed == itemDescriptionId
          ? _value.itemDescriptionId
          : itemDescriptionId // ignore: cast_nullable_to_non_nullable
              as int?,
      slotName: null == slotName
          ? _value.slotName
          : slotName // ignore: cast_nullable_to_non_nullable
              as String,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      maxQuantity: null == maxQuantity
          ? _value.maxQuantity
          : maxQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StorageItemSlotImpl implements _StorageItemSlot {
  const _$StorageItemSlotImpl(
      {@JsonKey(name: 'storage_id') required this.storageId,
      @JsonKey(name: 'item_description_id') this.itemDescriptionId,
      @JsonKey(name: 'slot_name') required this.slotName,
      @JsonKey(name: 'current_quantity') required this.currentQuantity,
      @JsonKey(name: 'max_quantity') required this.maxQuantity,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$StorageItemSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorageItemSlotImplFromJson(json);

  @override
  @JsonKey(name: 'storage_id')
  final int storageId;
  @override
  @JsonKey(name: 'item_description_id')
  final int? itemDescriptionId;
  @override
  @JsonKey(name: 'slot_name')
  final String slotName;
  @override
  @JsonKey(name: 'current_quantity')
  final int currentQuantity;
  @override
  @JsonKey(name: 'max_quantity')
  final int maxQuantity;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'StorageItemSlot(storageId: $storageId, itemDescriptionId: $itemDescriptionId, slotName: $slotName, currentQuantity: $currentQuantity, maxQuantity: $maxQuantity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageItemSlotImpl &&
            (identical(other.storageId, storageId) ||
                other.storageId == storageId) &&
            (identical(other.itemDescriptionId, itemDescriptionId) ||
                other.itemDescriptionId == itemDescriptionId) &&
            (identical(other.slotName, slotName) ||
                other.slotName == slotName) &&
            (identical(other.currentQuantity, currentQuantity) ||
                other.currentQuantity == currentQuantity) &&
            (identical(other.maxQuantity, maxQuantity) ||
                other.maxQuantity == maxQuantity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storageId, itemDescriptionId,
      slotName, currentQuantity, maxQuantity, createdAt, updatedAt);

  /// Create a copy of StorageItemSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageItemSlotImplCopyWith<_$StorageItemSlotImpl> get copyWith =>
      __$$StorageItemSlotImplCopyWithImpl<_$StorageItemSlotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorageItemSlotImplToJson(
      this,
    );
  }
}

abstract class _StorageItemSlot implements StorageItemSlot {
  const factory _StorageItemSlot(
          {@JsonKey(name: 'storage_id') required final int storageId,
          @JsonKey(name: 'item_description_id') final int? itemDescriptionId,
          @JsonKey(name: 'slot_name') required final String slotName,
          @JsonKey(name: 'current_quantity') required final int currentQuantity,
          @JsonKey(name: 'max_quantity') required final int maxQuantity,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$StorageItemSlotImpl;

  factory _StorageItemSlot.fromJson(Map<String, dynamic> json) =
      _$StorageItemSlotImpl.fromJson;

  @override
  @JsonKey(name: 'storage_id')
  int get storageId;
  @override
  @JsonKey(name: 'item_description_id')
  int? get itemDescriptionId;
  @override
  @JsonKey(name: 'slot_name')
  String get slotName;
  @override
  @JsonKey(name: 'current_quantity')
  int get currentQuantity;
  @override
  @JsonKey(name: 'max_quantity')
  int get maxQuantity;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of StorageItemSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageItemSlotImplCopyWith<_$StorageItemSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApsOrderHistory _$ApsOrderHistoryFromJson(Map<String, dynamic> json) {
  return _ApsOrderHistory.fromJson(json);
}

/// @nodoc
mixin _$ApsOrderHistory {
  @JsonKey(name: 'aps_order_id')
  int get apsOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'aps_id')
  int get apsId => throw _privateConstructorUsedError;
  @JsonKey(name: 'timestamp')
  DateTime get timestamp => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  OrderStatus get status => throw _privateConstructorUsedError;

  /// Serializes this ApsOrderHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApsOrderHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApsOrderHistoryCopyWith<ApsOrderHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApsOrderHistoryCopyWith<$Res> {
  factory $ApsOrderHistoryCopyWith(
          ApsOrderHistory value, $Res Function(ApsOrderHistory) then) =
      _$ApsOrderHistoryCopyWithImpl<$Res, ApsOrderHistory>;
  @useResult
  $Res call(
      {@JsonKey(name: 'aps_order_id') int apsOrderId,
      @JsonKey(name: 'aps_id') int apsId,
      @JsonKey(name: 'timestamp') DateTime timestamp,
      @JsonKey(name: 'status') OrderStatus status});
}

/// @nodoc
class _$ApsOrderHistoryCopyWithImpl<$Res, $Val extends ApsOrderHistory>
    implements $ApsOrderHistoryCopyWith<$Res> {
  _$ApsOrderHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApsOrderHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apsOrderId = null,
    Object? apsId = null,
    Object? timestamp = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      apsOrderId: null == apsOrderId
          ? _value.apsOrderId
          : apsOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      apsId: null == apsId
          ? _value.apsId
          : apsId // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApsOrderHistoryImplCopyWith<$Res>
    implements $ApsOrderHistoryCopyWith<$Res> {
  factory _$$ApsOrderHistoryImplCopyWith(_$ApsOrderHistoryImpl value,
          $Res Function(_$ApsOrderHistoryImpl) then) =
      __$$ApsOrderHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'aps_order_id') int apsOrderId,
      @JsonKey(name: 'aps_id') int apsId,
      @JsonKey(name: 'timestamp') DateTime timestamp,
      @JsonKey(name: 'status') OrderStatus status});
}

/// @nodoc
class __$$ApsOrderHistoryImplCopyWithImpl<$Res>
    extends _$ApsOrderHistoryCopyWithImpl<$Res, _$ApsOrderHistoryImpl>
    implements _$$ApsOrderHistoryImplCopyWith<$Res> {
  __$$ApsOrderHistoryImplCopyWithImpl(
      _$ApsOrderHistoryImpl _value, $Res Function(_$ApsOrderHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApsOrderHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apsOrderId = null,
    Object? apsId = null,
    Object? timestamp = null,
    Object? status = null,
  }) {
    return _then(_$ApsOrderHistoryImpl(
      apsOrderId: null == apsOrderId
          ? _value.apsOrderId
          : apsOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      apsId: null == apsId
          ? _value.apsId
          : apsId // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApsOrderHistoryImpl implements _ApsOrderHistory {
  const _$ApsOrderHistoryImpl(
      {@JsonKey(name: 'aps_order_id') required this.apsOrderId,
      @JsonKey(name: 'aps_id') required this.apsId,
      @JsonKey(name: 'timestamp') required this.timestamp,
      @JsonKey(name: 'status') required this.status});

  factory _$ApsOrderHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApsOrderHistoryImplFromJson(json);

  @override
  @JsonKey(name: 'aps_order_id')
  final int apsOrderId;
  @override
  @JsonKey(name: 'aps_id')
  final int apsId;
  @override
  @JsonKey(name: 'timestamp')
  final DateTime timestamp;
  @override
  @JsonKey(name: 'status')
  final OrderStatus status;

  @override
  String toString() {
    return 'ApsOrderHistory(apsOrderId: $apsOrderId, apsId: $apsId, timestamp: $timestamp, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApsOrderHistoryImpl &&
            (identical(other.apsOrderId, apsOrderId) ||
                other.apsOrderId == apsOrderId) &&
            (identical(other.apsId, apsId) || other.apsId == apsId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, apsOrderId, apsId, timestamp, status);

  /// Create a copy of ApsOrderHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApsOrderHistoryImplCopyWith<_$ApsOrderHistoryImpl> get copyWith =>
      __$$ApsOrderHistoryImplCopyWithImpl<_$ApsOrderHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApsOrderHistoryImplToJson(
      this,
    );
  }
}

abstract class _ApsOrderHistory implements ApsOrderHistory {
  const factory _ApsOrderHistory(
          {@JsonKey(name: 'aps_order_id') required final int apsOrderId,
          @JsonKey(name: 'aps_id') required final int apsId,
          @JsonKey(name: 'timestamp') required final DateTime timestamp,
          @JsonKey(name: 'status') required final OrderStatus status}) =
      _$ApsOrderHistoryImpl;

  factory _ApsOrderHistory.fromJson(Map<String, dynamic> json) =
      _$ApsOrderHistoryImpl.fromJson;

  @override
  @JsonKey(name: 'aps_order_id')
  int get apsOrderId;
  @override
  @JsonKey(name: 'aps_id')
  int get apsId;
  @override
  @JsonKey(name: 'timestamp')
  DateTime get timestamp;
  @override
  @JsonKey(name: 'status')
  OrderStatus get status;

  /// Create a copy of ApsOrderHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApsOrderHistoryImplCopyWith<_$ApsOrderHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApsOrderItemHistory _$ApsOrderItemHistoryFromJson(Map<String, dynamic> json) {
  return _ApsOrderItemHistory.fromJson(json);
}

/// @nodoc
mixin _$ApsOrderItemHistory {
  @JsonKey(name: 'aps_order_item_id')
  int get apsOrderItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'aps_order_id')
  int get apsOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'aps_id')
  int get apsId => throw _privateConstructorUsedError;
  @JsonKey(name: 'timestamp')
  DateTime get timestamp => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  ItemStatus get status => throw _privateConstructorUsedError;

  /// Serializes this ApsOrderItemHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApsOrderItemHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApsOrderItemHistoryCopyWith<ApsOrderItemHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApsOrderItemHistoryCopyWith<$Res> {
  factory $ApsOrderItemHistoryCopyWith(
          ApsOrderItemHistory value, $Res Function(ApsOrderItemHistory) then) =
      _$ApsOrderItemHistoryCopyWithImpl<$Res, ApsOrderItemHistory>;
  @useResult
  $Res call(
      {@JsonKey(name: 'aps_order_item_id') int apsOrderItemId,
      @JsonKey(name: 'aps_order_id') int apsOrderId,
      @JsonKey(name: 'aps_id') int apsId,
      @JsonKey(name: 'timestamp') DateTime timestamp,
      @JsonKey(name: 'status') ItemStatus status});
}

/// @nodoc
class _$ApsOrderItemHistoryCopyWithImpl<$Res, $Val extends ApsOrderItemHistory>
    implements $ApsOrderItemHistoryCopyWith<$Res> {
  _$ApsOrderItemHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApsOrderItemHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apsOrderItemId = null,
    Object? apsOrderId = null,
    Object? apsId = null,
    Object? timestamp = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      apsOrderItemId: null == apsOrderItemId
          ? _value.apsOrderItemId
          : apsOrderItemId // ignore: cast_nullable_to_non_nullable
              as int,
      apsOrderId: null == apsOrderId
          ? _value.apsOrderId
          : apsOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      apsId: null == apsId
          ? _value.apsId
          : apsId // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ItemStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApsOrderItemHistoryImplCopyWith<$Res>
    implements $ApsOrderItemHistoryCopyWith<$Res> {
  factory _$$ApsOrderItemHistoryImplCopyWith(_$ApsOrderItemHistoryImpl value,
          $Res Function(_$ApsOrderItemHistoryImpl) then) =
      __$$ApsOrderItemHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'aps_order_item_id') int apsOrderItemId,
      @JsonKey(name: 'aps_order_id') int apsOrderId,
      @JsonKey(name: 'aps_id') int apsId,
      @JsonKey(name: 'timestamp') DateTime timestamp,
      @JsonKey(name: 'status') ItemStatus status});
}

/// @nodoc
class __$$ApsOrderItemHistoryImplCopyWithImpl<$Res>
    extends _$ApsOrderItemHistoryCopyWithImpl<$Res, _$ApsOrderItemHistoryImpl>
    implements _$$ApsOrderItemHistoryImplCopyWith<$Res> {
  __$$ApsOrderItemHistoryImplCopyWithImpl(_$ApsOrderItemHistoryImpl _value,
      $Res Function(_$ApsOrderItemHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApsOrderItemHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apsOrderItemId = null,
    Object? apsOrderId = null,
    Object? apsId = null,
    Object? timestamp = null,
    Object? status = null,
  }) {
    return _then(_$ApsOrderItemHistoryImpl(
      apsOrderItemId: null == apsOrderItemId
          ? _value.apsOrderItemId
          : apsOrderItemId // ignore: cast_nullable_to_non_nullable
              as int,
      apsOrderId: null == apsOrderId
          ? _value.apsOrderId
          : apsOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      apsId: null == apsId
          ? _value.apsId
          : apsId // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ItemStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApsOrderItemHistoryImpl implements _ApsOrderItemHistory {
  const _$ApsOrderItemHistoryImpl(
      {@JsonKey(name: 'aps_order_item_id') required this.apsOrderItemId,
      @JsonKey(name: 'aps_order_id') required this.apsOrderId,
      @JsonKey(name: 'aps_id') required this.apsId,
      @JsonKey(name: 'timestamp') required this.timestamp,
      @JsonKey(name: 'status') required this.status});

  factory _$ApsOrderItemHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApsOrderItemHistoryImplFromJson(json);

  @override
  @JsonKey(name: 'aps_order_item_id')
  final int apsOrderItemId;
  @override
  @JsonKey(name: 'aps_order_id')
  final int apsOrderId;
  @override
  @JsonKey(name: 'aps_id')
  final int apsId;
  @override
  @JsonKey(name: 'timestamp')
  final DateTime timestamp;
  @override
  @JsonKey(name: 'status')
  final ItemStatus status;

  @override
  String toString() {
    return 'ApsOrderItemHistory(apsOrderItemId: $apsOrderItemId, apsOrderId: $apsOrderId, apsId: $apsId, timestamp: $timestamp, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApsOrderItemHistoryImpl &&
            (identical(other.apsOrderItemId, apsOrderItemId) ||
                other.apsOrderItemId == apsOrderItemId) &&
            (identical(other.apsOrderId, apsOrderId) ||
                other.apsOrderId == apsOrderId) &&
            (identical(other.apsId, apsId) || other.apsId == apsId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, apsOrderItemId, apsOrderId, apsId, timestamp, status);

  /// Create a copy of ApsOrderItemHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApsOrderItemHistoryImplCopyWith<_$ApsOrderItemHistoryImpl> get copyWith =>
      __$$ApsOrderItemHistoryImplCopyWithImpl<_$ApsOrderItemHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApsOrderItemHistoryImplToJson(
      this,
    );
  }
}

abstract class _ApsOrderItemHistory implements ApsOrderItemHistory {
  const factory _ApsOrderItemHistory(
      {@JsonKey(name: 'aps_order_item_id') required final int apsOrderItemId,
      @JsonKey(name: 'aps_order_id') required final int apsOrderId,
      @JsonKey(name: 'aps_id') required final int apsId,
      @JsonKey(name: 'timestamp') required final DateTime timestamp,
      @JsonKey(name: 'status')
      required final ItemStatus status}) = _$ApsOrderItemHistoryImpl;

  factory _ApsOrderItemHistory.fromJson(Map<String, dynamic> json) =
      _$ApsOrderItemHistoryImpl.fromJson;

  @override
  @JsonKey(name: 'aps_order_item_id')
  int get apsOrderItemId;
  @override
  @JsonKey(name: 'aps_order_id')
  int get apsOrderId;
  @override
  @JsonKey(name: 'aps_id')
  int get apsId;
  @override
  @JsonKey(name: 'timestamp')
  DateTime get timestamp;
  @override
  @JsonKey(name: 'status')
  ItemStatus get status;

  /// Create a copy of ApsOrderItemHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApsOrderItemHistoryImplCopyWith<_$ApsOrderItemHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int? get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int? id,
      String username,
      String email,
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = null,
    Object? email = null,
    Object? fullName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String username,
      String email,
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = null,
    Object? email = null,
    Object? fullName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {this.id,
      required this.username,
      required this.email,
      @JsonKey(name: 'full_name') this.fullName,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int? id;
  @override
  final String username;
  @override
  final String email;
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, fullName: $fullName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, username, email, fullName, createdAt, updatedAt);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {final int? id,
      required final String username,
      required final String email,
      @JsonKey(name: 'full_name') final String? fullName,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int? get id;
  @override
  String get username;
  @override
  String get email;
  @override
  @JsonKey(name: 'full_name')
  String? get fullName;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return _Vehicle.fromJson(json);
}

/// @nodoc
mixin _$Vehicle {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_identifier')
  String get vehicleIdentifier => throw _privateConstructorUsedError;
  @JsonKey(name: 'license_plate')
  String get licensePlate => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Vehicle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleCopyWith<Vehicle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) then) =
      _$VehicleCopyWithImpl<$Res, Vehicle>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'vehicle_identifier') String vehicleIdentifier,
      @JsonKey(name: 'license_plate') String licensePlate,
      int? capacity,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res, $Val extends Vehicle>
    implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? vehicleIdentifier = null,
    Object? licensePlate = null,
    Object? capacity = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      vehicleIdentifier: null == vehicleIdentifier
          ? _value.vehicleIdentifier
          : vehicleIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      licensePlate: null == licensePlate
          ? _value.licensePlate
          : licensePlate // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehicleImplCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$$VehicleImplCopyWith(
          _$VehicleImpl value, $Res Function(_$VehicleImpl) then) =
      __$$VehicleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'vehicle_identifier') String vehicleIdentifier,
      @JsonKey(name: 'license_plate') String licensePlate,
      int? capacity,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$VehicleImplCopyWithImpl<$Res>
    extends _$VehicleCopyWithImpl<$Res, _$VehicleImpl>
    implements _$$VehicleImplCopyWith<$Res> {
  __$$VehicleImplCopyWithImpl(
      _$VehicleImpl _value, $Res Function(_$VehicleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? vehicleIdentifier = null,
    Object? licensePlate = null,
    Object? capacity = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$VehicleImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      vehicleIdentifier: null == vehicleIdentifier
          ? _value.vehicleIdentifier
          : vehicleIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      licensePlate: null == licensePlate
          ? _value.licensePlate
          : licensePlate // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleImpl implements _Vehicle {
  const _$VehicleImpl(
      {this.id,
      @JsonKey(name: 'vehicle_identifier') required this.vehicleIdentifier,
      @JsonKey(name: 'license_plate') required this.licensePlate,
      this.capacity,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$VehicleImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'vehicle_identifier')
  final String vehicleIdentifier;
  @override
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @override
  final int? capacity;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Vehicle(id: $id, vehicleIdentifier: $vehicleIdentifier, licensePlate: $licensePlate, capacity: $capacity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vehicleIdentifier, vehicleIdentifier) ||
                other.vehicleIdentifier == vehicleIdentifier) &&
            (identical(other.licensePlate, licensePlate) ||
                other.licensePlate == licensePlate) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, vehicleIdentifier,
      licensePlate, capacity, createdAt, updatedAt);

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      __$$VehicleImplCopyWithImpl<_$VehicleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleImplToJson(
      this,
    );
  }
}

abstract class _Vehicle implements Vehicle {
  const factory _Vehicle(
      {final int? id,
      @JsonKey(name: 'vehicle_identifier')
      required final String vehicleIdentifier,
      @JsonKey(name: 'license_plate') required final String licensePlate,
      final int? capacity,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$VehicleImpl;

  factory _Vehicle.fromJson(Map<String, dynamic> json) = _$VehicleImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'vehicle_identifier')
  String get vehicleIdentifier;
  @override
  @JsonKey(name: 'license_plate')
  String get licensePlate;
  @override
  int? get capacity;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Trolley _$TrolleyFromJson(Map<String, dynamic> json) {
  return _Trolley.fromJson(json);
}

/// @nodoc
mixin _$Trolley {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'trolley_number')
  String get trolleyNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_capacity')
  int? get maxCapacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Trolley to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Trolley
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrolleyCopyWith<Trolley> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrolleyCopyWith<$Res> {
  factory $TrolleyCopyWith(Trolley value, $Res Function(Trolley) then) =
      _$TrolleyCopyWithImpl<$Res, Trolley>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'trolley_number') String trolleyNumber,
      @JsonKey(name: 'max_capacity') int? maxCapacity,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$TrolleyCopyWithImpl<$Res, $Val extends Trolley>
    implements $TrolleyCopyWith<$Res> {
  _$TrolleyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Trolley
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trolleyNumber = null,
    Object? maxCapacity = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      trolleyNumber: null == trolleyNumber
          ? _value.trolleyNumber
          : trolleyNumber // ignore: cast_nullable_to_non_nullable
              as String,
      maxCapacity: freezed == maxCapacity
          ? _value.maxCapacity
          : maxCapacity // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrolleyImplCopyWith<$Res> implements $TrolleyCopyWith<$Res> {
  factory _$$TrolleyImplCopyWith(
          _$TrolleyImpl value, $Res Function(_$TrolleyImpl) then) =
      __$$TrolleyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'trolley_number') String trolleyNumber,
      @JsonKey(name: 'max_capacity') int? maxCapacity,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$TrolleyImplCopyWithImpl<$Res>
    extends _$TrolleyCopyWithImpl<$Res, _$TrolleyImpl>
    implements _$$TrolleyImplCopyWith<$Res> {
  __$$TrolleyImplCopyWithImpl(
      _$TrolleyImpl _value, $Res Function(_$TrolleyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Trolley
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trolleyNumber = null,
    Object? maxCapacity = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TrolleyImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      trolleyNumber: null == trolleyNumber
          ? _value.trolleyNumber
          : trolleyNumber // ignore: cast_nullable_to_non_nullable
              as String,
      maxCapacity: freezed == maxCapacity
          ? _value.maxCapacity
          : maxCapacity // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrolleyImpl implements _Trolley {
  const _$TrolleyImpl(
      {this.id,
      @JsonKey(name: 'trolley_number') required this.trolleyNumber,
      @JsonKey(name: 'max_capacity') this.maxCapacity,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$TrolleyImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrolleyImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'trolley_number')
  final String trolleyNumber;
  @override
  @JsonKey(name: 'max_capacity')
  final int? maxCapacity;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Trolley(id: $id, trolleyNumber: $trolleyNumber, maxCapacity: $maxCapacity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrolleyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.trolleyNumber, trolleyNumber) ||
                other.trolleyNumber == trolleyNumber) &&
            (identical(other.maxCapacity, maxCapacity) ||
                other.maxCapacity == maxCapacity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, trolleyNumber, maxCapacity, createdAt, updatedAt);

  /// Create a copy of Trolley
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrolleyImplCopyWith<_$TrolleyImpl> get copyWith =>
      __$$TrolleyImplCopyWithImpl<_$TrolleyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrolleyImplToJson(
      this,
    );
  }
}

abstract class _Trolley implements Trolley {
  const factory _Trolley(
      {final int? id,
      @JsonKey(name: 'trolley_number') required final String trolleyNumber,
      @JsonKey(name: 'max_capacity') final int? maxCapacity,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$TrolleyImpl;

  factory _Trolley.fromJson(Map<String, dynamic> json) = _$TrolleyImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'trolley_number')
  String get trolleyNumber;
  @override
  @JsonKey(name: 'max_capacity')
  int? get maxCapacity;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Trolley
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrolleyImplCopyWith<_$TrolleyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StorageOrder _$StorageOrderFromJson(Map<String, dynamic> json) {
  return _StorageOrder.fromJson(json);
}

/// @nodoc
mixin _$StorageOrder {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_day')
  DateTime get deliveryDay => throw _privateConstructorUsedError;
  int get source => throw _privateConstructorUsedError;
  int get destination => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_order_status')
  StorageOrderStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'entered_by')
  int? get enteredBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'prepared_by')
  int? get preparedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'packed_by')
  int? get packedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_by')
  int? get deliveredBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_id')
  int? get vehicleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_order_purpose')
  StorageOrderPurpose get purpose => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this StorageOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StorageOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorageOrderCopyWith<StorageOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageOrderCopyWith<$Res> {
  factory $StorageOrderCopyWith(
          StorageOrder value, $Res Function(StorageOrder) then) =
      _$StorageOrderCopyWithImpl<$Res, StorageOrder>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'delivery_day') DateTime deliveryDay,
      int source,
      int destination,
      @JsonKey(name: 'storage_order_status') StorageOrderStatus status,
      @JsonKey(name: 'entered_by') int? enteredBy,
      @JsonKey(name: 'prepared_by') int? preparedBy,
      @JsonKey(name: 'packed_by') int? packedBy,
      @JsonKey(name: 'delivered_by') int? deliveredBy,
      @JsonKey(name: 'vehicle_id') int? vehicleId,
      @JsonKey(name: 'storage_order_purpose') StorageOrderPurpose purpose,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$StorageOrderCopyWithImpl<$Res, $Val extends StorageOrder>
    implements $StorageOrderCopyWith<$Res> {
  _$StorageOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorageOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deliveryDay = null,
    Object? source = null,
    Object? destination = null,
    Object? status = null,
    Object? enteredBy = freezed,
    Object? preparedBy = freezed,
    Object? packedBy = freezed,
    Object? deliveredBy = freezed,
    Object? vehicleId = freezed,
    Object? purpose = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveryDay: null == deliveryDay
          ? _value.deliveryDay
          : deliveryDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as int,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StorageOrderStatus,
      enteredBy: freezed == enteredBy
          ? _value.enteredBy
          : enteredBy // ignore: cast_nullable_to_non_nullable
              as int?,
      preparedBy: freezed == preparedBy
          ? _value.preparedBy
          : preparedBy // ignore: cast_nullable_to_non_nullable
              as int?,
      packedBy: freezed == packedBy
          ? _value.packedBy
          : packedBy // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveredBy: freezed == deliveredBy
          ? _value.deliveredBy
          : deliveredBy // ignore: cast_nullable_to_non_nullable
              as int?,
      vehicleId: freezed == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as int?,
      purpose: null == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as StorageOrderPurpose,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorageOrderImplCopyWith<$Res>
    implements $StorageOrderCopyWith<$Res> {
  factory _$$StorageOrderImplCopyWith(
          _$StorageOrderImpl value, $Res Function(_$StorageOrderImpl) then) =
      __$$StorageOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'delivery_day') DateTime deliveryDay,
      int source,
      int destination,
      @JsonKey(name: 'storage_order_status') StorageOrderStatus status,
      @JsonKey(name: 'entered_by') int? enteredBy,
      @JsonKey(name: 'prepared_by') int? preparedBy,
      @JsonKey(name: 'packed_by') int? packedBy,
      @JsonKey(name: 'delivered_by') int? deliveredBy,
      @JsonKey(name: 'vehicle_id') int? vehicleId,
      @JsonKey(name: 'storage_order_purpose') StorageOrderPurpose purpose,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$StorageOrderImplCopyWithImpl<$Res>
    extends _$StorageOrderCopyWithImpl<$Res, _$StorageOrderImpl>
    implements _$$StorageOrderImplCopyWith<$Res> {
  __$$StorageOrderImplCopyWithImpl(
      _$StorageOrderImpl _value, $Res Function(_$StorageOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of StorageOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deliveryDay = null,
    Object? source = null,
    Object? destination = null,
    Object? status = null,
    Object? enteredBy = freezed,
    Object? preparedBy = freezed,
    Object? packedBy = freezed,
    Object? deliveredBy = freezed,
    Object? vehicleId = freezed,
    Object? purpose = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StorageOrderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveryDay: null == deliveryDay
          ? _value.deliveryDay
          : deliveryDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as int,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StorageOrderStatus,
      enteredBy: freezed == enteredBy
          ? _value.enteredBy
          : enteredBy // ignore: cast_nullable_to_non_nullable
              as int?,
      preparedBy: freezed == preparedBy
          ? _value.preparedBy
          : preparedBy // ignore: cast_nullable_to_non_nullable
              as int?,
      packedBy: freezed == packedBy
          ? _value.packedBy
          : packedBy // ignore: cast_nullable_to_non_nullable
              as int?,
      deliveredBy: freezed == deliveredBy
          ? _value.deliveredBy
          : deliveredBy // ignore: cast_nullable_to_non_nullable
              as int?,
      vehicleId: freezed == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as int?,
      purpose: null == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as StorageOrderPurpose,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StorageOrderImpl implements _StorageOrder {
  const _$StorageOrderImpl(
      {this.id,
      @JsonKey(name: 'delivery_day') required this.deliveryDay,
      required this.source,
      required this.destination,
      @JsonKey(name: 'storage_order_status') required this.status,
      @JsonKey(name: 'entered_by') this.enteredBy,
      @JsonKey(name: 'prepared_by') this.preparedBy,
      @JsonKey(name: 'packed_by') this.packedBy,
      @JsonKey(name: 'delivered_by') this.deliveredBy,
      @JsonKey(name: 'vehicle_id') this.vehicleId,
      @JsonKey(name: 'storage_order_purpose') required this.purpose,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$StorageOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorageOrderImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'delivery_day')
  final DateTime deliveryDay;
  @override
  final int source;
  @override
  final int destination;
  @override
  @JsonKey(name: 'storage_order_status')
  final StorageOrderStatus status;
  @override
  @JsonKey(name: 'entered_by')
  final int? enteredBy;
  @override
  @JsonKey(name: 'prepared_by')
  final int? preparedBy;
  @override
  @JsonKey(name: 'packed_by')
  final int? packedBy;
  @override
  @JsonKey(name: 'delivered_by')
  final int? deliveredBy;
  @override
  @JsonKey(name: 'vehicle_id')
  final int? vehicleId;
  @override
  @JsonKey(name: 'storage_order_purpose')
  final StorageOrderPurpose purpose;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'StorageOrder(id: $id, deliveryDay: $deliveryDay, source: $source, destination: $destination, status: $status, enteredBy: $enteredBy, preparedBy: $preparedBy, packedBy: $packedBy, deliveredBy: $deliveredBy, vehicleId: $vehicleId, purpose: $purpose, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deliveryDay, deliveryDay) ||
                other.deliveryDay == deliveryDay) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.enteredBy, enteredBy) ||
                other.enteredBy == enteredBy) &&
            (identical(other.preparedBy, preparedBy) ||
                other.preparedBy == preparedBy) &&
            (identical(other.packedBy, packedBy) ||
                other.packedBy == packedBy) &&
            (identical(other.deliveredBy, deliveredBy) ||
                other.deliveredBy == deliveredBy) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      deliveryDay,
      source,
      destination,
      status,
      enteredBy,
      preparedBy,
      packedBy,
      deliveredBy,
      vehicleId,
      purpose,
      createdAt,
      updatedAt);

  /// Create a copy of StorageOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageOrderImplCopyWith<_$StorageOrderImpl> get copyWith =>
      __$$StorageOrderImplCopyWithImpl<_$StorageOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorageOrderImplToJson(
      this,
    );
  }
}

abstract class _StorageOrder implements StorageOrder {
  const factory _StorageOrder(
          {final int? id,
          @JsonKey(name: 'delivery_day') required final DateTime deliveryDay,
          required final int source,
          required final int destination,
          @JsonKey(name: 'storage_order_status')
          required final StorageOrderStatus status,
          @JsonKey(name: 'entered_by') final int? enteredBy,
          @JsonKey(name: 'prepared_by') final int? preparedBy,
          @JsonKey(name: 'packed_by') final int? packedBy,
          @JsonKey(name: 'delivered_by') final int? deliveredBy,
          @JsonKey(name: 'vehicle_id') final int? vehicleId,
          @JsonKey(name: 'storage_order_purpose')
          required final StorageOrderPurpose purpose,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$StorageOrderImpl;

  factory _StorageOrder.fromJson(Map<String, dynamic> json) =
      _$StorageOrderImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'delivery_day')
  DateTime get deliveryDay;
  @override
  int get source;
  @override
  int get destination;
  @override
  @JsonKey(name: 'storage_order_status')
  StorageOrderStatus get status;
  @override
  @JsonKey(name: 'entered_by')
  int? get enteredBy;
  @override
  @JsonKey(name: 'prepared_by')
  int? get preparedBy;
  @override
  @JsonKey(name: 'packed_by')
  int? get packedBy;
  @override
  @JsonKey(name: 'delivered_by')
  int? get deliveredBy;
  @override
  @JsonKey(name: 'vehicle_id')
  int? get vehicleId;
  @override
  @JsonKey(name: 'storage_order_purpose')
  StorageOrderPurpose get purpose;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of StorageOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageOrderImplCopyWith<_$StorageOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StorageOrderItem _$StorageOrderItemFromJson(Map<String, dynamic> json) {
  return _StorageOrderItem.fromJson(json);
}

/// @nodoc
mixin _$StorageOrderItem {
  @JsonKey(name: 'storage_order_id')
  int get storageOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_description_id')
  int get itemDescriptionId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this StorageOrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StorageOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorageOrderItemCopyWith<StorageOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageOrderItemCopyWith<$Res> {
  factory $StorageOrderItemCopyWith(
          StorageOrderItem value, $Res Function(StorageOrderItem) then) =
      _$StorageOrderItemCopyWithImpl<$Res, StorageOrderItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'storage_order_id') int storageOrderId,
      @JsonKey(name: 'item_description_id') int itemDescriptionId,
      int quantity,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$StorageOrderItemCopyWithImpl<$Res, $Val extends StorageOrderItem>
    implements $StorageOrderItemCopyWith<$Res> {
  _$StorageOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorageOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storageOrderId = null,
    Object? itemDescriptionId = null,
    Object? quantity = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      storageOrderId: null == storageOrderId
          ? _value.storageOrderId
          : storageOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      itemDescriptionId: null == itemDescriptionId
          ? _value.itemDescriptionId
          : itemDescriptionId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorageOrderItemImplCopyWith<$Res>
    implements $StorageOrderItemCopyWith<$Res> {
  factory _$$StorageOrderItemImplCopyWith(_$StorageOrderItemImpl value,
          $Res Function(_$StorageOrderItemImpl) then) =
      __$$StorageOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'storage_order_id') int storageOrderId,
      @JsonKey(name: 'item_description_id') int itemDescriptionId,
      int quantity,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$StorageOrderItemImplCopyWithImpl<$Res>
    extends _$StorageOrderItemCopyWithImpl<$Res, _$StorageOrderItemImpl>
    implements _$$StorageOrderItemImplCopyWith<$Res> {
  __$$StorageOrderItemImplCopyWithImpl(_$StorageOrderItemImpl _value,
      $Res Function(_$StorageOrderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of StorageOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storageOrderId = null,
    Object? itemDescriptionId = null,
    Object? quantity = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StorageOrderItemImpl(
      storageOrderId: null == storageOrderId
          ? _value.storageOrderId
          : storageOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      itemDescriptionId: null == itemDescriptionId
          ? _value.itemDescriptionId
          : itemDescriptionId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StorageOrderItemImpl implements _StorageOrderItem {
  const _$StorageOrderItemImpl(
      {@JsonKey(name: 'storage_order_id') required this.storageOrderId,
      @JsonKey(name: 'item_description_id') required this.itemDescriptionId,
      required this.quantity,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$StorageOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorageOrderItemImplFromJson(json);

  @override
  @JsonKey(name: 'storage_order_id')
  final int storageOrderId;
  @override
  @JsonKey(name: 'item_description_id')
  final int itemDescriptionId;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'StorageOrderItem(storageOrderId: $storageOrderId, itemDescriptionId: $itemDescriptionId, quantity: $quantity, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageOrderItemImpl &&
            (identical(other.storageOrderId, storageOrderId) ||
                other.storageOrderId == storageOrderId) &&
            (identical(other.itemDescriptionId, itemDescriptionId) ||
                other.itemDescriptionId == itemDescriptionId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storageOrderId,
      itemDescriptionId, quantity, createdAt, updatedAt);

  /// Create a copy of StorageOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageOrderItemImplCopyWith<_$StorageOrderItemImpl> get copyWith =>
      __$$StorageOrderItemImplCopyWithImpl<_$StorageOrderItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorageOrderItemImplToJson(
      this,
    );
  }
}

abstract class _StorageOrderItem implements StorageOrderItem {
  const factory _StorageOrderItem(
          {@JsonKey(name: 'storage_order_id') required final int storageOrderId,
          @JsonKey(name: 'item_description_id')
          required final int itemDescriptionId,
          required final int quantity,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$StorageOrderItemImpl;

  factory _StorageOrderItem.fromJson(Map<String, dynamic> json) =
      _$StorageOrderItemImpl.fromJson;

  @override
  @JsonKey(name: 'storage_order_id')
  int get storageOrderId;
  @override
  @JsonKey(name: 'item_description_id')
  int get itemDescriptionId;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of StorageOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageOrderItemImplCopyWith<_$StorageOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StorageOrderTrolley _$StorageOrderTrolleyFromJson(Map<String, dynamic> json) {
  return _StorageOrderTrolley.fromJson(json);
}

/// @nodoc
mixin _$StorageOrderTrolley {
  @JsonKey(name: 'storage_order_id')
  int get storageOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'trolley_id')
  int get trolleyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'position_in_vehicle')
  String? get positionInVehicle => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this StorageOrderTrolley to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StorageOrderTrolley
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorageOrderTrolleyCopyWith<StorageOrderTrolley> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageOrderTrolleyCopyWith<$Res> {
  factory $StorageOrderTrolleyCopyWith(
          StorageOrderTrolley value, $Res Function(StorageOrderTrolley) then) =
      _$StorageOrderTrolleyCopyWithImpl<$Res, StorageOrderTrolley>;
  @useResult
  $Res call(
      {@JsonKey(name: 'storage_order_id') int storageOrderId,
      @JsonKey(name: 'trolley_id') int trolleyId,
      @JsonKey(name: 'position_in_vehicle') String? positionInVehicle,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$StorageOrderTrolleyCopyWithImpl<$Res, $Val extends StorageOrderTrolley>
    implements $StorageOrderTrolleyCopyWith<$Res> {
  _$StorageOrderTrolleyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorageOrderTrolley
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storageOrderId = null,
    Object? trolleyId = null,
    Object? positionInVehicle = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      storageOrderId: null == storageOrderId
          ? _value.storageOrderId
          : storageOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      trolleyId: null == trolleyId
          ? _value.trolleyId
          : trolleyId // ignore: cast_nullable_to_non_nullable
              as int,
      positionInVehicle: freezed == positionInVehicle
          ? _value.positionInVehicle
          : positionInVehicle // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorageOrderTrolleyImplCopyWith<$Res>
    implements $StorageOrderTrolleyCopyWith<$Res> {
  factory _$$StorageOrderTrolleyImplCopyWith(_$StorageOrderTrolleyImpl value,
          $Res Function(_$StorageOrderTrolleyImpl) then) =
      __$$StorageOrderTrolleyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'storage_order_id') int storageOrderId,
      @JsonKey(name: 'trolley_id') int trolleyId,
      @JsonKey(name: 'position_in_vehicle') String? positionInVehicle,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$StorageOrderTrolleyImplCopyWithImpl<$Res>
    extends _$StorageOrderTrolleyCopyWithImpl<$Res, _$StorageOrderTrolleyImpl>
    implements _$$StorageOrderTrolleyImplCopyWith<$Res> {
  __$$StorageOrderTrolleyImplCopyWithImpl(_$StorageOrderTrolleyImpl _value,
      $Res Function(_$StorageOrderTrolleyImpl) _then)
      : super(_value, _then);

  /// Create a copy of StorageOrderTrolley
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storageOrderId = null,
    Object? trolleyId = null,
    Object? positionInVehicle = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StorageOrderTrolleyImpl(
      storageOrderId: null == storageOrderId
          ? _value.storageOrderId
          : storageOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      trolleyId: null == trolleyId
          ? _value.trolleyId
          : trolleyId // ignore: cast_nullable_to_non_nullable
              as int,
      positionInVehicle: freezed == positionInVehicle
          ? _value.positionInVehicle
          : positionInVehicle // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StorageOrderTrolleyImpl implements _StorageOrderTrolley {
  const _$StorageOrderTrolleyImpl(
      {@JsonKey(name: 'storage_order_id') required this.storageOrderId,
      @JsonKey(name: 'trolley_id') required this.trolleyId,
      @JsonKey(name: 'position_in_vehicle') this.positionInVehicle,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$StorageOrderTrolleyImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorageOrderTrolleyImplFromJson(json);

  @override
  @JsonKey(name: 'storage_order_id')
  final int storageOrderId;
  @override
  @JsonKey(name: 'trolley_id')
  final int trolleyId;
  @override
  @JsonKey(name: 'position_in_vehicle')
  final String? positionInVehicle;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'StorageOrderTrolley(storageOrderId: $storageOrderId, trolleyId: $trolleyId, positionInVehicle: $positionInVehicle, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageOrderTrolleyImpl &&
            (identical(other.storageOrderId, storageOrderId) ||
                other.storageOrderId == storageOrderId) &&
            (identical(other.trolleyId, trolleyId) ||
                other.trolleyId == trolleyId) &&
            (identical(other.positionInVehicle, positionInVehicle) ||
                other.positionInVehicle == positionInVehicle) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storageOrderId, trolleyId,
      positionInVehicle, createdAt, updatedAt);

  /// Create a copy of StorageOrderTrolley
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageOrderTrolleyImplCopyWith<_$StorageOrderTrolleyImpl> get copyWith =>
      __$$StorageOrderTrolleyImplCopyWithImpl<_$StorageOrderTrolleyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorageOrderTrolleyImplToJson(
      this,
    );
  }
}

abstract class _StorageOrderTrolley implements StorageOrderTrolley {
  const factory _StorageOrderTrolley(
          {@JsonKey(name: 'storage_order_id') required final int storageOrderId,
          @JsonKey(name: 'trolley_id') required final int trolleyId,
          @JsonKey(name: 'position_in_vehicle') final String? positionInVehicle,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$StorageOrderTrolleyImpl;

  factory _StorageOrderTrolley.fromJson(Map<String, dynamic> json) =
      _$StorageOrderTrolleyImpl.fromJson;

  @override
  @JsonKey(name: 'storage_order_id')
  int get storageOrderId;
  @override
  @JsonKey(name: 'trolley_id')
  int get trolleyId;
  @override
  @JsonKey(name: 'position_in_vehicle')
  String? get positionInVehicle;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of StorageOrderTrolley
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageOrderTrolleyImplCopyWith<_$StorageOrderTrolleyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemDescription _$ItemDescriptionFromJson(Map<String, dynamic> json) {
  return _ItemDescription.fromJson(json);
}

/// @nodoc
mixin _$ItemDescription {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_pl')
  String get namePl => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_en')
  String get nameEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ua')
  String get nameUa => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_pl')
  String? get descriptionPl => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_en')
  String? get descriptionEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_ua')
  String? get descriptionUa => throw _privateConstructorUsedError;
  @JsonKey(name: 'allergens_pl')
  String? get allergensPl => throw _privateConstructorUsedError;
  @JsonKey(name: 'allergens_en')
  String? get allergensEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'allergens_ua')
  String? get allergensUa => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  ItemCategory get category => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ItemDescription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemDescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemDescriptionCopyWith<ItemDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemDescriptionCopyWith<$Res> {
  factory $ItemDescriptionCopyWith(
          ItemDescription value, $Res Function(ItemDescription) then) =
      _$ItemDescriptionCopyWithImpl<$Res, ItemDescription>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name_pl') String namePl,
      @JsonKey(name: 'name_en') String nameEn,
      @JsonKey(name: 'name_ua') String nameUa,
      @JsonKey(name: 'description_pl') String? descriptionPl,
      @JsonKey(name: 'description_en') String? descriptionEn,
      @JsonKey(name: 'description_ua') String? descriptionUa,
      @JsonKey(name: 'allergens_pl') String? allergensPl,
      @JsonKey(name: 'allergens_en') String? allergensEn,
      @JsonKey(name: 'allergens_ua') String? allergensUa,
      @JsonKey(name: 'category') ItemCategory category,
      String? image,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$ItemDescriptionCopyWithImpl<$Res, $Val extends ItemDescription>
    implements $ItemDescriptionCopyWith<$Res> {
  _$ItemDescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemDescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? namePl = null,
    Object? nameEn = null,
    Object? nameUa = null,
    Object? descriptionPl = freezed,
    Object? descriptionEn = freezed,
    Object? descriptionUa = freezed,
    Object? allergensPl = freezed,
    Object? allergensEn = freezed,
    Object? allergensUa = freezed,
    Object? category = null,
    Object? image = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      namePl: null == namePl
          ? _value.namePl
          : namePl // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      nameUa: null == nameUa
          ? _value.nameUa
          : nameUa // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionPl: freezed == descriptionPl
          ? _value.descriptionPl
          : descriptionPl // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionEn: freezed == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionUa: freezed == descriptionUa
          ? _value.descriptionUa
          : descriptionUa // ignore: cast_nullable_to_non_nullable
              as String?,
      allergensPl: freezed == allergensPl
          ? _value.allergensPl
          : allergensPl // ignore: cast_nullable_to_non_nullable
              as String?,
      allergensEn: freezed == allergensEn
          ? _value.allergensEn
          : allergensEn // ignore: cast_nullable_to_non_nullable
              as String?,
      allergensUa: freezed == allergensUa
          ? _value.allergensUa
          : allergensUa // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ItemCategory,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemDescriptionImplCopyWith<$Res>
    implements $ItemDescriptionCopyWith<$Res> {
  factory _$$ItemDescriptionImplCopyWith(_$ItemDescriptionImpl value,
          $Res Function(_$ItemDescriptionImpl) then) =
      __$$ItemDescriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name_pl') String namePl,
      @JsonKey(name: 'name_en') String nameEn,
      @JsonKey(name: 'name_ua') String nameUa,
      @JsonKey(name: 'description_pl') String? descriptionPl,
      @JsonKey(name: 'description_en') String? descriptionEn,
      @JsonKey(name: 'description_ua') String? descriptionUa,
      @JsonKey(name: 'allergens_pl') String? allergensPl,
      @JsonKey(name: 'allergens_en') String? allergensEn,
      @JsonKey(name: 'allergens_ua') String? allergensUa,
      @JsonKey(name: 'category') ItemCategory category,
      String? image,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$ItemDescriptionImplCopyWithImpl<$Res>
    extends _$ItemDescriptionCopyWithImpl<$Res, _$ItemDescriptionImpl>
    implements _$$ItemDescriptionImplCopyWith<$Res> {
  __$$ItemDescriptionImplCopyWithImpl(
      _$ItemDescriptionImpl _value, $Res Function(_$ItemDescriptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemDescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? namePl = null,
    Object? nameEn = null,
    Object? nameUa = null,
    Object? descriptionPl = freezed,
    Object? descriptionEn = freezed,
    Object? descriptionUa = freezed,
    Object? allergensPl = freezed,
    Object? allergensEn = freezed,
    Object? allergensUa = freezed,
    Object? category = null,
    Object? image = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ItemDescriptionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      namePl: null == namePl
          ? _value.namePl
          : namePl // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      nameUa: null == nameUa
          ? _value.nameUa
          : nameUa // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionPl: freezed == descriptionPl
          ? _value.descriptionPl
          : descriptionPl // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionEn: freezed == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionUa: freezed == descriptionUa
          ? _value.descriptionUa
          : descriptionUa // ignore: cast_nullable_to_non_nullable
              as String?,
      allergensPl: freezed == allergensPl
          ? _value.allergensPl
          : allergensPl // ignore: cast_nullable_to_non_nullable
              as String?,
      allergensEn: freezed == allergensEn
          ? _value.allergensEn
          : allergensEn // ignore: cast_nullable_to_non_nullable
              as String?,
      allergensUa: freezed == allergensUa
          ? _value.allergensUa
          : allergensUa // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ItemCategory,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemDescriptionImpl implements _ItemDescription {
  const _$ItemDescriptionImpl(
      {this.id,
      @JsonKey(name: 'name_pl') required this.namePl,
      @JsonKey(name: 'name_en') required this.nameEn,
      @JsonKey(name: 'name_ua') required this.nameUa,
      @JsonKey(name: 'description_pl') this.descriptionPl,
      @JsonKey(name: 'description_en') this.descriptionEn,
      @JsonKey(name: 'description_ua') this.descriptionUa,
      @JsonKey(name: 'allergens_pl') this.allergensPl,
      @JsonKey(name: 'allergens_en') this.allergensEn,
      @JsonKey(name: 'allergens_ua') this.allergensUa,
      @JsonKey(name: 'category') required this.category,
      this.image,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$ItemDescriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemDescriptionImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'name_pl')
  final String namePl;
  @override
  @JsonKey(name: 'name_en')
  final String nameEn;
  @override
  @JsonKey(name: 'name_ua')
  final String nameUa;
  @override
  @JsonKey(name: 'description_pl')
  final String? descriptionPl;
  @override
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @override
  @JsonKey(name: 'description_ua')
  final String? descriptionUa;
  @override
  @JsonKey(name: 'allergens_pl')
  final String? allergensPl;
  @override
  @JsonKey(name: 'allergens_en')
  final String? allergensEn;
  @override
  @JsonKey(name: 'allergens_ua')
  final String? allergensUa;
  @override
  @JsonKey(name: 'category')
  final ItemCategory category;
  @override
  final String? image;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ItemDescription(id: $id, namePl: $namePl, nameEn: $nameEn, nameUa: $nameUa, descriptionPl: $descriptionPl, descriptionEn: $descriptionEn, descriptionUa: $descriptionUa, allergensPl: $allergensPl, allergensEn: $allergensEn, allergensUa: $allergensUa, category: $category, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemDescriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.namePl, namePl) || other.namePl == namePl) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.nameUa, nameUa) || other.nameUa == nameUa) &&
            (identical(other.descriptionPl, descriptionPl) ||
                other.descriptionPl == descriptionPl) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.descriptionUa, descriptionUa) ||
                other.descriptionUa == descriptionUa) &&
            (identical(other.allergensPl, allergensPl) ||
                other.allergensPl == allergensPl) &&
            (identical(other.allergensEn, allergensEn) ||
                other.allergensEn == allergensEn) &&
            (identical(other.allergensUa, allergensUa) ||
                other.allergensUa == allergensUa) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      namePl,
      nameEn,
      nameUa,
      descriptionPl,
      descriptionEn,
      descriptionUa,
      allergensPl,
      allergensEn,
      allergensUa,
      category,
      image,
      createdAt,
      updatedAt);

  /// Create a copy of ItemDescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemDescriptionImplCopyWith<_$ItemDescriptionImpl> get copyWith =>
      __$$ItemDescriptionImplCopyWithImpl<_$ItemDescriptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemDescriptionImplToJson(
      this,
    );
  }
}

abstract class _ItemDescription implements ItemDescription {
  const factory _ItemDescription(
          {final int? id,
          @JsonKey(name: 'name_pl') required final String namePl,
          @JsonKey(name: 'name_en') required final String nameEn,
          @JsonKey(name: 'name_ua') required final String nameUa,
          @JsonKey(name: 'description_pl') final String? descriptionPl,
          @JsonKey(name: 'description_en') final String? descriptionEn,
          @JsonKey(name: 'description_ua') final String? descriptionUa,
          @JsonKey(name: 'allergens_pl') final String? allergensPl,
          @JsonKey(name: 'allergens_en') final String? allergensEn,
          @JsonKey(name: 'allergens_ua') final String? allergensUa,
          @JsonKey(name: 'category') required final ItemCategory category,
          final String? image,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$ItemDescriptionImpl;

  factory _ItemDescription.fromJson(Map<String, dynamic> json) =
      _$ItemDescriptionImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'name_pl')
  String get namePl;
  @override
  @JsonKey(name: 'name_en')
  String get nameEn;
  @override
  @JsonKey(name: 'name_ua')
  String get nameUa;
  @override
  @JsonKey(name: 'description_pl')
  String? get descriptionPl;
  @override
  @JsonKey(name: 'description_en')
  String? get descriptionEn;
  @override
  @JsonKey(name: 'description_ua')
  String? get descriptionUa;
  @override
  @JsonKey(name: 'allergens_pl')
  String? get allergensPl;
  @override
  @JsonKey(name: 'allergens_en')
  String? get allergensEn;
  @override
  @JsonKey(name: 'allergens_ua')
  String? get allergensUa;
  @override
  @JsonKey(name: 'category')
  ItemCategory get category;
  @override
  String? get image;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of ItemDescription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemDescriptionImplCopyWith<_$ItemDescriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return _Menu.fromJson(json);
}

/// @nodoc
mixin _$Menu {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Menu to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuCopyWith<Menu> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuCopyWith<$Res> {
  factory $MenuCopyWith(Menu value, $Res Function(Menu) then) =
      _$MenuCopyWithImpl<$Res, Menu>;
  @useResult
  $Res call(
      {int? id,
      String name,
      String? description,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$MenuCopyWithImpl<$Res, $Val extends Menu>
    implements $MenuCopyWith<$Res> {
  _$MenuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuImplCopyWith<$Res> implements $MenuCopyWith<$Res> {
  factory _$$MenuImplCopyWith(
          _$MenuImpl value, $Res Function(_$MenuImpl) then) =
      __$$MenuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      String? description,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$MenuImplCopyWithImpl<$Res>
    extends _$MenuCopyWithImpl<$Res, _$MenuImpl>
    implements _$$MenuImplCopyWith<$Res> {
  __$$MenuImplCopyWithImpl(_$MenuImpl _value, $Res Function(_$MenuImpl) _then)
      : super(_value, _then);

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MenuImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuImpl implements _Menu {
  const _$MenuImpl(
      {this.id,
      required this.name,
      this.description,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$MenuImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Menu(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, createdAt, updatedAt);

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuImplCopyWith<_$MenuImpl> get copyWith =>
      __$$MenuImplCopyWithImpl<_$MenuImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuImplToJson(
      this,
    );
  }
}

abstract class _Menu implements Menu {
  const factory _Menu(
      {final int? id,
      required final String name,
      final String? description,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$MenuImpl;

  factory _Menu.fromJson(Map<String, dynamic> json) = _$MenuImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Menu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuImplCopyWith<_$MenuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MenuItemPrice _$MenuItemPriceFromJson(Map<String, dynamic> json) {
  return _MenuItemPrice.fromJson(json);
}

/// @nodoc
mixin _$MenuItemPrice {
  @JsonKey(name: 'menu_id')
  int get menuId => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_id')
  int get itemId => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MenuItemPrice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItemPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemPriceCopyWith<MenuItemPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemPriceCopyWith<$Res> {
  factory $MenuItemPriceCopyWith(
          MenuItemPrice value, $Res Function(MenuItemPrice) then) =
      _$MenuItemPriceCopyWithImpl<$Res, MenuItemPrice>;
  @useResult
  $Res call(
      {@JsonKey(name: 'menu_id') int menuId,
      @JsonKey(name: 'item_id') int itemId,
      double price,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$MenuItemPriceCopyWithImpl<$Res, $Val extends MenuItemPrice>
    implements $MenuItemPriceCopyWith<$Res> {
  _$MenuItemPriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItemPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuId = null,
    Object? itemId = null,
    Object? price = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      menuId: null == menuId
          ? _value.menuId
          : menuId // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuItemPriceImplCopyWith<$Res>
    implements $MenuItemPriceCopyWith<$Res> {
  factory _$$MenuItemPriceImplCopyWith(
          _$MenuItemPriceImpl value, $Res Function(_$MenuItemPriceImpl) then) =
      __$$MenuItemPriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'menu_id') int menuId,
      @JsonKey(name: 'item_id') int itemId,
      double price,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$MenuItemPriceImplCopyWithImpl<$Res>
    extends _$MenuItemPriceCopyWithImpl<$Res, _$MenuItemPriceImpl>
    implements _$$MenuItemPriceImplCopyWith<$Res> {
  __$$MenuItemPriceImplCopyWithImpl(
      _$MenuItemPriceImpl _value, $Res Function(_$MenuItemPriceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MenuItemPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuId = null,
    Object? itemId = null,
    Object? price = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MenuItemPriceImpl(
      menuId: null == menuId
          ? _value.menuId
          : menuId // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuItemPriceImpl implements _MenuItemPrice {
  const _$MenuItemPriceImpl(
      {@JsonKey(name: 'menu_id') required this.menuId,
      @JsonKey(name: 'item_id') required this.itemId,
      required this.price,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$MenuItemPriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemPriceImplFromJson(json);

  @override
  @JsonKey(name: 'menu_id')
  final int menuId;
  @override
  @JsonKey(name: 'item_id')
  final int itemId;
  @override
  final double price;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'MenuItemPrice(menuId: $menuId, itemId: $itemId, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemPriceImpl &&
            (identical(other.menuId, menuId) || other.menuId == menuId) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, menuId, itemId, price, createdAt, updatedAt);

  /// Create a copy of MenuItemPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemPriceImplCopyWith<_$MenuItemPriceImpl> get copyWith =>
      __$$MenuItemPriceImplCopyWithImpl<_$MenuItemPriceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemPriceImplToJson(
      this,
    );
  }
}

abstract class _MenuItemPrice implements MenuItemPrice {
  const factory _MenuItemPrice(
          {@JsonKey(name: 'menu_id') required final int menuId,
          @JsonKey(name: 'item_id') required final int itemId,
          required final double price,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$MenuItemPriceImpl;

  factory _MenuItemPrice.fromJson(Map<String, dynamic> json) =
      _$MenuItemPriceImpl.fromJson;

  @override
  @JsonKey(name: 'menu_id')
  int get menuId;
  @override
  @JsonKey(name: 'item_id')
  int get itemId;
  @override
  double get price;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of MenuItemPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemPriceImplCopyWith<_$MenuItemPriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApsDescription _$ApsDescriptionFromJson(Map<String, dynamic> json) {
  return _ApsDescription.fromJson(json);
}

/// @nodoc
mixin _$ApsDescription {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @PointWkbConverter()
  Point get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_id')
  int get storageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'menu_id')
  int get menuId => throw _privateConstructorUsedError;
  ApsState get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ApsDescription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApsDescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApsDescriptionCopyWith<ApsDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApsDescriptionCopyWith<$Res> {
  factory $ApsDescriptionCopyWith(
          ApsDescription value, $Res Function(ApsDescription) then) =
      _$ApsDescriptionCopyWithImpl<$Res, ApsDescription>;
  @useResult
  $Res call(
      {int? id,
      String name,
      String address,
      @PointWkbConverter() Point location,
      @JsonKey(name: 'storage_id') int storageId,
      @JsonKey(name: 'menu_id') int menuId,
      ApsState state,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$ApsDescriptionCopyWithImpl<$Res, $Val extends ApsDescription>
    implements $ApsDescriptionCopyWith<$Res> {
  _$ApsDescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApsDescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? address = null,
    Object? location = null,
    Object? storageId = null,
    Object? menuId = null,
    Object? state = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Point,
      storageId: null == storageId
          ? _value.storageId
          : storageId // ignore: cast_nullable_to_non_nullable
              as int,
      menuId: null == menuId
          ? _value.menuId
          : menuId // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ApsState,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApsDescriptionImplCopyWith<$Res>
    implements $ApsDescriptionCopyWith<$Res> {
  factory _$$ApsDescriptionImplCopyWith(_$ApsDescriptionImpl value,
          $Res Function(_$ApsDescriptionImpl) then) =
      __$$ApsDescriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      String address,
      @PointWkbConverter() Point location,
      @JsonKey(name: 'storage_id') int storageId,
      @JsonKey(name: 'menu_id') int menuId,
      ApsState state,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$ApsDescriptionImplCopyWithImpl<$Res>
    extends _$ApsDescriptionCopyWithImpl<$Res, _$ApsDescriptionImpl>
    implements _$$ApsDescriptionImplCopyWith<$Res> {
  __$$ApsDescriptionImplCopyWithImpl(
      _$ApsDescriptionImpl _value, $Res Function(_$ApsDescriptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApsDescription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? address = null,
    Object? location = null,
    Object? storageId = null,
    Object? menuId = null,
    Object? state = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ApsDescriptionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Point,
      storageId: null == storageId
          ? _value.storageId
          : storageId // ignore: cast_nullable_to_non_nullable
              as int,
      menuId: null == menuId
          ? _value.menuId
          : menuId // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ApsState,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApsDescriptionImpl implements _ApsDescription {
  const _$ApsDescriptionImpl(
      {this.id,
      required this.name,
      required this.address,
      @PointWkbConverter() required this.location,
      @JsonKey(name: 'storage_id') required this.storageId,
      @JsonKey(name: 'menu_id') required this.menuId,
      required this.state,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$ApsDescriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApsDescriptionImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String address;
  @override
  @PointWkbConverter()
  final Point location;
  @override
  @JsonKey(name: 'storage_id')
  final int storageId;
  @override
  @JsonKey(name: 'menu_id')
  final int menuId;
  @override
  final ApsState state;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ApsDescription(id: $id, name: $name, address: $address, location: $location, storageId: $storageId, menuId: $menuId, state: $state, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApsDescriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.storageId, storageId) ||
                other.storageId == storageId) &&
            (identical(other.menuId, menuId) || other.menuId == menuId) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address, location,
      storageId, menuId, state, createdAt, updatedAt);

  /// Create a copy of ApsDescription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApsDescriptionImplCopyWith<_$ApsDescriptionImpl> get copyWith =>
      __$$ApsDescriptionImplCopyWithImpl<_$ApsDescriptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApsDescriptionImplToJson(
      this,
    );
  }
}

abstract class _ApsDescription implements ApsDescription {
  const factory _ApsDescription(
          {final int? id,
          required final String name,
          required final String address,
          @PointWkbConverter() required final Point location,
          @JsonKey(name: 'storage_id') required final int storageId,
          @JsonKey(name: 'menu_id') required final int menuId,
          required final ApsState state,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$ApsDescriptionImpl;

  factory _ApsDescription.fromJson(Map<String, dynamic> json) =
      _$ApsDescriptionImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String get address;
  @override
  @PointWkbConverter()
  Point get location;
  @override
  @JsonKey(name: 'storage_id')
  int get storageId;
  @override
  @JsonKey(name: 'menu_id')
  int get menuId;
  @override
  ApsState get state;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of ApsDescription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApsDescriptionImplCopyWith<_$ApsDescriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApsOrder _$ApsOrderFromJson(Map<String, dynamic> json) {
  return _ApsOrder.fromJson(json);
}

/// @nodoc
mixin _$ApsOrder {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'aps_id')
  int get apsId => throw _privateConstructorUsedError;
  OriginType get origin => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup_number')
  PickupNumber? get pickupNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'kds_order_number')
  int? get kdsOrderNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_phone_number')
  String? get clientPhoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_time')
  int get estimatedTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ApsOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApsOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApsOrderCopyWith<ApsOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApsOrderCopyWith<$Res> {
  factory $ApsOrderCopyWith(ApsOrder value, $Res Function(ApsOrder) then) =
      _$ApsOrderCopyWithImpl<$Res, ApsOrder>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'aps_id') int apsId,
      OriginType origin,
      OrderStatus status,
      @JsonKey(name: 'pickup_number') PickupNumber? pickupNumber,
      @JsonKey(name: 'kds_order_number') int? kdsOrderNumber,
      @JsonKey(name: 'client_phone_number') String? clientPhoneNumber,
      @JsonKey(name: 'estimated_time') int estimatedTime,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$ApsOrderCopyWithImpl<$Res, $Val extends ApsOrder>
    implements $ApsOrderCopyWith<$Res> {
  _$ApsOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApsOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? apsId = null,
    Object? origin = null,
    Object? status = null,
    Object? pickupNumber = freezed,
    Object? kdsOrderNumber = freezed,
    Object? clientPhoneNumber = freezed,
    Object? estimatedTime = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      apsId: null == apsId
          ? _value.apsId
          : apsId // ignore: cast_nullable_to_non_nullable
              as int,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as OriginType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      pickupNumber: freezed == pickupNumber
          ? _value.pickupNumber
          : pickupNumber // ignore: cast_nullable_to_non_nullable
              as PickupNumber?,
      kdsOrderNumber: freezed == kdsOrderNumber
          ? _value.kdsOrderNumber
          : kdsOrderNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      clientPhoneNumber: freezed == clientPhoneNumber
          ? _value.clientPhoneNumber
          : clientPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedTime: null == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApsOrderImplCopyWith<$Res>
    implements $ApsOrderCopyWith<$Res> {
  factory _$$ApsOrderImplCopyWith(
          _$ApsOrderImpl value, $Res Function(_$ApsOrderImpl) then) =
      __$$ApsOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'aps_id') int apsId,
      OriginType origin,
      OrderStatus status,
      @JsonKey(name: 'pickup_number') PickupNumber? pickupNumber,
      @JsonKey(name: 'kds_order_number') int? kdsOrderNumber,
      @JsonKey(name: 'client_phone_number') String? clientPhoneNumber,
      @JsonKey(name: 'estimated_time') int estimatedTime,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$ApsOrderImplCopyWithImpl<$Res>
    extends _$ApsOrderCopyWithImpl<$Res, _$ApsOrderImpl>
    implements _$$ApsOrderImplCopyWith<$Res> {
  __$$ApsOrderImplCopyWithImpl(
      _$ApsOrderImpl _value, $Res Function(_$ApsOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApsOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? apsId = null,
    Object? origin = null,
    Object? status = null,
    Object? pickupNumber = freezed,
    Object? kdsOrderNumber = freezed,
    Object? clientPhoneNumber = freezed,
    Object? estimatedTime = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ApsOrderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      apsId: null == apsId
          ? _value.apsId
          : apsId // ignore: cast_nullable_to_non_nullable
              as int,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as OriginType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      pickupNumber: freezed == pickupNumber
          ? _value.pickupNumber
          : pickupNumber // ignore: cast_nullable_to_non_nullable
              as PickupNumber?,
      kdsOrderNumber: freezed == kdsOrderNumber
          ? _value.kdsOrderNumber
          : kdsOrderNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      clientPhoneNumber: freezed == clientPhoneNumber
          ? _value.clientPhoneNumber
          : clientPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedTime: null == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApsOrderImpl implements _ApsOrder {
  const _$ApsOrderImpl(
      {this.id,
      @JsonKey(name: 'aps_id') required this.apsId,
      required this.origin,
      required this.status,
      @JsonKey(name: 'pickup_number') this.pickupNumber,
      @JsonKey(name: 'kds_order_number') this.kdsOrderNumber,
      @JsonKey(name: 'client_phone_number') this.clientPhoneNumber,
      @JsonKey(name: 'estimated_time') required this.estimatedTime,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$ApsOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApsOrderImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'aps_id')
  final int apsId;
  @override
  final OriginType origin;
  @override
  final OrderStatus status;
  @override
  @JsonKey(name: 'pickup_number')
  final PickupNumber? pickupNumber;
  @override
  @JsonKey(name: 'kds_order_number')
  final int? kdsOrderNumber;
  @override
  @JsonKey(name: 'client_phone_number')
  final String? clientPhoneNumber;
  @override
  @JsonKey(name: 'estimated_time')
  final int estimatedTime;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ApsOrder(id: $id, apsId: $apsId, origin: $origin, status: $status, pickupNumber: $pickupNumber, kdsOrderNumber: $kdsOrderNumber, clientPhoneNumber: $clientPhoneNumber, estimatedTime: $estimatedTime, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApsOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apsId, apsId) || other.apsId == apsId) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.pickupNumber, pickupNumber) ||
                other.pickupNumber == pickupNumber) &&
            (identical(other.kdsOrderNumber, kdsOrderNumber) ||
                other.kdsOrderNumber == kdsOrderNumber) &&
            (identical(other.clientPhoneNumber, clientPhoneNumber) ||
                other.clientPhoneNumber == clientPhoneNumber) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      apsId,
      origin,
      status,
      pickupNumber,
      kdsOrderNumber,
      clientPhoneNumber,
      estimatedTime,
      createdAt,
      updatedAt);

  /// Create a copy of ApsOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApsOrderImplCopyWith<_$ApsOrderImpl> get copyWith =>
      __$$ApsOrderImplCopyWithImpl<_$ApsOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApsOrderImplToJson(
      this,
    );
  }
}

abstract class _ApsOrder implements ApsOrder {
  const factory _ApsOrder(
      {final int? id,
      @JsonKey(name: 'aps_id') required final int apsId,
      required final OriginType origin,
      required final OrderStatus status,
      @JsonKey(name: 'pickup_number') final PickupNumber? pickupNumber,
      @JsonKey(name: 'kds_order_number') final int? kdsOrderNumber,
      @JsonKey(name: 'client_phone_number') final String? clientPhoneNumber,
      @JsonKey(name: 'estimated_time') required final int estimatedTime,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$ApsOrderImpl;

  factory _ApsOrder.fromJson(Map<String, dynamic> json) =
      _$ApsOrderImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'aps_id')
  int get apsId;
  @override
  OriginType get origin;
  @override
  OrderStatus get status;
  @override
  @JsonKey(name: 'pickup_number')
  PickupNumber? get pickupNumber;
  @override
  @JsonKey(name: 'kds_order_number')
  int? get kdsOrderNumber;
  @override
  @JsonKey(name: 'client_phone_number')
  String? get clientPhoneNumber;
  @override
  @JsonKey(name: 'estimated_time')
  int get estimatedTime;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of ApsOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApsOrderImplCopyWith<_$ApsOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApsOrderItem _$ApsOrderItemFromJson(Map<String, dynamic> json) {
  return _ApsOrderItem.fromJson(json);
}

/// @nodoc
mixin _$ApsOrderItem {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'aps_order_id')
  int get apsOrderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'aps_id')
  int get apsId => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_id')
  int get itemId => throw _privateConstructorUsedError;
  ItemStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ApsOrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApsOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApsOrderItemCopyWith<ApsOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApsOrderItemCopyWith<$Res> {
  factory $ApsOrderItemCopyWith(
          ApsOrderItem value, $Res Function(ApsOrderItem) then) =
      _$ApsOrderItemCopyWithImpl<$Res, ApsOrderItem>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'aps_order_id') int apsOrderId,
      @JsonKey(name: 'aps_id') int apsId,
      @JsonKey(name: 'item_id') int itemId,
      ItemStatus status,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$ApsOrderItemCopyWithImpl<$Res, $Val extends ApsOrderItem>
    implements $ApsOrderItemCopyWith<$Res> {
  _$ApsOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApsOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? apsOrderId = null,
    Object? apsId = null,
    Object? itemId = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      apsOrderId: null == apsOrderId
          ? _value.apsOrderId
          : apsOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      apsId: null == apsId
          ? _value.apsId
          : apsId // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ItemStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApsOrderItemImplCopyWith<$Res>
    implements $ApsOrderItemCopyWith<$Res> {
  factory _$$ApsOrderItemImplCopyWith(
          _$ApsOrderItemImpl value, $Res Function(_$ApsOrderItemImpl) then) =
      __$$ApsOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'aps_order_id') int apsOrderId,
      @JsonKey(name: 'aps_id') int apsId,
      @JsonKey(name: 'item_id') int itemId,
      ItemStatus status,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$ApsOrderItemImplCopyWithImpl<$Res>
    extends _$ApsOrderItemCopyWithImpl<$Res, _$ApsOrderItemImpl>
    implements _$$ApsOrderItemImplCopyWith<$Res> {
  __$$ApsOrderItemImplCopyWithImpl(
      _$ApsOrderItemImpl _value, $Res Function(_$ApsOrderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApsOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? apsOrderId = null,
    Object? apsId = null,
    Object? itemId = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ApsOrderItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      apsOrderId: null == apsOrderId
          ? _value.apsOrderId
          : apsOrderId // ignore: cast_nullable_to_non_nullable
              as int,
      apsId: null == apsId
          ? _value.apsId
          : apsId // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ItemStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApsOrderItemImpl implements _ApsOrderItem {
  const _$ApsOrderItemImpl(
      {this.id,
      @JsonKey(name: 'aps_order_id') required this.apsOrderId,
      @JsonKey(name: 'aps_id') required this.apsId,
      @JsonKey(name: 'item_id') required this.itemId,
      required this.status,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$ApsOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApsOrderItemImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'aps_order_id')
  final int apsOrderId;
  @override
  @JsonKey(name: 'aps_id')
  final int apsId;
  @override
  @JsonKey(name: 'item_id')
  final int itemId;
  @override
  final ItemStatus status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ApsOrderItem(id: $id, apsOrderId: $apsOrderId, apsId: $apsId, itemId: $itemId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApsOrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apsOrderId, apsOrderId) ||
                other.apsOrderId == apsOrderId) &&
            (identical(other.apsId, apsId) || other.apsId == apsId) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, apsOrderId, apsId, itemId, status, createdAt, updatedAt);

  /// Create a copy of ApsOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApsOrderItemImplCopyWith<_$ApsOrderItemImpl> get copyWith =>
      __$$ApsOrderItemImplCopyWithImpl<_$ApsOrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApsOrderItemImplToJson(
      this,
    );
  }
}

abstract class _ApsOrderItem implements ApsOrderItem {
  const factory _ApsOrderItem(
          {final int? id,
          @JsonKey(name: 'aps_order_id') required final int apsOrderId,
          @JsonKey(name: 'aps_id') required final int apsId,
          @JsonKey(name: 'item_id') required final int itemId,
          required final ItemStatus status,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$ApsOrderItemImpl;

  factory _ApsOrderItem.fromJson(Map<String, dynamic> json) =
      _$ApsOrderItemImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'aps_order_id')
  int get apsOrderId;
  @override
  @JsonKey(name: 'aps_id')
  int get apsId;
  @override
  @JsonKey(name: 'item_id')
  int get itemId;
  @override
  ItemStatus get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of ApsOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApsOrderItemImplCopyWith<_$ApsOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Waypoint _$WaypointFromJson(Map<String, dynamic> json) {
  return _Waypoint.fromJson(json);
}

/// @nodoc
mixin _$Waypoint {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'waypoint_name')
  String? get waypointName => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get z => throw _privateConstructorUsedError;
  double get qx => throw _privateConstructorUsedError;
  double get qy => throw _privateConstructorUsedError;
  double get qz => throw _privateConstructorUsedError;
  double get qw => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset_x')
  double? get offsetX => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset_y')
  double? get offsetY => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset_z')
  double? get offsetZ => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset_qx')
  double? get offsetQx => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset_qy')
  double? get offsetQy => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset_qz')
  double? get offsetQz => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset_qw')
  double? get offsetQw => throw _privateConstructorUsedError;
  @JsonKey(name: 'qr_rotation')
  double? get qrRotation => throw _privateConstructorUsedError;
  @JsonKey(name: 'oven_rotation')
  double? get ovenRotation => throw _privateConstructorUsedError;

  /// Serializes this Waypoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WaypointCopyWith<Waypoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaypointCopyWith<$Res> {
  factory $WaypointCopyWith(Waypoint value, $Res Function(Waypoint) then) =
      _$WaypointCopyWithImpl<$Res, Waypoint>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'waypoint_name') String? waypointName,
      double x,
      double y,
      double z,
      double qx,
      double qy,
      double qz,
      double qw,
      @JsonKey(name: 'offset_x') double? offsetX,
      @JsonKey(name: 'offset_y') double? offsetY,
      @JsonKey(name: 'offset_z') double? offsetZ,
      @JsonKey(name: 'offset_qx') double? offsetQx,
      @JsonKey(name: 'offset_qy') double? offsetQy,
      @JsonKey(name: 'offset_qz') double? offsetQz,
      @JsonKey(name: 'offset_qw') double? offsetQw,
      @JsonKey(name: 'qr_rotation') double? qrRotation,
      @JsonKey(name: 'oven_rotation') double? ovenRotation});
}

/// @nodoc
class _$WaypointCopyWithImpl<$Res, $Val extends Waypoint>
    implements $WaypointCopyWith<$Res> {
  _$WaypointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? waypointName = freezed,
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? qx = null,
    Object? qy = null,
    Object? qz = null,
    Object? qw = null,
    Object? offsetX = freezed,
    Object? offsetY = freezed,
    Object? offsetZ = freezed,
    Object? offsetQx = freezed,
    Object? offsetQy = freezed,
    Object? offsetQz = freezed,
    Object? offsetQw = freezed,
    Object? qrRotation = freezed,
    Object? ovenRotation = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      waypointName: freezed == waypointName
          ? _value.waypointName
          : waypointName // ignore: cast_nullable_to_non_nullable
              as String?,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      qx: null == qx
          ? _value.qx
          : qx // ignore: cast_nullable_to_non_nullable
              as double,
      qy: null == qy
          ? _value.qy
          : qy // ignore: cast_nullable_to_non_nullable
              as double,
      qz: null == qz
          ? _value.qz
          : qz // ignore: cast_nullable_to_non_nullable
              as double,
      qw: null == qw
          ? _value.qw
          : qw // ignore: cast_nullable_to_non_nullable
              as double,
      offsetX: freezed == offsetX
          ? _value.offsetX
          : offsetX // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetY: freezed == offsetY
          ? _value.offsetY
          : offsetY // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetZ: freezed == offsetZ
          ? _value.offsetZ
          : offsetZ // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetQx: freezed == offsetQx
          ? _value.offsetQx
          : offsetQx // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetQy: freezed == offsetQy
          ? _value.offsetQy
          : offsetQy // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetQz: freezed == offsetQz
          ? _value.offsetQz
          : offsetQz // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetQw: freezed == offsetQw
          ? _value.offsetQw
          : offsetQw // ignore: cast_nullable_to_non_nullable
              as double?,
      qrRotation: freezed == qrRotation
          ? _value.qrRotation
          : qrRotation // ignore: cast_nullable_to_non_nullable
              as double?,
      ovenRotation: freezed == ovenRotation
          ? _value.ovenRotation
          : ovenRotation // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaypointImplCopyWith<$Res>
    implements $WaypointCopyWith<$Res> {
  factory _$$WaypointImplCopyWith(
          _$WaypointImpl value, $Res Function(_$WaypointImpl) then) =
      __$$WaypointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'waypoint_name') String? waypointName,
      double x,
      double y,
      double z,
      double qx,
      double qy,
      double qz,
      double qw,
      @JsonKey(name: 'offset_x') double? offsetX,
      @JsonKey(name: 'offset_y') double? offsetY,
      @JsonKey(name: 'offset_z') double? offsetZ,
      @JsonKey(name: 'offset_qx') double? offsetQx,
      @JsonKey(name: 'offset_qy') double? offsetQy,
      @JsonKey(name: 'offset_qz') double? offsetQz,
      @JsonKey(name: 'offset_qw') double? offsetQw,
      @JsonKey(name: 'qr_rotation') double? qrRotation,
      @JsonKey(name: 'oven_rotation') double? ovenRotation});
}

/// @nodoc
class __$$WaypointImplCopyWithImpl<$Res>
    extends _$WaypointCopyWithImpl<$Res, _$WaypointImpl>
    implements _$$WaypointImplCopyWith<$Res> {
  __$$WaypointImplCopyWithImpl(
      _$WaypointImpl _value, $Res Function(_$WaypointImpl) _then)
      : super(_value, _then);

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? waypointName = freezed,
    Object? x = null,
    Object? y = null,
    Object? z = null,
    Object? qx = null,
    Object? qy = null,
    Object? qz = null,
    Object? qw = null,
    Object? offsetX = freezed,
    Object? offsetY = freezed,
    Object? offsetZ = freezed,
    Object? offsetQx = freezed,
    Object? offsetQy = freezed,
    Object? offsetQz = freezed,
    Object? offsetQw = freezed,
    Object? qrRotation = freezed,
    Object? ovenRotation = freezed,
  }) {
    return _then(_$WaypointImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      waypointName: freezed == waypointName
          ? _value.waypointName
          : waypointName // ignore: cast_nullable_to_non_nullable
              as String?,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      qx: null == qx
          ? _value.qx
          : qx // ignore: cast_nullable_to_non_nullable
              as double,
      qy: null == qy
          ? _value.qy
          : qy // ignore: cast_nullable_to_non_nullable
              as double,
      qz: null == qz
          ? _value.qz
          : qz // ignore: cast_nullable_to_non_nullable
              as double,
      qw: null == qw
          ? _value.qw
          : qw // ignore: cast_nullable_to_non_nullable
              as double,
      offsetX: freezed == offsetX
          ? _value.offsetX
          : offsetX // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetY: freezed == offsetY
          ? _value.offsetY
          : offsetY // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetZ: freezed == offsetZ
          ? _value.offsetZ
          : offsetZ // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetQx: freezed == offsetQx
          ? _value.offsetQx
          : offsetQx // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetQy: freezed == offsetQy
          ? _value.offsetQy
          : offsetQy // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetQz: freezed == offsetQz
          ? _value.offsetQz
          : offsetQz // ignore: cast_nullable_to_non_nullable
              as double?,
      offsetQw: freezed == offsetQw
          ? _value.offsetQw
          : offsetQw // ignore: cast_nullable_to_non_nullable
              as double?,
      qrRotation: freezed == qrRotation
          ? _value.qrRotation
          : qrRotation // ignore: cast_nullable_to_non_nullable
              as double?,
      ovenRotation: freezed == ovenRotation
          ? _value.ovenRotation
          : ovenRotation // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaypointImpl implements _Waypoint {
  const _$WaypointImpl(
      {this.id,
      @JsonKey(name: 'waypoint_name') this.waypointName,
      required this.x,
      required this.y,
      required this.z,
      required this.qx,
      required this.qy,
      required this.qz,
      required this.qw,
      @JsonKey(name: 'offset_x') this.offsetX,
      @JsonKey(name: 'offset_y') this.offsetY,
      @JsonKey(name: 'offset_z') this.offsetZ,
      @JsonKey(name: 'offset_qx') this.offsetQx,
      @JsonKey(name: 'offset_qy') this.offsetQy,
      @JsonKey(name: 'offset_qz') this.offsetQz,
      @JsonKey(name: 'offset_qw') this.offsetQw,
      @JsonKey(name: 'qr_rotation') this.qrRotation,
      @JsonKey(name: 'oven_rotation') this.ovenRotation});

  factory _$WaypointImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaypointImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'waypoint_name')
  final String? waypointName;
  @override
  final double x;
  @override
  final double y;
  @override
  final double z;
  @override
  final double qx;
  @override
  final double qy;
  @override
  final double qz;
  @override
  final double qw;
  @override
  @JsonKey(name: 'offset_x')
  final double? offsetX;
  @override
  @JsonKey(name: 'offset_y')
  final double? offsetY;
  @override
  @JsonKey(name: 'offset_z')
  final double? offsetZ;
  @override
  @JsonKey(name: 'offset_qx')
  final double? offsetQx;
  @override
  @JsonKey(name: 'offset_qy')
  final double? offsetQy;
  @override
  @JsonKey(name: 'offset_qz')
  final double? offsetQz;
  @override
  @JsonKey(name: 'offset_qw')
  final double? offsetQw;
  @override
  @JsonKey(name: 'qr_rotation')
  final double? qrRotation;
  @override
  @JsonKey(name: 'oven_rotation')
  final double? ovenRotation;

  @override
  String toString() {
    return 'Waypoint(id: $id, waypointName: $waypointName, x: $x, y: $y, z: $z, qx: $qx, qy: $qy, qz: $qz, qw: $qw, offsetX: $offsetX, offsetY: $offsetY, offsetZ: $offsetZ, offsetQx: $offsetQx, offsetQy: $offsetQy, offsetQz: $offsetQz, offsetQw: $offsetQw, qrRotation: $qrRotation, ovenRotation: $ovenRotation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaypointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.waypointName, waypointName) ||
                other.waypointName == waypointName) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.qx, qx) || other.qx == qx) &&
            (identical(other.qy, qy) || other.qy == qy) &&
            (identical(other.qz, qz) || other.qz == qz) &&
            (identical(other.qw, qw) || other.qw == qw) &&
            (identical(other.offsetX, offsetX) || other.offsetX == offsetX) &&
            (identical(other.offsetY, offsetY) || other.offsetY == offsetY) &&
            (identical(other.offsetZ, offsetZ) || other.offsetZ == offsetZ) &&
            (identical(other.offsetQx, offsetQx) ||
                other.offsetQx == offsetQx) &&
            (identical(other.offsetQy, offsetQy) ||
                other.offsetQy == offsetQy) &&
            (identical(other.offsetQz, offsetQz) ||
                other.offsetQz == offsetQz) &&
            (identical(other.offsetQw, offsetQw) ||
                other.offsetQw == offsetQw) &&
            (identical(other.qrRotation, qrRotation) ||
                other.qrRotation == qrRotation) &&
            (identical(other.ovenRotation, ovenRotation) ||
                other.ovenRotation == ovenRotation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      waypointName,
      x,
      y,
      z,
      qx,
      qy,
      qz,
      qw,
      offsetX,
      offsetY,
      offsetZ,
      offsetQx,
      offsetQy,
      offsetQz,
      offsetQw,
      qrRotation,
      ovenRotation);

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WaypointImplCopyWith<_$WaypointImpl> get copyWith =>
      __$$WaypointImplCopyWithImpl<_$WaypointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaypointImplToJson(
      this,
    );
  }
}

abstract class _Waypoint implements Waypoint {
  const factory _Waypoint(
          {final int? id,
          @JsonKey(name: 'waypoint_name') final String? waypointName,
          required final double x,
          required final double y,
          required final double z,
          required final double qx,
          required final double qy,
          required final double qz,
          required final double qw,
          @JsonKey(name: 'offset_x') final double? offsetX,
          @JsonKey(name: 'offset_y') final double? offsetY,
          @JsonKey(name: 'offset_z') final double? offsetZ,
          @JsonKey(name: 'offset_qx') final double? offsetQx,
          @JsonKey(name: 'offset_qy') final double? offsetQy,
          @JsonKey(name: 'offset_qz') final double? offsetQz,
          @JsonKey(name: 'offset_qw') final double? offsetQw,
          @JsonKey(name: 'qr_rotation') final double? qrRotation,
          @JsonKey(name: 'oven_rotation') final double? ovenRotation}) =
      _$WaypointImpl;

  factory _Waypoint.fromJson(Map<String, dynamic> json) =
      _$WaypointImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'waypoint_name')
  String? get waypointName;
  @override
  double get x;
  @override
  double get y;
  @override
  double get z;
  @override
  double get qx;
  @override
  double get qy;
  @override
  double get qz;
  @override
  double get qw;
  @override
  @JsonKey(name: 'offset_x')
  double? get offsetX;
  @override
  @JsonKey(name: 'offset_y')
  double? get offsetY;
  @override
  @JsonKey(name: 'offset_z')
  double? get offsetZ;
  @override
  @JsonKey(name: 'offset_qx')
  double? get offsetQx;
  @override
  @JsonKey(name: 'offset_qy')
  double? get offsetQy;
  @override
  @JsonKey(name: 'offset_qz')
  double? get offsetQz;
  @override
  @JsonKey(name: 'offset_qw')
  double? get offsetQw;
  @override
  @JsonKey(name: 'qr_rotation')
  double? get qrRotation;
  @override
  @JsonKey(name: 'oven_rotation')
  double? get ovenRotation;

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WaypointImplCopyWith<_$WaypointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Path _$PathFromJson(Map<String, dynamic> json) {
  return _Path.fromJson(json);
}

/// @nodoc
mixin _$Path {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_waypoint_id')
  int? get fromWaypointId => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_waypoint_id')
  int? get toWaypointId => throw _privateConstructorUsedError;

  /// Serializes this Path to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Path
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PathCopyWith<Path> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PathCopyWith<$Res> {
  factory $PathCopyWith(Path value, $Res Function(Path) then) =
      _$PathCopyWithImpl<$Res, Path>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'from_waypoint_id') int? fromWaypointId,
      @JsonKey(name: 'to_waypoint_id') int? toWaypointId});
}

/// @nodoc
class _$PathCopyWithImpl<$Res, $Val extends Path>
    implements $PathCopyWith<$Res> {
  _$PathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Path
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fromWaypointId = freezed,
    Object? toWaypointId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fromWaypointId: freezed == fromWaypointId
          ? _value.fromWaypointId
          : fromWaypointId // ignore: cast_nullable_to_non_nullable
              as int?,
      toWaypointId: freezed == toWaypointId
          ? _value.toWaypointId
          : toWaypointId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PathImplCopyWith<$Res> implements $PathCopyWith<$Res> {
  factory _$$PathImplCopyWith(
          _$PathImpl value, $Res Function(_$PathImpl) then) =
      __$$PathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'from_waypoint_id') int? fromWaypointId,
      @JsonKey(name: 'to_waypoint_id') int? toWaypointId});
}

/// @nodoc
class __$$PathImplCopyWithImpl<$Res>
    extends _$PathCopyWithImpl<$Res, _$PathImpl>
    implements _$$PathImplCopyWith<$Res> {
  __$$PathImplCopyWithImpl(_$PathImpl _value, $Res Function(_$PathImpl) _then)
      : super(_value, _then);

  /// Create a copy of Path
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fromWaypointId = freezed,
    Object? toWaypointId = freezed,
  }) {
    return _then(_$PathImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fromWaypointId: freezed == fromWaypointId
          ? _value.fromWaypointId
          : fromWaypointId // ignore: cast_nullable_to_non_nullable
              as int?,
      toWaypointId: freezed == toWaypointId
          ? _value.toWaypointId
          : toWaypointId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PathImpl implements _Path {
  const _$PathImpl(
      {this.id,
      @JsonKey(name: 'from_waypoint_id') this.fromWaypointId,
      @JsonKey(name: 'to_waypoint_id') this.toWaypointId});

  factory _$PathImpl.fromJson(Map<String, dynamic> json) =>
      _$$PathImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'from_waypoint_id')
  final int? fromWaypointId;
  @override
  @JsonKey(name: 'to_waypoint_id')
  final int? toWaypointId;

  @override
  String toString() {
    return 'Path(id: $id, fromWaypointId: $fromWaypointId, toWaypointId: $toWaypointId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PathImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromWaypointId, fromWaypointId) ||
                other.fromWaypointId == fromWaypointId) &&
            (identical(other.toWaypointId, toWaypointId) ||
                other.toWaypointId == toWaypointId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, fromWaypointId, toWaypointId);

  /// Create a copy of Path
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PathImplCopyWith<_$PathImpl> get copyWith =>
      __$$PathImplCopyWithImpl<_$PathImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PathImplToJson(
      this,
    );
  }
}

abstract class _Path implements Path {
  const factory _Path(
      {final int? id,
      @JsonKey(name: 'from_waypoint_id') final int? fromWaypointId,
      @JsonKey(name: 'to_waypoint_id') final int? toWaypointId}) = _$PathImpl;

  factory _Path.fromJson(Map<String, dynamic> json) = _$PathImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'from_waypoint_id')
  int? get fromWaypointId;
  @override
  @JsonKey(name: 'to_waypoint_id')
  int? get toWaypointId;

  /// Create a copy of Path
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PathImplCopyWith<_$PathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PathWaypoint _$PathWaypointFromJson(Map<String, dynamic> json) {
  return _PathWaypoint.fromJson(json);
}

/// @nodoc
mixin _$PathWaypoint {
  int? get id => throw _privateConstructorUsedError;
  int? get sequence => throw _privateConstructorUsedError;
  @JsonKey(name: 'waypoint_id')
  int? get waypointId => throw _privateConstructorUsedError;
  @JsonKey(name: 'path_id')
  int? get pathId => throw _privateConstructorUsedError;

  /// Serializes this PathWaypoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PathWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PathWaypointCopyWith<PathWaypoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PathWaypointCopyWith<$Res> {
  factory $PathWaypointCopyWith(
          PathWaypoint value, $Res Function(PathWaypoint) then) =
      _$PathWaypointCopyWithImpl<$Res, PathWaypoint>;
  @useResult
  $Res call(
      {int? id,
      int? sequence,
      @JsonKey(name: 'waypoint_id') int? waypointId,
      @JsonKey(name: 'path_id') int? pathId});
}

/// @nodoc
class _$PathWaypointCopyWithImpl<$Res, $Val extends PathWaypoint>
    implements $PathWaypointCopyWith<$Res> {
  _$PathWaypointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PathWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sequence = freezed,
    Object? waypointId = freezed,
    Object? pathId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      waypointId: freezed == waypointId
          ? _value.waypointId
          : waypointId // ignore: cast_nullable_to_non_nullable
              as int?,
      pathId: freezed == pathId
          ? _value.pathId
          : pathId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PathWaypointImplCopyWith<$Res>
    implements $PathWaypointCopyWith<$Res> {
  factory _$$PathWaypointImplCopyWith(
          _$PathWaypointImpl value, $Res Function(_$PathWaypointImpl) then) =
      __$$PathWaypointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? sequence,
      @JsonKey(name: 'waypoint_id') int? waypointId,
      @JsonKey(name: 'path_id') int? pathId});
}

/// @nodoc
class __$$PathWaypointImplCopyWithImpl<$Res>
    extends _$PathWaypointCopyWithImpl<$Res, _$PathWaypointImpl>
    implements _$$PathWaypointImplCopyWith<$Res> {
  __$$PathWaypointImplCopyWithImpl(
      _$PathWaypointImpl _value, $Res Function(_$PathWaypointImpl) _then)
      : super(_value, _then);

  /// Create a copy of PathWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sequence = freezed,
    Object? waypointId = freezed,
    Object? pathId = freezed,
  }) {
    return _then(_$PathWaypointImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      waypointId: freezed == waypointId
          ? _value.waypointId
          : waypointId // ignore: cast_nullable_to_non_nullable
              as int?,
      pathId: freezed == pathId
          ? _value.pathId
          : pathId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PathWaypointImpl implements _PathWaypoint {
  const _$PathWaypointImpl(
      {this.id,
      this.sequence,
      @JsonKey(name: 'waypoint_id') this.waypointId,
      @JsonKey(name: 'path_id') this.pathId});

  factory _$PathWaypointImpl.fromJson(Map<String, dynamic> json) =>
      _$$PathWaypointImplFromJson(json);

  @override
  final int? id;
  @override
  final int? sequence;
  @override
  @JsonKey(name: 'waypoint_id')
  final int? waypointId;
  @override
  @JsonKey(name: 'path_id')
  final int? pathId;

  @override
  String toString() {
    return 'PathWaypoint(id: $id, sequence: $sequence, waypointId: $waypointId, pathId: $pathId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PathWaypointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.waypointId, waypointId) ||
                other.waypointId == waypointId) &&
            (identical(other.pathId, pathId) || other.pathId == pathId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, sequence, waypointId, pathId);

  /// Create a copy of PathWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PathWaypointImplCopyWith<_$PathWaypointImpl> get copyWith =>
      __$$PathWaypointImplCopyWithImpl<_$PathWaypointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PathWaypointImplToJson(
      this,
    );
  }
}

abstract class _PathWaypoint implements PathWaypoint {
  const factory _PathWaypoint(
      {final int? id,
      final int? sequence,
      @JsonKey(name: 'waypoint_id') final int? waypointId,
      @JsonKey(name: 'path_id') final int? pathId}) = _$PathWaypointImpl;

  factory _PathWaypoint.fromJson(Map<String, dynamic> json) =
      _$PathWaypointImpl.fromJson;

  @override
  int? get id;
  @override
  int? get sequence;
  @override
  @JsonKey(name: 'waypoint_id')
  int? get waypointId;
  @override
  @JsonKey(name: 'path_id')
  int? get pathId;

  /// Create a copy of PathWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PathWaypointImplCopyWith<_$PathWaypointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AvailableItem _$AvailableItemFromJson(Map<String, dynamic> json) {
  return _AvailableItem.fromJson(json);
}

/// @nodoc
mixin _$AvailableItem {
  @JsonKey(name: 'item_id')
  int get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_quantity')
  int get availableQuantity => throw _privateConstructorUsedError;

  /// Serializes this AvailableItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailableItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableItemCopyWith<AvailableItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableItemCopyWith<$Res> {
  factory $AvailableItemCopyWith(
          AvailableItem value, $Res Function(AvailableItem) then) =
      _$AvailableItemCopyWithImpl<$Res, AvailableItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'item_id') int itemId,
      @JsonKey(name: 'available_quantity') int availableQuantity});
}

/// @nodoc
class _$AvailableItemCopyWithImpl<$Res, $Val extends AvailableItem>
    implements $AvailableItemCopyWith<$Res> {
  _$AvailableItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? availableQuantity = null,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      availableQuantity: null == availableQuantity
          ? _value.availableQuantity
          : availableQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AvailableItemImplCopyWith<$Res>
    implements $AvailableItemCopyWith<$Res> {
  factory _$$AvailableItemImplCopyWith(
          _$AvailableItemImpl value, $Res Function(_$AvailableItemImpl) then) =
      __$$AvailableItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'item_id') int itemId,
      @JsonKey(name: 'available_quantity') int availableQuantity});
}

/// @nodoc
class __$$AvailableItemImplCopyWithImpl<$Res>
    extends _$AvailableItemCopyWithImpl<$Res, _$AvailableItemImpl>
    implements _$$AvailableItemImplCopyWith<$Res> {
  __$$AvailableItemImplCopyWithImpl(
      _$AvailableItemImpl _value, $Res Function(_$AvailableItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of AvailableItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? availableQuantity = null,
  }) {
    return _then(_$AvailableItemImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      availableQuantity: null == availableQuantity
          ? _value.availableQuantity
          : availableQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailableItemImpl implements _AvailableItem {
  const _$AvailableItemImpl(
      {@JsonKey(name: 'item_id') required this.itemId,
      @JsonKey(name: 'available_quantity') required this.availableQuantity});

  factory _$AvailableItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailableItemImplFromJson(json);

  @override
  @JsonKey(name: 'item_id')
  final int itemId;
  @override
  @JsonKey(name: 'available_quantity')
  final int availableQuantity;

  @override
  String toString() {
    return 'AvailableItem(itemId: $itemId, availableQuantity: $availableQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.availableQuantity, availableQuantity) ||
                other.availableQuantity == availableQuantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, itemId, availableQuantity);

  /// Create a copy of AvailableItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableItemImplCopyWith<_$AvailableItemImpl> get copyWith =>
      __$$AvailableItemImplCopyWithImpl<_$AvailableItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableItemImplToJson(
      this,
    );
  }
}

abstract class _AvailableItem implements AvailableItem {
  const factory _AvailableItem(
      {@JsonKey(name: 'item_id') required final int itemId,
      @JsonKey(name: 'available_quantity')
      required final int availableQuantity}) = _$AvailableItemImpl;

  factory _AvailableItem.fromJson(Map<String, dynamic> json) =
      _$AvailableItemImpl.fromJson;

  @override
  @JsonKey(name: 'item_id')
  int get itemId;
  @override
  @JsonKey(name: 'available_quantity')
  int get availableQuantity;

  /// Create a copy of AvailableItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableItemImplCopyWith<_$AvailableItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
