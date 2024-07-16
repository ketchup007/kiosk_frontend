// Enhanced enum for OrderStatus

import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum OrderStatus {
  duringOrdering('during ordering'),
  paymentInProgress('payment in progress'),
  paid('paid'),
  acceptedForExecution('accepted for execution'),
  orderProcessingHasStarted('order processing has started'),
  firstProductFromTheOrderIsWaitingForTheRecipient('first product from the order is waiting for the recipient'),
  readyForPickup('ready for pickup'),
  pickedUp('picked up');

  final String value;
  const OrderStatus(this.value);

  String toJson() => value;
  factory OrderStatus.fromJson(String json) => OrderStatus.values.firstWhere((e) => e.value == json);
}
