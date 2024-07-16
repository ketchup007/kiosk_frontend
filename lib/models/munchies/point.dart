import 'dart:typed_data';

class Point {
  final double latitude;
  final double longitude;

  Point({
    required this.latitude,
    required this.longitude,
  });

  factory Point.fromWKB(String wkb) {
    Uint8List bytes = Uint8List.fromList(wkb.codeUnits);
    ByteData byteData = ByteData.sublistView(bytes, 5);

    double longitude = byteData.getFloat64(0, Endian.little);
    double latitude = byteData.getFloat64(8, Endian.little);

    return Point(latitude: latitude, longitude: longitude);
  }

  String toWKB() {
    ByteData byteData = ByteData(21);
    byteData.setUint8(0, 1); // WKB byte order
    byteData.setUint32(1, 1, Endian.little); // WKB type (Point)
    byteData.setFloat64(5, longitude, Endian.little); // longitude
    byteData.setFloat64(13, latitude, Endian.little); // latitude
    return String.fromCharCodes(byteData.buffer.asUint8List());
  }

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() => 'Point(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Point && other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
