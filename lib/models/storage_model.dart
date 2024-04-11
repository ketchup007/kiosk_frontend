class StorageModel{
  final String productKey;
  final String nameEn;
  final String namePl;
  final String ingredientsEn;
  final String ingredientsPl;
  final String image;
  final double price;
  final int type;
  int number;

  StorageModel({
    required this.productKey,
    required this.nameEn,
    required this.namePl,
    required this.ingredientsEn,
    required this.ingredientsPl,
    required this.image,
    required this.price,
    required this.type,
    required this.number
  });

  //TO DO JSON FACTORY
  factory StorageModel.fromJson(Map<String, dynamic> json) {
    return StorageModel(
        productKey: json['product_key'] as String,
        namePl: json['name_pl'] as String,
        nameEn: json['name_en'] as String,
        ingredientsPl: json['ingredients_pl'] as String,
        ingredientsEn: json['ingredients_en'] as String,
        price: json['price'] as double,
        type: json['type'] as int,
        image: json['image'] as String,
        number: 0
    );
  }

}