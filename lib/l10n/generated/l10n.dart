// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppText {
  AppText();

  static AppText? _current;

  static AppText get current {
    assert(_current != null,
        'No instance of AppText was loaded. Try to initialize the AppText delegate before accessing AppText.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppText> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppText();
      AppText._current = instance;

      return instance;
    });
  }

  static AppText of(BuildContext context) {
    final instance = AppText.maybeOf(context);
    assert(instance != null,
        'No instance of AppText present in the widget tree. Did you add AppText.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppText? maybeOf(BuildContext context) {
    return Localizations.of<AppText>(context, AppText);
  }

  /// `Touch Screen, to Order`
  String get touchScreenInfo {
    return Intl.message(
      'Touch Screen, to Order',
      name: 'touchScreenInfo',
      desc: '',
      args: [],
    );
  }

  /// `Pizza`
  String get pizzaItemLabel {
    return Intl.message(
      'Pizza',
      name: 'pizzaItemLabel',
      desc: '',
      args: [],
    );
  }

  /// `Drinks`
  String get drinksItemLabel {
    return Intl.message(
      'Drinks',
      name: 'drinksItemLabel',
      desc: '',
      args: [],
    );
  }

  /// `Boxes`
  String get boxesItemLabel {
    return Intl.message(
      'Boxes',
      name: 'boxesItemLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sauces`
  String get saucesItemLabel {
    return Intl.message(
      'Sauces',
      name: 'saucesItemLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButtonLabel {
    return Intl.message(
      'Cancel',
      name: 'cancelButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmButtonLabel {
    return Intl.message(
      'Confirm',
      name: 'confirmButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total order Price`
  String get priceToPayInfo {
    return Intl.message(
      'Total order Price',
      name: 'priceToPayInfo',
      desc: '',
      args: [],
    );
  }

  /// `System do not provide transaction conformation`
  String get conformationInfo {
    return Intl.message(
      'System do not provide transaction conformation',
      name: 'conformationInfo',
      desc: '',
      args: [],
    );
  }

  /// `Start Payment`
  String get paymentButtonLabel {
    return Intl.message(
      'Start Payment',
      name: 'paymentButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get summaryInfo {
    return Intl.message(
      'Order Summary',
      name: 'summaryInfo',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrderButtonLabel {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrderButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit Order`
  String get editOrderButtonLabel {
    return Intl.message(
      'Edit Order',
      name: 'editOrderButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summaryButtonLabel {
    return Intl.message(
      'Summary',
      name: 'summaryButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Order total`
  String get orderTotalText {
    return Intl.message(
      'Order total',
      name: 'orderTotalText',
      desc: '',
      args: [],
    );
  }

  /// `System do not provide transaction conformation`
  String get paymentConformationText {
    return Intl.message(
      'System do not provide transaction conformation',
      name: 'paymentConformationText',
      desc: '',
      args: [],
    );
  }

  /// `Order summary`
  String get orderSummaryText {
    return Intl.message(
      'Order summary',
      name: 'orderSummaryText',
      desc: '',
      args: [],
    );
  }

  /// `Make Payment`
  String get makePaymentButtonLabel {
    return Intl.message(
      'Make Payment',
      name: 'makePaymentButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Payment Started`
  String get paymentStartedText {
    return Intl.message(
      'Payment Started',
      name: 'paymentStartedText',
      desc: '',
      args: [],
    );
  }

  /// `Follow instructions shown on the terminal bellow`
  String get paymentInfoText {
    return Intl.message(
      'Follow instructions shown on the terminal bellow',
      name: 'paymentInfoText',
      desc: '',
      args: [],
    );
  }

  /// `Payment Cancelled`
  String get paymentCancelledText {
    return Intl.message(
      'Payment Cancelled',
      name: 'paymentCancelledText',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get returnButtonLabel {
    return Intl.message(
      'Return',
      name: 'returnButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgainButtonLabel {
    return Intl.message(
      'Try again',
      name: 'tryAgainButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Payment Accepted`
  String get paymentAcceptedText {
    return Intl.message(
      'Payment Accepted',
      name: 'paymentAcceptedText',
      desc: '',
      args: [],
    );
  }

  /// `pcs`
  String get pcs {
    return Intl.message(
      'pcs',
      name: 'pcs',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enterPhoneNumberText {
    return Intl.message(
      'Enter phone number',
      name: 'enterPhoneNumberText',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get selectAllCheckText {
    return Intl.message(
      'Select all',
      name: 'selectAllCheckText',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get requiredCheckText {
    return Intl.message(
      'Required',
      name: 'requiredCheckText',
      desc: '',
      args: [],
    );
  }

  /// `PromotionCheckText`
  String get promotionCheckText {
    return Intl.message(
      'PromotionCheckText',
      name: 'promotionCheckText',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optionalCheckText {
    return Intl.message(
      'Optional',
      name: 'optionalCheckText',
      desc: '',
      args: [],
    );
  }

  /// `Hey! That's all?`
  String get begPopupTitle {
    return Intl.message(
      'Hey! That\'s all?',
      name: 'begPopupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Look at the rest of our products to finish the order or go straight to the order summary`
  String get begPopupInformation {
    return Intl.message(
      'Look at the rest of our products to finish the order or go straight to the order summary',
      name: 'begPopupInformation',
      desc: '',
      args: [],
    );
  }

  /// `Proposed Products`
  String get productPropositionText {
    return Intl.message(
      'Proposed Products',
      name: 'productPropositionText',
      desc: '',
      args: [],
    );
  }

  /// `Go to Summary`
  String get goToSummaryButtonLabel {
    return Intl.message(
      'Go to Summary',
      name: 'goToSummaryButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Coffee`
  String get coffeeItemLabel {
    return Intl.message(
      'Coffee',
      name: 'coffeeItemLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppText> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppText> load(Locale locale) => AppText.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
