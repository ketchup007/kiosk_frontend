import 'package:kiosk_flutter/models/menus/ingredient_translated.dart';
import 'package:kiosk_flutter/models/menus/product_type.dart';

class ProductTranslated {
  final String munchieId;
  final String productId;
  final String name;
  final num price;
  final String currency;
  final ProductType type;
  final String? image;
  final List<IngredientTranslated> ingredients;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String translationLanguageId;

  ProductTranslated({
    required this.munchieId,
    required this.productId,
    required this.name,
    required this.price,
    required this.currency,
    required this.type,
    required this.image,
    required this.ingredients,
    required this.createdAt,
    required this.updatedAt,
    required this.translationLanguageId,
  });

  ProductTranslated copyWith({
    String? munchieId,
    String? productId,
    String? name,
    num? price,
    String? currency,
    ProductType? type,
    String? image,
    List<IngredientTranslated>? ingredients,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? translationLanguageId,
  }) {
    return ProductTranslated(
      munchieId: munchieId ?? this.munchieId,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      image: image ?? this.image,
      ingredients: ingredients ?? this.ingredients,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      translationLanguageId: translationLanguageId ?? this.translationLanguageId,
    );
  }

  factory ProductTranslated.fromJson(Map<String, dynamic> json) {
    return ProductTranslated(
      munchieId: json['munchie_id'] as String,
      productId: json['product_id'] as String,
      name: json['name'] as String,
      price: json['price'] as num,
      currency: json['currency'] as String,
      type: ProductType.fromJson(json['type'] as String),
      image: json['image'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>).map((e) => IngredientTranslated.fromJson(e as Map<String, dynamic>)).toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      translationLanguageId: json['translation_language_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'munchie_id': munchieId,
      'product_id': productId,
      'name': name,
      'price': price,
      'currency': currency,
      'type': type.toString().split('.').last,
      'image': image,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'translation_language_id': translationLanguageId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductTranslated &&
        other.munchieId == munchieId &&
        other.productId == productId &&
        other.name == name &&
        other.price == price &&
        other.currency == currency &&
        other.type == type &&
        other.image == image &&
        other.ingredients == ingredients &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.translationLanguageId == translationLanguageId;
  }

  @override
  int get hashCode {
    return munchieId.hashCode ^
        productId.hashCode ^
        name.hashCode ^
        price.hashCode ^
        currency.hashCode ^
        type.hashCode ^
        image.hashCode ^
        ingredients.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        translationLanguageId.hashCode;
  }

  String get ingredientNamesAsString => ingredients.map((e) => e.name).join(', ');
}
