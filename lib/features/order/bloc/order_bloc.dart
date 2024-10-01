import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kiosk_flutter/common/freezed_decorators.dart';
import 'package:kiosk_flutter/common/loading_status.dart';
import 'package:kiosk_flutter/features/order/services/aps_order_service.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'generated/order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required ApsOrderService apsOrderService,
  })  : _apsOrderService = apsOrderService,
        super(OrderState()) {
    on<_Started>(_onStarted);
  }

  final ApsOrderService _apsOrderService;

  FutureOr<void> _onStarted(_Started event, Emitter<OrderState> emit) async {
    try {
      await _apsOrderService.createNewOrder();
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }

    emit(state.copyWith(loadingStatus: LoadingStatus.success));
  }
}
