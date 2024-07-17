import 'package:kiosk_flutter/models/base.dart';

class StorageState extends Base<StorageState> {
  @override
  final String id;
  final String munchieId;
  final String productId;
  final int amount;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const StorageState({
    required this.id,
    required this.munchieId,
    required this.productId,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  StorageState copyWith({
    String? id,
    String? munchieId,
    String? productId,
    int? amount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StorageState(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      munchieId: munchieId ?? this.munchieId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory StorageState.fromJson(Map<String, dynamic> json) {
    return StorageState(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      munchieId: json['munchie_id'] as String,
      amount: json['amount'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'munchie_id': munchieId,
      'product_id': productId,
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StorageState &&
        other.id == id &&
        other.munchieId == munchieId &&
        other.productId == productId &&
        other.amount == amount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ productId.hashCode ^ munchieId.hashCode ^ amount.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
