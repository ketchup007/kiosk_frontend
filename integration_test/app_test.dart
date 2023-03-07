import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

import 'package:kiosk_flutter/main.dart' as app;

import '../test/utils_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group("end-to-end test", () {
    testWidgets('end-to-end test', (tester) async {
      final client = MockClient();

      app.main();
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);

      final Finder loginFirstScreenButton = find.widgetWithText(ElevatedButton, "Login");

      await tester.tap(loginFirstScreenButton);

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '502854988');

      await tester.pump();

      when(client.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.smsLogin),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone_number': "+48502854988"})))
      .thenAnswer((_) async => http.Response('{"status":"SMS_SEND"}', 200));

      expect(find.widgetWithText(ElevatedButton, "Wyślij SMS"), findsOneWidget);

      final Finder sendSmsButton = find.widgetWithText(ElevatedButton, "Wyślij SMS");

      await tester.tap(sendSmsButton);
    });

  });
}
