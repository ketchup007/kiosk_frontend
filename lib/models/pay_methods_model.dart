class PayMethodsModel {
  final String value;
  final String brandImageUrl;
  final String name;
  final String status;
  final int minAmount;
  final int maxAmount;
  final int transactionId;

  PayMethodsModel({
    required this.value,
    required this.brandImageUrl,
    required this.name,
    required this.status,
    required this.minAmount,
    required this.maxAmount,
    required this.transactionId
  });

  factory PayMethodsModel.fromJson(Map<String, dynamic> json, int id){
    return PayMethodsModel(
        value: json["value"] as String,
        brandImageUrl: json["brandImageUrl"] as String,
        name: json["name"] as String,
        status: json["status"] as String,
        minAmount: json["minAmount"] as int,
        maxAmount: json["maxAmount"] as int,
        transactionId: id);
  }
}