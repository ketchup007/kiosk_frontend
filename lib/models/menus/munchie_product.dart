import 'package:kiosk_flutter/models/base.dart';
import 'package:kiosk_flutter/models/menus/munchie_ingredient.dart';
import 'package:kiosk_flutter/models/menus/product_type.dart';

class MunchieProduct extends Base<MunchieProduct> {
  final String munchieId;
  final String productId;
  final String name;
  final num price;
  final String currency;
  final ProductType type;
  final String? image;
  final List<MunchieIngredient> ingredients; // Zmienione na listę MunchieIngredient
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final String translationLanguageId;

  const MunchieProduct({
    required this.munchieId,
    required this.productId,
    required this.name,
    required this.price,
    required this.currency,
    required this.type,
    required this.image,
    required this.ingredients, // Inicjalizacja składników
    required this.createdAt,
    required this.updatedAt,
    required this.translationLanguageId,
  });

  @override
  MunchieProduct copyWith({
    String? munchieId,
    String? productId,
    String? name,
    num? price,
    String? currency,
    ProductType? type,
    String? image,
    List<MunchieIngredient>? ingredients, // Kopiowanie składników
    DateTime? createdAt,
    DateTime? updatedAt,
    String? translationLanguageId,
  }) {
    return MunchieProduct(
      munchieId: munchieId ?? this.munchieId,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      image: image ?? this.image,
      ingredients: ingredients ?? this.ingredients, // Kopiowanie składników
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      translationLanguageId: translationLanguageId ?? this.translationLanguageId,
    );
  }

  factory MunchieProduct.fromJson(Map<String, dynamic> json) {
    return MunchieProduct(
      munchieId: json['munchie_id'] as String,
      productId: json['product_id'] as String,
      name: json['name'] as String,
      price: json['price'] as num,
      currency: json['currency'] as String,
      type: ProductType.values.firstWhere((e) => e.toString().split('.').last == json['type']),
      image: json['image'] as String,
      ingredients: (json['ingredients'] as List<dynamic>).map((e) => MunchieIngredient.fromJson(e as Map<String, dynamic>)).toList(), // Inicjalizacja składników z JSON
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      translationLanguageId: json['translation_language_id'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'munchie_id': munchieId,
      'product_id': productId,
      'name': name,
      'price': price,
      'currency': currency,
      'type': type.toString().split('.').last,
      'image': image,
      'ingredients': ingredients.map((e) => e.toJson()).toList(), // Składniki do JSON
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'translation_language_id': translationLanguageId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MunchieProduct &&
        other.munchieId == munchieId &&
        other.productId == productId &&
        other.name == name &&
        other.price == price &&
        other.currency == currency &&
        other.type == type &&
        other.image == image &&
        other.ingredients == ingredients && // Porównywanie składników
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
        ingredients.hashCode ^ // Hashing składników
        createdAt.hashCode ^
        updatedAt.hashCode ^
        translationLanguageId.hashCode;
  }

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  String get ingredientNamesAsString => ingredients.map((e) => e.name).join(', ');
}
