import 'package:payu/payu.dart';
import 'dart:convert';

class CardPaymentToken {
  String brandImageUrl;
  String cardExpirationMonth;
  String cardExpirationYear;
  String cardNumberMasked;
  String cardScheme;
  bool preferred;
  String status;
  String value;

  CardPaymentToken({
    required this.brandImageUrl,
    required this.cardExpirationMonth,
    required this.cardExpirationYear,
    required this.cardNumberMasked,
    required this.cardScheme,
    required this.preferred,
    required this.status,
    required this.value
  });

  factory CardPaymentToken.fromCardToken(CardToken cardToken){
   return CardPaymentToken(
       brandImageUrl: cardToken.brandImageUrl,
       cardExpirationMonth: cardToken.cardExpirationMonth,
       cardExpirationYear: cardToken.cardExpirationYear,
       cardNumberMasked: cardToken.cardNumberMasked,
       cardScheme: cardToken.cardScheme!,
       preferred: cardToken.preferred,
       status: cardToken.status.value,
       value: cardToken.value);

  }

  factory CardPaymentToken.fromJson(Map<String, dynamic> json){
    return CardPaymentToken(
        brandImageUrl: json["brandImageUrl"] as String,
        cardExpirationMonth: json["cardExpirationMonth"] as String,
        cardExpirationYear:json["cardExpirationYear"] as String,
        cardNumberMasked: json["cardNumberMasked"] as String,
        cardScheme: json["cardScheme"] as String,
        preferred: json["preferred"] as bool,
        status: json["status"] as String,
        value: json["value"] as String);
  }

  Map<String, dynamic> toJson() => {
    'brandImageUrl': brandImageUrl,
    'cardExpirationMonth': cardExpirationMonth,
    'cardExpirationYear': cardExpirationYear,
    'cardNumberMasked': cardNumberMasked,
    'cardScheme': cardScheme,
    'preferred': preferred,
    'status': status,
    'value': value
  };

  static String toJsonList(List<CardPaymentToken> cardTokens) => json.encode(
    cardTokens
        .map<Map<String, dynamic>>((cardToken) => cardToken.toJson())
        .toList()
  );

}