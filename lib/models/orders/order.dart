import 'package:kiosk_flutter/models/base.dart';
import 'package:kiosk_flutter/models/orders/order_status.dart';
import 'package:kiosk_flutter/models/orders/origin_type.dart';
import 'package:kiosk_flutter/models/orders/pickup_number.dart';

class Order extends Base<Order> {
  @override
  final String id;
  final String munchieId;
  final String kioskId;
  final OriginType origin;
  final OrderStatus status;
  final PickupNumber pickupNumber;
  final int kdsOrderNumber;
  final String? clientPhoneNumber;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const Order({
    required this.id,
    required this.munchieId,
    required this.kioskId,
    required this.origin,
    required this.status,
    required this.pickupNumber,
    required this.kdsOrderNumber,
    this.clientPhoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Order copyWith({
    String? id,
    String? munchieId,
    String? kioskId,
    OriginType? origin,
    OrderStatus? status,
    PickupNumber? pickupNumber,
    int? kdsOrderNumber,
    String? clientPhoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      munchieId: munchieId ?? this.munchieId,
      kioskId: kioskId ?? this.kioskId,
      origin: origin ?? this.origin,
      status: status ?? this.status,
      pickupNumber: pickupNumber ?? this.pickupNumber,
      kdsOrderNumber: kdsOrderNumber ?? this.kdsOrderNumber,
      clientPhoneNumber: clientPhoneNumber ?? this.clientPhoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      munchieId: json['munchie_id'] as String,
      kioskId: json['kiosk_id'] as String,
      origin: OriginType.fromJson(json['origin']),
      status: OrderStatus.fromJson(json['status']),
      pickupNumber: PickupNumber.fromJson(json['pickup_number']),
      kdsOrderNumber: json['kds_order_number'] as int,
      clientPhoneNumber: json['client_phone_number'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'munchie_id': munchieId,
      'kiosk_id': kioskId,
      'origin': origin.toJson(),
      'status': status.toJson(),
      'pickup_number': pickupNumber.toJson(),
      'kds_order_number': kdsOrderNumber,
      'client_phone_number': clientPhoneNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.munchieId == munchieId &&
        other.kioskId == kioskId &&
        other.origin == origin &&
        other.status == status &&
        other.pickupNumber == pickupNumber &&
        other.kdsOrderNumber == kdsOrderNumber &&
        other.clientPhoneNumber == clientPhoneNumber &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        munchieId.hashCode ^
        kioskId.hashCode ^
        origin.hashCode ^
        status.hashCode ^
        pickupNumber.hashCode ^
        kdsOrderNumber.hashCode ^
        clientPhoneNumber.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  factory Order.empty() {
    return Order(
      id: '',
      munchieId: '',
      kioskId: '',
      origin: OriginType.values.first,
      status: OrderStatus.values.first,
      pickupNumber: PickupNumber.values.first,
      kdsOrderNumber: 0,
      clientPhoneNumber: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
