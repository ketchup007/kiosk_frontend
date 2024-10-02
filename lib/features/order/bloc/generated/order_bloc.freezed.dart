// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderEvent {}

/// @nodoc

class _$CreateNewOrderImpl implements _CreateNewOrder {
  const _$CreateNewOrderImpl();

  @override
  String toString() {
    return 'OrderEvent.createNewOrder()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreateNewOrderImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _CreateNewOrder implements OrderEvent {
  const factory _CreateNewOrder() = _$CreateNewOrderImpl;
}

/// @nodoc

class _$LoadAvailableItemsImpl implements _LoadAvailableItems {
  const _$LoadAvailableItemsImpl();

  @override
  String toString() {
    return 'OrderEvent.loadAvailableItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadAvailableItemsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _LoadAvailableItems implements OrderEvent {
  const factory _LoadAvailableItems() = _$LoadAvailableItemsImpl;
}

/// @nodoc

class _$LoadMenuItemsWithDescriptionsImpl
    implements _LoadMenuItemsWithDescriptions {
  const _$LoadMenuItemsWithDescriptionsImpl();

  @override
  String toString() {
    return 'OrderEvent.loadMenuItemsWithDescriptions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMenuItemsWithDescriptionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _LoadMenuItemsWithDescriptions implements OrderEvent {
  const factory _LoadMenuItemsWithDescriptions() =
      _$LoadMenuItemsWithDescriptionsImpl;
}

/// @nodoc

class _$LoadOrderItemsImpl implements _LoadOrderItems {
  const _$LoadOrderItemsImpl();

  @override
  String toString() {
    return 'OrderEvent.loadOrderItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadOrderItemsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _LoadOrderItems implements OrderEvent {
  const factory _LoadOrderItems() = _$LoadOrderItemsImpl;
}

/// @nodoc

class _$ChangeTabCategoryImpl implements _ChangeTabCategory {
  const _$ChangeTabCategoryImpl(this.category);

  @override
  final TabCategory category;

  @override
  String toString() {
    return 'OrderEvent.changeTabCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeTabCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);
}

abstract class _ChangeTabCategory implements OrderEvent {
  const factory _ChangeTabCategory(final TabCategory category) =
      _$ChangeTabCategoryImpl;

  TabCategory get category;
}

/// @nodoc

class _$UpdatePhoneNumberImpl implements _UpdatePhoneNumber {
  const _$UpdatePhoneNumberImpl(this.phoneNumber);

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'OrderEvent.updatePhoneNumber(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePhoneNumberImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);
}

abstract class _UpdatePhoneNumber implements OrderEvent {
  const factory _UpdatePhoneNumber(final String phoneNumber) =
      _$UpdatePhoneNumberImpl;

  String get phoneNumber;
}

/// @nodoc

class _$UpdateOrderStatusImpl implements _UpdateOrderStatus {
  const _$UpdateOrderStatusImpl(this.status);

  @override
  final OrderStatus status;

  @override
  String toString() {
    return 'OrderEvent.updateOrderStatus(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateOrderStatusImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);
}

abstract class _UpdateOrderStatus implements OrderEvent {
  const factory _UpdateOrderStatus(final OrderStatus status) =
      _$UpdateOrderStatusImpl;

  OrderStatus get status;
}

/// @nodoc

class _$CancelOrderImpl implements _CancelOrder {
  const _$CancelOrderImpl();

  @override
  String toString() {
    return 'OrderEvent.cancelOrder()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelOrderImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _CancelOrder implements OrderEvent {
  const factory _CancelOrder() = _$CancelOrderImpl;
}

/// @nodoc

class _$AddItemToOrderImpl implements _AddItemToOrder {
  const _$AddItemToOrderImpl(this.itemId);

  @override
  final int itemId;

  @override
  String toString() {
    return 'OrderEvent.addItemToOrder(itemId: $itemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddItemToOrderImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, itemId);
}

abstract class _AddItemToOrder implements OrderEvent {
  const factory _AddItemToOrder(final int itemId) = _$AddItemToOrderImpl;

  int get itemId;
}

/// @nodoc

class _$RemoveItemToOrderImpl implements _RemoveItemToOrder {
  const _$RemoveItemToOrderImpl(this.itemId);

  @override
  final int itemId;

  @override
  String toString() {
    return 'OrderEvent.removeItemToOrder(itemId: $itemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveItemToOrderImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, itemId);
}

abstract class _RemoveItemToOrder implements OrderEvent {
  const factory _RemoveItemToOrder(final int itemId) = _$RemoveItemToOrderImpl;

  int get itemId;
}

/// @nodoc
mixin _$OrderState {
  LoadingStatus get newOrderStatus => throw _privateConstructorUsedError;
  LoadingStatus get availableItemsStatus => throw _privateConstructorUsedError;
  LoadingStatus get menuItemsStatus => throw _privateConstructorUsedError;
  LoadingStatus get orderItemsStatus => throw _privateConstructorUsedError;
  LoadingStatus get orderChangeStatus => throw _privateConstructorUsedError;
  LoadingStatus get cancelOrderStatus => throw _privateConstructorUsedError;
  LoadingStatus get addItemStatus => throw _privateConstructorUsedError;
  LoadingStatus get removeItemStatus => throw _privateConstructorUsedError;
  TabCategory get selectedTab => throw _privateConstructorUsedError;
  List<AvailableItem> get availableItems => throw _privateConstructorUsedError;
  List<MenuItemWithDescription> get menuItemsWithDescriptions =>
      throw _privateConstructorUsedError;
  List<ApsOrderItem> get orderItems => throw _privateConstructorUsedError;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStateCopyWith<OrderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStateCopyWith<$Res> {
  factory $OrderStateCopyWith(
          OrderState value, $Res Function(OrderState) then) =
      _$OrderStateCopyWithImpl<$Res, OrderState>;
  @useResult
  $Res call(
      {LoadingStatus newOrderStatus,
      LoadingStatus availableItemsStatus,
      LoadingStatus menuItemsStatus,
      LoadingStatus orderItemsStatus,
      LoadingStatus orderChangeStatus,
      LoadingStatus cancelOrderStatus,
      LoadingStatus addItemStatus,
      LoadingStatus removeItemStatus,
      TabCategory selectedTab,
      List<AvailableItem> availableItems,
      List<MenuItemWithDescription> menuItemsWithDescriptions,
      List<ApsOrderItem> orderItems});
}

/// @nodoc
class _$OrderStateCopyWithImpl<$Res, $Val extends OrderState>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newOrderStatus = null,
    Object? availableItemsStatus = null,
    Object? menuItemsStatus = null,
    Object? orderItemsStatus = null,
    Object? orderChangeStatus = null,
    Object? cancelOrderStatus = null,
    Object? addItemStatus = null,
    Object? removeItemStatus = null,
    Object? selectedTab = null,
    Object? availableItems = null,
    Object? menuItemsWithDescriptions = null,
    Object? orderItems = null,
  }) {
    return _then(_value.copyWith(
      newOrderStatus: null == newOrderStatus
          ? _value.newOrderStatus
          : newOrderStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      availableItemsStatus: null == availableItemsStatus
          ? _value.availableItemsStatus
          : availableItemsStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      menuItemsStatus: null == menuItemsStatus
          ? _value.menuItemsStatus
          : menuItemsStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      orderItemsStatus: null == orderItemsStatus
          ? _value.orderItemsStatus
          : orderItemsStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      orderChangeStatus: null == orderChangeStatus
          ? _value.orderChangeStatus
          : orderChangeStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      cancelOrderStatus: null == cancelOrderStatus
          ? _value.cancelOrderStatus
          : cancelOrderStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      addItemStatus: null == addItemStatus
          ? _value.addItemStatus
          : addItemStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      removeItemStatus: null == removeItemStatus
          ? _value.removeItemStatus
          : removeItemStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as TabCategory,
      availableItems: null == availableItems
          ? _value.availableItems
          : availableItems // ignore: cast_nullable_to_non_nullable
              as List<AvailableItem>,
      menuItemsWithDescriptions: null == menuItemsWithDescriptions
          ? _value.menuItemsWithDescriptions
          : menuItemsWithDescriptions // ignore: cast_nullable_to_non_nullable
              as List<MenuItemWithDescription>,
      orderItems: null == orderItems
          ? _value.orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<ApsOrderItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderStateImplCopyWith<$Res>
    implements $OrderStateCopyWith<$Res> {
  factory _$$OrderStateImplCopyWith(
          _$OrderStateImpl value, $Res Function(_$OrderStateImpl) then) =
      __$$OrderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadingStatus newOrderStatus,
      LoadingStatus availableItemsStatus,
      LoadingStatus menuItemsStatus,
      LoadingStatus orderItemsStatus,
      LoadingStatus orderChangeStatus,
      LoadingStatus cancelOrderStatus,
      LoadingStatus addItemStatus,
      LoadingStatus removeItemStatus,
      TabCategory selectedTab,
      List<AvailableItem> availableItems,
      List<MenuItemWithDescription> menuItemsWithDescriptions,
      List<ApsOrderItem> orderItems});
}

/// @nodoc
class __$$OrderStateImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderStateImpl>
    implements _$$OrderStateImplCopyWith<$Res> {
  __$$OrderStateImplCopyWithImpl(
      _$OrderStateImpl _value, $Res Function(_$OrderStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newOrderStatus = null,
    Object? availableItemsStatus = null,
    Object? menuItemsStatus = null,
    Object? orderItemsStatus = null,
    Object? orderChangeStatus = null,
    Object? cancelOrderStatus = null,
    Object? addItemStatus = null,
    Object? removeItemStatus = null,
    Object? selectedTab = null,
    Object? availableItems = null,
    Object? menuItemsWithDescriptions = null,
    Object? orderItems = null,
  }) {
    return _then(_$OrderStateImpl(
      newOrderStatus: null == newOrderStatus
          ? _value.newOrderStatus
          : newOrderStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      availableItemsStatus: null == availableItemsStatus
          ? _value.availableItemsStatus
          : availableItemsStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      menuItemsStatus: null == menuItemsStatus
          ? _value.menuItemsStatus
          : menuItemsStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      orderItemsStatus: null == orderItemsStatus
          ? _value.orderItemsStatus
          : orderItemsStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      orderChangeStatus: null == orderChangeStatus
          ? _value.orderChangeStatus
          : orderChangeStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      cancelOrderStatus: null == cancelOrderStatus
          ? _value.cancelOrderStatus
          : cancelOrderStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      addItemStatus: null == addItemStatus
          ? _value.addItemStatus
          : addItemStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      removeItemStatus: null == removeItemStatus
          ? _value.removeItemStatus
          : removeItemStatus // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as TabCategory,
      availableItems: null == availableItems
          ? _value._availableItems
          : availableItems // ignore: cast_nullable_to_non_nullable
              as List<AvailableItem>,
      menuItemsWithDescriptions: null == menuItemsWithDescriptions
          ? _value._menuItemsWithDescriptions
          : menuItemsWithDescriptions // ignore: cast_nullable_to_non_nullable
              as List<MenuItemWithDescription>,
      orderItems: null == orderItems
          ? _value._orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<ApsOrderItem>,
    ));
  }
}

/// @nodoc

class _$OrderStateImpl extends _OrderState {
  _$OrderStateImpl(
      {this.newOrderStatus = LoadingStatus.none,
      this.availableItemsStatus = LoadingStatus.none,
      this.menuItemsStatus = LoadingStatus.none,
      this.orderItemsStatus = LoadingStatus.none,
      this.orderChangeStatus = LoadingStatus.none,
      this.cancelOrderStatus = LoadingStatus.none,
      this.addItemStatus = LoadingStatus.none,
      this.removeItemStatus = LoadingStatus.none,
      this.selectedTab = TabCategory.snack,
      final List<AvailableItem> availableItems = const [],
      final List<MenuItemWithDescription> menuItemsWithDescriptions = const [],
      final List<ApsOrderItem> orderItems = const []})
      : _availableItems = availableItems,
        _menuItemsWithDescriptions = menuItemsWithDescriptions,
        _orderItems = orderItems,
        super._();

  @override
  @JsonKey()
  final LoadingStatus newOrderStatus;
  @override
  @JsonKey()
  final LoadingStatus availableItemsStatus;
  @override
  @JsonKey()
  final LoadingStatus menuItemsStatus;
  @override
  @JsonKey()
  final LoadingStatus orderItemsStatus;
  @override
  @JsonKey()
  final LoadingStatus orderChangeStatus;
  @override
  @JsonKey()
  final LoadingStatus cancelOrderStatus;
  @override
  @JsonKey()
  final LoadingStatus addItemStatus;
  @override
  @JsonKey()
  final LoadingStatus removeItemStatus;
  @override
  @JsonKey()
  final TabCategory selectedTab;
  final List<AvailableItem> _availableItems;
  @override
  @JsonKey()
  List<AvailableItem> get availableItems {
    if (_availableItems is EqualUnmodifiableListView) return _availableItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableItems);
  }

  final List<MenuItemWithDescription> _menuItemsWithDescriptions;
  @override
  @JsonKey()
  List<MenuItemWithDescription> get menuItemsWithDescriptions {
    if (_menuItemsWithDescriptions is EqualUnmodifiableListView)
      return _menuItemsWithDescriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuItemsWithDescriptions);
  }

  final List<ApsOrderItem> _orderItems;
  @override
  @JsonKey()
  List<ApsOrderItem> get orderItems {
    if (_orderItems is EqualUnmodifiableListView) return _orderItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItems);
  }

  @override
  String toString() {
    return 'OrderState(newOrderStatus: $newOrderStatus, availableItemsStatus: $availableItemsStatus, menuItemsStatus: $menuItemsStatus, orderItemsStatus: $orderItemsStatus, orderChangeStatus: $orderChangeStatus, cancelOrderStatus: $cancelOrderStatus, addItemStatus: $addItemStatus, removeItemStatus: $removeItemStatus, selectedTab: $selectedTab, availableItems: $availableItems, menuItemsWithDescriptions: $menuItemsWithDescriptions, orderItems: $orderItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStateImpl &&
            (identical(other.newOrderStatus, newOrderStatus) ||
                other.newOrderStatus == newOrderStatus) &&
            (identical(other.availableItemsStatus, availableItemsStatus) ||
                other.availableItemsStatus == availableItemsStatus) &&
            (identical(other.menuItemsStatus, menuItemsStatus) ||
                other.menuItemsStatus == menuItemsStatus) &&
            (identical(other.orderItemsStatus, orderItemsStatus) ||
                other.orderItemsStatus == orderItemsStatus) &&
            (identical(other.orderChangeStatus, orderChangeStatus) ||
                other.orderChangeStatus == orderChangeStatus) &&
            (identical(other.cancelOrderStatus, cancelOrderStatus) ||
                other.cancelOrderStatus == cancelOrderStatus) &&
            (identical(other.addItemStatus, addItemStatus) ||
                other.addItemStatus == addItemStatus) &&
            (identical(other.removeItemStatus, removeItemStatus) ||
                other.removeItemStatus == removeItemStatus) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            const DeepCollectionEquality()
                .equals(other._availableItems, _availableItems) &&
            const DeepCollectionEquality().equals(
                other._menuItemsWithDescriptions, _menuItemsWithDescriptions) &&
            const DeepCollectionEquality()
                .equals(other._orderItems, _orderItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      newOrderStatus,
      availableItemsStatus,
      menuItemsStatus,
      orderItemsStatus,
      orderChangeStatus,
      cancelOrderStatus,
      addItemStatus,
      removeItemStatus,
      selectedTab,
      const DeepCollectionEquality().hash(_availableItems),
      const DeepCollectionEquality().hash(_menuItemsWithDescriptions),
      const DeepCollectionEquality().hash(_orderItems));

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStateImplCopyWith<_$OrderStateImpl> get copyWith =>
      __$$OrderStateImplCopyWithImpl<_$OrderStateImpl>(this, _$identity);
}

abstract class _OrderState extends OrderState {
  factory _OrderState(
      {final LoadingStatus newOrderStatus,
      final LoadingStatus availableItemsStatus,
      final LoadingStatus menuItemsStatus,
      final LoadingStatus orderItemsStatus,
      final LoadingStatus orderChangeStatus,
      final LoadingStatus cancelOrderStatus,
      final LoadingStatus addItemStatus,
      final LoadingStatus removeItemStatus,
      final TabCategory selectedTab,
      final List<AvailableItem> availableItems,
      final List<MenuItemWithDescription> menuItemsWithDescriptions,
      final List<ApsOrderItem> orderItems}) = _$OrderStateImpl;
  _OrderState._() : super._();

  @override
  LoadingStatus get newOrderStatus;
  @override
  LoadingStatus get availableItemsStatus;
  @override
  LoadingStatus get menuItemsStatus;
  @override
  LoadingStatus get orderItemsStatus;
  @override
  LoadingStatus get orderChangeStatus;
  @override
  LoadingStatus get cancelOrderStatus;
  @override
  LoadingStatus get addItemStatus;
  @override
  LoadingStatus get removeItemStatus;
  @override
  TabCategory get selectedTab;
  @override
  List<AvailableItem> get availableItems;
  @override
  List<MenuItemWithDescription> get menuItemsWithDescriptions;
  @override
  List<ApsOrderItem> get orderItems;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStateImplCopyWith<_$OrderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
