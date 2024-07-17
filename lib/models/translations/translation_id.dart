import 'package:kiosk_flutter/models/base.dart';

class TranslationId extends Base<TranslationId> {
  @override
  final String id;
  final String description;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const TranslationId({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  TranslationId copyWith({
    String? id,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TranslationId(
      id: id ?? this.id,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TranslationId.fromJson(Map<String, dynamic> json) {
    return TranslationId(
      id: json['id'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranslationId && other.id == id && other.description == description && other.createdAt == createdAt && other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ description.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
