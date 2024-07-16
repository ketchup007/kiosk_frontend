import 'package:kiosk_flutter/models/base.dart';

class OrderProduct extends Base<OrderProduct> {
  @override
  final String id;
  final String orderId;
  final String productId;
  @override
  final bool synced;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const OrderProduct({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.synced,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  OrderProduct copyWith({
    String? id,
    String? orderId,
    String? productId,
    int? quantity,
    bool? synced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderProduct(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      synced: json['synced'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'synced': synced,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderProduct &&
        other.id == id &&
        other.orderId == orderId &&
        other.productId == productId &&
        other.synced == synced &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ orderId.hashCode ^ productId.hashCode ^ synced.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
