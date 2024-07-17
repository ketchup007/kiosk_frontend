// Enhanced enum for OrderStatus
// enum OrderStatus {
//   duringOrdering(0),
//   paymentInProgress(1),
//   paid(2),
//   acceptedForExecution(3),
//   orderProcessingHasStarted(4),
//   firstProductFromTheOrderIsWaitingForTheRecipient(5),
//   readyForPickup(6),
//   pickedUp(7);

//   const OrderStatus(this.value);
//   final int value;

// }

enum OrderStatus {
  duringOrdering('during ordering'),
  paymentInProgress('payment in progress'),
  paid('paid'),
  acceptedForExecution('accepted for execution'),
  orderProcessingHasStarted('order processing has started'),
  firstProductFromTheOrderIsWaitingForTheRecipient('first product from the order is waiting for the recipient'),
  readyForPickup('ready for pickup'),
  pickedUp('picked up'),
  canceled('canceled');

  final String value;
  const OrderStatus(this.value);

  String toJson() => value;
  factory OrderStatus.fromJson(String json) => OrderStatus.values.firstWhere((e) => e.value == json);
}
