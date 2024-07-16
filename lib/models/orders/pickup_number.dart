enum PickupNumber {
  one('1'),
  two('2'),
  three('3');

  const PickupNumber(this.value);
  final String value;

  String toJson() => value;
  factory PickupNumber.fromJson(String json) => PickupNumber.values.firstWhere((e) => e.value == json);
}
