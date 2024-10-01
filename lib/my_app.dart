import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_flutter/features/language/cubit/language_cubit.dart';
import 'package:kiosk_flutter/path_selector.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final Locale locale = context.select((LanguageCubit cubit) => cubit.state);
          return MaterialApp(
            locale: locale,
            title: 'Munchies Kiosk',
            localizationsDelegates: const [
              AppText.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppText.delegate.supportedLocales,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            home: const PathSelector(),
          );
        },
      ),
    );
  }
}
