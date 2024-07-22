// product_type.dart

enum ProductType {
  pizza('pizza'),
  drink('drink'),
  coffee('coffee'),
  box('box'),
  sauce('sauce');

  final String value;
  const ProductType(this.value);

  String toJson() => value;
  factory ProductType.fromJson(String json) => ProductType.values.firstWhere((e) => e.value == json);
}
