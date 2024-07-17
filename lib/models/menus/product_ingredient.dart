import 'package:kiosk_flutter/models/base.dart';

class ProductIngredient extends Base<ProductIngredient> {
  @override
  final String id;
  final String productId;
  final String ingredientId;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const ProductIngredient({
    required this.id,
    required this.productId,
    required this.ingredientId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  ProductIngredient copyWith({
    String? id,
    String? productId,
    String? ingredientId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductIngredient(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      ingredientId: ingredientId ?? this.ingredientId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ProductIngredient.fromJson(Map<String, dynamic> json) {
    return ProductIngredient(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      ingredientId: json['ingredient_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'ingredient_id': ingredientId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductIngredient && other.id == id && other.productId == productId && other.ingredientId == ingredientId && other.createdAt == createdAt && other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ productId.hashCode ^ ingredientId.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
