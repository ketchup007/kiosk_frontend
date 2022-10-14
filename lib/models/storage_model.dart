class StorageModel{
  final String orderName;
  final String nameEn;
  final String namePl;
  final String ingredientsEn;
  final String ingredientsPl;
  final String image;
  final double price;
  final int type;
  int quantity;
  int number;

  StorageModel({
    required this.orderName,
    required this.nameEn,
    required this.namePl,
    required this.ingredientsEn,
    required this.ingredientsPl,
    required this.image,
    required this.price,
    required this.type,
    required this.quantity,
    required this.number
  });

  //TO DO JSON FACTORY
  factory StorageModel.fromJson(Map<String, dynamic> json) {
    return StorageModel(
      orderName: json['orderName'] as String,
      nameEn: json['nameEn'] as String,
      namePl: json['namePl'] as String,
      ingredientsEn: json['ingredientsEn'] as String,
      ingredientsPl: json['ingredientsPl'] as String,
      image: json['image'] as String,
      price: json['price'] as double,
      type: json['type'] as int,
      quantity: json['quantity'] as int,
      number: 0
    );
  }
}