import 'package:kiosk_flutter/models/base.dart';

class Kiosk extends Base<Kiosk> {
  @override
  final String id;
  final String munchieId;
  final String description;
  @override
  final bool synced;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const Kiosk({
    required this.id,
    required this.munchieId,
    required this.description,
    required this.synced,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Kiosk copyWith({
    String? id,
    String? munchieId,
    String? description,
    bool? synced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Kiosk(
      id: id ?? this.id,
      munchieId: munchieId ?? this.munchieId,
      description: description ?? this.description,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Kiosk.fromJson(Map<String, dynamic> json) {
    return Kiosk(
      id: json['id'] as String,
      munchieId: json['munchie_id'] as String,
      description: json['description'] as String,
      synced: json['synced'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'munchie_id': munchieId,
      'description': description,
      'synced': synced,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Kiosk &&
        other.id == id &&
        other.munchieId == munchieId &&
        other.description == description &&
        other.synced == synced &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ munchieId.hashCode ^ description.hashCode ^ synced.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
