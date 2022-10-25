import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/models/country_model.dart';

Future<List<CountryModel>> readCountries() async{
  final json = await rootBundle.loadString('assets/data/countries.json');
  final data = jsonDecode(json).cast<Map<String, dynamic>>();

  return data.map<CountryModel>((json) => CountryModel.fromJson(json)).toList();
}
