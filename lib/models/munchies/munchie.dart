import 'package:kiosk_flutter/models/base.dart';

class Munchie extends Base<Munchie> {
  @override
  final String id;
  final String address;
  final String location;
  final String? description;
  final String menuId;
  @override
  final bool synced;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const Munchie({
    required this.id,
    required this.address,
    required this.location,
    this.description,
    required this.menuId,
    required this.synced,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Munchie copyWith({
    String? id,
    String? address,
    String? location,
    String? description,
    String? menuId,
    bool? synced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Munchie(
      id: id ?? this.id,
      address: address ?? this.address,
      location: location ?? this.location,
      description: description ?? this.description,
      menuId: menuId ?? this.menuId,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Munchie.fromJson(Map<String, dynamic> json) {
    return Munchie(
      id: json['id'] as String,
      address: json['address'] as String,
      location: json['location'] as String,
      description: json['description'] as String?,
      menuId: json['menu_id'] as String,
      synced: json['synced'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'location': location,
      'description': description,
      'menu_id': menuId,
      'synced': synced,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Munchie &&
        other.id == id &&
        other.address == address &&
        other.location == location &&
        other.description == description &&
        other.menuId == menuId &&
        other.synced == synced &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ address.hashCode ^ location.hashCode ^ description.hashCode ^ menuId.hashCode ^ synced.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
  }
}
