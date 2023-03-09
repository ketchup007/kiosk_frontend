import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

import 'package:kiosk_flutter/main.dart' as app;

import '../test/utils_test.mocks.dart';

//import '../test/utils_test.mocks.dart';

@GenerateMocks([http.Client])

MockWebServer? _server;
void main() {
 setUp(() async {
   _server = MockWebServer();
   await _server!.start();
 });

 tearDown(() => _server!.shutdown());



  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group("end-to-end test", () {
    testWidgets('end-to-end test', (tester) async {
      final client = MockClient();

      app.main(url: _server!.url);
      await tester.pumpAndSettle();

      //await tester.pump(Duration(seconds: 10));

      final Finder logout = find.widgetWithText(ElevatedButton, "Logout");

      if(logout.allCandidates.isNotEmpty){
        await tester.tap(logout);
        await tester.pumpAndSettle();
      }

      expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);

      final Finder loginFirstScreenButton = find.widgetWithText(ElevatedButton, "Login");

      await tester.tap(loginFirstScreenButton);

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '502854988');

      await tester.pump();

      /*when(client.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.smsLogin),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone_number': "+48502854988"})))
      .thenAnswer((_) async => http.Response('{"status":"SMS_SEND"}', 200));
      */

      expect(find.widgetWithText(ElevatedButton, "Wyślij SMS"), findsOneWidget);

      final Finder sendSmsButton = find.widgetWithText(ElevatedButton, "Wyślij SMS");

      _server!.enqueue(body: '{"status":"SMS_SEND"}');

      await tester.tap(sendSmsButton);

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "WfD39m");

      await tester.pump();

      expect(find.widgetWithText(ElevatedButton, 'zaloguj'), findsOneWidget);

      _server!.enqueue(body: '{"status":"SUCCESS","token":"BHjM6lLmS62pxtmhw2jbxdoIZ9SrDpAe"}');

      _server!.enqueue(body: '{"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NzgzNjQ4MjcsImV4cCI6MTY3ODM2ODQyNywicm9sZXMiOlsiUk9MRV9VU0VSIl0sInVzZXJuYW1lIjoiKzQ4NTAyODU0OTg4In0.StDBhRVu2nuysUbGuFPejV1IgO5Yz2KKqfbA87bUxuijcsnTjdVOjTW545hDao-4sIoIieL26YSthQPJlY-BhnCmyKdbGAl1R8hqikwZy9vT36yMtLhYwwQVduBCnYjLW8EpGN34Eo4GUMJm6KdCF3HjT2IUbZy_Mq9PkgHYHa_tJ_msjrHzE4YE7ZAuNtw08bw_QSpRQ2mJwGtmcG_E6h1f0cK8UiJq49aClZZwjqSSNEwUyIS-weNdNRsaERl0RquqWT0kEASypFr1XtjQLyr3enPSfN7vuk-JNUM_dR69SV9A0ELYzt-ZGgNNyXI7g2JG9njfjvQsIieZvMSE4w"}');

      await tester.tap(find.widgetWithText(ElevatedButton, 'zaloguj'));

      await tester.pump(Duration(seconds: 10));

      expect(find.widgetWithText(ElevatedButton, "Przyciśnij Ekran, aby zamówić"), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, "Przyciśnij Ekran, aby zamówić"));

      await tester.pump(Duration(minutes: 1));
    });

  });
}
