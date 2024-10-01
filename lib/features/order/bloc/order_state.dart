part of 'order_bloc.dart';

@freezedState
class OrderState with _$OrderState {
  factory OrderState({
    @Default(LoadingStatus.loading) LoadingStatus loadingStatus,
  }) = _OrderState;
}
