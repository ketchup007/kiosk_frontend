class CountryModel {
  String countryCode;
  String dialCode;
  int minNumber;
  int maxNumber;
  String format;

  CountryModel ({
    required this.countryCode,
    required this.dialCode,
    required this.minNumber,
    required this.maxNumber,
    required this.format
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
        countryCode: json["country_code"] as String,
        dialCode: json["dial_code"] as String,
        minNumber: json["min_number"] as int,
        maxNumber: json["max_number"] as int,
        format: json["format"] as String);
  }
}