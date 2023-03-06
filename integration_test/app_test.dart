import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:kiosk_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group("end-to-end test", () {
    testWidgets('end-to-end test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);

      final Finder fab = find.widgetWithText(ElevatedButton, "Login");

      await tester.tap(fab);

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '502854988');

      await tester.pump();


    });

  });
}
