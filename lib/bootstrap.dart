import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';
// import 'package:payu/payu.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      SupabaseManager.instance.initLocalDB();
      SupabaseManager.instance.initGlobalDB();
      // final res = await SupabaseManager.instance.signInToLocalDB();

      // supabase

      //payu
      // Payu.environment = Environment.sandbox;
      // Payu.debug = true;
      // Payu.locale = Locale('pl');
      // Payu.pos = POS(id: '455830');

      //setting up immersive view
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
        runApp(ChangeNotifierProvider(create: (context) => MainProvider(), child: await builder()));
      });

      // FlutterError.onError = (FlutterErrorDetails details) async {
      //   final dynamic exception = details.exception;
      //   final StackTrace? stackTrace = details.stack;
      //   if (kDebugMode) {
      //     // In development mode simply print to console.
      //     FlutterError.dumpErrorToConsole(details);
      //   } else {
      //     // FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      //     // In production mode report to the application zone
      //     Zone.current.handleUncaughtError(exception, stackTrace!);
      //   }
      // };

      // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      // PlatformDispatcher.instance.onError = (error, stack) {
      //   // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      //   return true;
      // };

      // runApp(await builder());
    },
    (error, stackTrace) async {
      if (kDebugMode) {
        // In development mode simply print to console.
        print('Caught Dart Error!');
        print('$error');
        print('$stackTrace');
      } else {
        // FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
        // In production
        // Report errors to a reporting service such as Sentry or Crashlytics
        // myErrorsHandler.onError(error, stack);
        // exit(1); // you may exit the app
      }
    },
  );
}

Future<void> main({String url = ApiConstants.baseUrl}) async {
  WidgetsFlutterBinding.ensureInitialized();
}
