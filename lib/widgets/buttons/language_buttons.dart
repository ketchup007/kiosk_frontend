import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_flutter/features/language/cubit/language_cubit.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:kiosk_flutter/themes/color.dart';

extension LocaleX on Locale {
  String get languageName {
    switch (languageCode) {
      case 'pl':
        return 'Polski';
      case 'en':
        return 'English';
      case 'uk':
        return 'Українська';
      default:
        return 'Unknown';
    }
  }

  String get imagePath {
    switch (languageCode) {
      case 'pl':
        return 'assets/images/plFlag.png';
      case 'en':
        return 'assets/images/angFlag.png';
      case 'uk':
        return 'assets/images/uaFlag.png';
      default:
        return 'assets/images/plFlag.png';
    }
  }
}

class LanguageButtons extends StatelessWidget {
  final double ribbonHeight;
  final double ribbonWidth;

  const LanguageButtons({
    super.key,
    required this.ribbonHeight,
    required this.ribbonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...AppText.delegate.supportedLocales.map((locale) {
          return LanguageButton(
            ribbonHeight: ribbonHeight,
            ribbonWidth: ribbonWidth,
            locale: locale,
          );
        }),
      ],
    );
  }
}

class LanguageButton extends StatelessWidget {
  final double ribbonHeight;
  final double ribbonWidth;
  final Locale locale;

  const LanguageButton({
    super.key,
    required this.ribbonHeight,
    required this.ribbonWidth,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<LanguageCubit>().changeLanguage(locale);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: IconButton(
          onPressed: () {
            context.read<LanguageCubit>().changeLanguage(locale);
          },
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(10),
          icon: Image.asset(
            locale.imagePath,
            width: ribbonWidth * 0.85,
            height: ribbonWidth * 0.85,
          ),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.blue,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(160),
                bottomRight: Radius.circular(160),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
