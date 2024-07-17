import 'package:kiosk_flutter/models/base.dart';

class OrderProduct extends Base<OrderProduct> {
  @override
  final String id;
  final String munchieId;
  final String orderId;
  final String productId;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const OrderProduct({
    required this.id,
    required this.munchieId,
    required this.orderId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  OrderProduct copyWith({
    String? id,
    String? munchieId,
    String? orderId,
    String? productId,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderProduct(
      id: id ?? this.id,
      munchieId: munchieId ?? this.munchieId,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'] as String,
      munchieId: json['munchie_id'] as String,
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'munchie_id': munchieId,
      'order_id': orderId,
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderProduct &&
        other.id == id &&
        other.munchieId == munchieId &&
        other.orderId == orderId &&
        other.productId == productId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ munchieId.hashCode ^ orderId.hashCode ^ productId.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
