enum OriginType {
  kiosk('kiosk'),
  phone('phone');

  final String value;
  const OriginType(this.value);

  String toJson() => value;
  factory OriginType.fromJson(String json) => OriginType.values.firstWhere((e) => e.value == json);
}
