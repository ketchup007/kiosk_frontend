import 'package:kiosk_flutter/models/base.dart';

class Menu extends Base<Menu> {
  @override
  final String id;
  final String? description;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const Menu({
    required this.id,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Menu copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Menu(
      id: id ?? this.id,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] as String,
      description: json['description'] as String?,
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

    return other is Menu && other.id == id && other.description == description && other.createdAt == createdAt && other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ description.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
