import 'package:kiosk_flutter/models/base.dart';

class Ingredient extends Base<Ingredient> {
  @override
  final String id;
  final String nameId;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const Ingredient({
    required this.id,
    required this.nameId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Ingredient copyWith({
    String? id,
    String? nameId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Ingredient(
      id: id ?? this.id,
      nameId: nameId ?? this.nameId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] as String,
      nameId: json['name_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_id': nameId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ingredient && other.id == id && other.nameId == nameId && other.createdAt == createdAt && other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nameId.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
