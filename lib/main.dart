import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/pathSelector.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:payu/payu.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:http/http.dart' as http;
import 'package:window_manager/window_manager.dart';

void main({String url = ApiConstants.baseUrl}) async {
  WidgetsFlutterBinding.ensureInitialized();

 /* await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 1600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
   // await windowManager.setMovable(true);
    await windowManager.show();
    await windowManager.focus();
    Rect rect = await windowManager.getBounds();
    print(rect);
    Offset pos = await windowManager.getPosition();
    print(pos);
    await windowManager.setPosition(Offset(100, 0));
    pos = await windowManager.getPosition();
    print(pos);
    await windowManager.setPosition(Offset(-23300, 2560));
    pos = await windowManager.getPosition();
    print(pos);
  });


  */




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
