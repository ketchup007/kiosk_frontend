import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/pathSelector.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:payu/payu.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main({String url = ApiConstants.baseUrl}) async {
  WidgetsFlutterBinding.ensureInitialized();

  Payu.environment = Environment.sandbox;
  Payu.debug = true;
  Payu.locale = Locale('pl');
  Payu.pos = POS(id: '455830');

  //setting up immersive view
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider(
        create: (context) => MainProvider(), child: MyApp(url: url)));
  });
}

class MyApp extends StatefulWidget {
  final String url;

  const MyApp({super.key,
  required this.url});

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale.fromSubtags(languageCode: 'pl');
  String url = '';

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    url = widget.url;
    return MaterialApp(
        locale: _locale,
        title: 'Munchies Kiosk',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const PathSelector());
  }
}
