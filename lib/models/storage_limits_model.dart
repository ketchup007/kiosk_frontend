class StorageLimitsModel{
  final String productKey;
  final int quantity;

  StorageLimitsModel({
    required this.productKey,
    required this.quantity
  });

  factory StorageLimitsModel.fromJson(Map<String, dynamic> json){
    return StorageLimitsModel(
        productKey: json['product_key'] as String,
        quantity: json['quantity'] as int);
  }
}