// product.dart

import 'package:kiosk_flutter/models/base.dart';
import 'package:kiosk_flutter/models/menus/product_type.dart';

class Product extends Base<Product> {
  @override
  final String id;
  final String nameId;
  final num price;
  final String currency;
  final ProductType type;
  final String? image;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.nameId,
    required this.price,
    required this.currency,
    required this.type,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Product copyWith({
    String? id,
    String? nameId,
    num? price,
    String? currency,
    ProductType? type,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      nameId: nameId ?? this.nameId,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      nameId: json['name_id'] as String,
      price: json['price'] as num,
      currency: json['currency'] as String,
      type: ProductType.values.firstWhere((e) => e.toString().split('.').last == json['type']),
      image: json['image'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_id': nameId,
      'price': price,
      'currency': currency,
      'type': type.toString().split('.').last,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.nameId == nameId &&
        other.price == price &&
        other.currency == currency &&
        other.type == type &&
        other.image == image &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nameId.hashCode ^ price.hashCode ^ currency.hashCode ^ type.hashCode ^ image.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
