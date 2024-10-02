import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kiosk_flutter/common/freezed_decorators.dart';
import 'package:kiosk_flutter/common/loading_status.dart';
import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/features/order/services/order_service.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'generated/order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required ApsOrderService apsOrderService,
  })  : _apsOrderService = apsOrderService,
        super(OrderState()) {
    on<_CreateNewOrder>(_onCreateNewOrder);
    on<_LoadAvailableItems>(_onLoadAvailableItems);
    on<_LoadMenuItemsWithDescriptions>(_onLoadMenuItemsWithDescriptions);
    on<_LoadOrderItems>(_onLoadOrderItems);
    on<_ChangeTabCategory>(_onChangeTabCategory);
    on<_UpdatePhoneNumber>(_onUpdatePhoneNumber);
    on<_UpdateOrderStatus>(_onUpdateOrderStatus);
    on<_CancelOrder>(_onCancelOrder);
    on<_AddItemToOrder>(_onAddItemToOrder);
    on<_RemoveItemToOrder>(_onRemoveItemToOrder);
  }

  final ApsOrderService _apsOrderService;

  FutureOr<void> _onCreateNewOrder(_CreateNewOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(newOrderStatus: LoadingStatus.loading));
    try {
      await _apsOrderService.createNewOrder();
      emit(state.copyWith(newOrderStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(newOrderStatus: LoadingStatus.error));
    }
  }

  Future<void> _onLoadAvailableItems(_LoadAvailableItems event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      availableItemsStatus: LoadingStatus.loading,
      availableItems: [],
    ));
    await emit.forEach<List<AvailableItem>>(
      _apsOrderService.availableItemStream(apsId: AppConfig.instance.apsId),
      onData: (availableItems) {
        return state.copyWith(
          availableItems: List.from(availableItems),
          availableItemsStatus: LoadingStatus.success,
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          availableItemsStatus: LoadingStatus.error,
          availableItems: [],
        );
      },
    );
  }

  Future<void> _onLoadMenuItemsWithDescriptions(_LoadMenuItemsWithDescriptions event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      menuItemsStatus: LoadingStatus.loading,
      menuItemsWithDescriptions: [],
    ));
    await emit.forEach<List<MenuItemWithDescription>>(
      _apsOrderService.menuItemsWithDescriptionsStream(apsId: AppConfig.instance.apsId),
      onData: (menuItemsWithDescriptions) {
        return state.copyWith(
          menuItemsWithDescriptions: List.from(menuItemsWithDescriptions),
          menuItemsStatus: LoadingStatus.success,
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          menuItemsStatus: LoadingStatus.error,
          menuItemsWithDescriptions: [],
        );
      },
    );
  }

  FutureOr<void> _onLoadOrderItems(_LoadOrderItems event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      orderItemsStatus: LoadingStatus.loading,
      orderItems: [],
    ));
    await emit.forEach(
      _apsOrderService.apsOrderItemsStream(),
      onData: (orderItems) {
        return state.copyWith(
          orderItems: List.from(orderItems),
          orderItemsStatus: LoadingStatus.success,
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          orderItemsStatus: LoadingStatus.error,
          orderItems: [],
        );
      },
    );
  }

  FutureOr<void> _onChangeTabCategory(_ChangeTabCategory event, Emitter<OrderState> emit) async {
    emit(state.copyWith(selectedTab: event.category));
  }

  FutureOr<void> _onUpdatePhoneNumber(_UpdatePhoneNumber event, Emitter<OrderState> emit) async {
    emit(state.copyWith(orderChangeStatus: LoadingStatus.loading));
    try {
      await _apsOrderService.updatePhoneNumber(event.phoneNumber);
      emit(state.copyWith(orderChangeStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(orderChangeStatus: LoadingStatus.error));
    }
  }

  FutureOr<void> _onUpdateOrderStatus(_UpdateOrderStatus event, Emitter<OrderState> emit) async {
    emit(state.copyWith(orderChangeStatus: LoadingStatus.loading));
    try {
      await _apsOrderService.updateOrderStatus(event.status);
      emit(state.copyWith(orderChangeStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(orderChangeStatus: LoadingStatus.error));
    }
  }

  FutureOr<void> _onCancelOrder(_CancelOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(cancelOrderStatus: LoadingStatus.loading));
    try {
      await _apsOrderService.cancelOrder();
      emit(state.copyWith(cancelOrderStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(cancelOrderStatus: LoadingStatus.error));
    }
  }

  FutureOr<void> _onAddItemToOrder(_AddItemToOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(addItemStatus: LoadingStatus.loading));
    try {
      await _apsOrderService.addItemToOrder(event.itemId);
      emit(state.copyWith(addItemStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(addItemStatus: LoadingStatus.error));
    }
  }

  FutureOr<void> _onRemoveItemToOrder(_RemoveItemToOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(removeItemStatus: LoadingStatus.info));
    try {
      final orderItemId = state.orderItems.firstWhereOrNull((element) => element.id == event.itemId)?.id;
      if (orderItemId != null) {
        await _apsOrderService.removeItemFromOrder(orderItemId);
      }
      emit(state.copyWith(removeItemStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(removeItemStatus: LoadingStatus.error));
    }
  }
}
