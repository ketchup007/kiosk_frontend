import 'package:kiosk_flutter/models/base.dart';

class IngredientTranslated extends Base<IngredientTranslated> {
  @override
  final String id;
  final String name;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const IngredientTranslated({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  IngredientTranslated copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IngredientTranslated(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory IngredientTranslated.fromJson(Map<String, dynamic> json) {
    return IngredientTranslated(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IngredientTranslated && other.id == id && other.name == name && other.createdAt == createdAt && other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
