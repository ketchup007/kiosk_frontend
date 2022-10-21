class StorageLimitsModel{
  final String orderName;
  final int quantity;

  StorageLimitsModel({
    required this.orderName,
    required this.quantity
  });

  factory StorageLimitsModel.fromJson(Map<String, dynamic> json){
    return StorageLimitsModel(
        orderName: json['order_name'] as String,
        quantity: json['quantity'] as int);
  }
}