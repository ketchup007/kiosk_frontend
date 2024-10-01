part of 'order_bloc.dart';

@freezedEvent
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.started() = _Started;
}
