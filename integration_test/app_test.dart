// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:kiosk_flutter/utils/api/api_constants.dart';
// import 'package:mock_web_server/mock_web_server.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'package:http/http.dart' as http;
//
// import 'package:kiosk_flutter/main.dart' as app;
//
// import '../test/utils_test.mocks.dart';
//
// //import '../test/utils_test.mocks.dart';
//
// @GenerateMocks([http.Client])
//
// MockWebServer? _server;
// void main() {
//  setUp(() async {
//    _server = MockWebServer();
//    await _server!.start();
//  });
//
//  tearDown(() => _server!.shutdown());
//
//
//
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//
//   group("end-to-end test", () {
//     testWidgets('end-to-end test', (tester) async {
//       final client = MockClient();
//
//       app.main(url: _server!.url);
//       await tester.pumpAndSettle();
//
//       //await tester.pump(Duration(seconds: 10));
//
//       final Finder logout = find.widgetWithText(ElevatedButton, "Logout");
//
//       if(logout.allCandidates.isNotEmpty){
//         await tester.tap(logout);
//         await tester.pumpAndSettle();
//       }
//
//       expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);
//
//       final Finder loginFirstScreenButton = find.widgetWithText(ElevatedButton, "Login");
//
//       await tester.tap(loginFirstScreenButton);
//
//       await tester.pumpAndSettle();
//
//       await tester.enterText(find.byType(TextField), '502854988');
//
//       await tester.pump();
//
//       /*when(client.post(
//           Uri.parse(ApiConstants.baseUrl + ApiConstants.smsLogin),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode({'phone_number': "+48502854988"})))
//       .thenAnswer((_) async => http.Response('{"status":"SMS_SEND"}', 200));
//       */
//
//       expect(find.widgetWithText(ElevatedButton, "Wyślij SMS"), findsOneWidget);
//
//       final Finder sendSmsButton = find.widgetWithText(ElevatedButton, "Wyślij SMS");
//
//       _server!.enqueue(body: '{"status":"SMS_SEND"}');
//
//       await tester.tap(sendSmsButton);
//
//       await tester.pumpAndSettle();
//
//       await tester.enterText(find.byType(TextField), "WfD39m");
//
//       await tester.pump();
//
//       expect(find.widgetWithText(ElevatedButton, 'zaloguj'), findsOneWidget);
//
//       _server!.enqueue(body: '{"status":"SUCCESS","token":"BHjM6lLmS62pxtmhw2jbxdoIZ9SrDpAe"}');
//
//       _server!.enqueue(body: '{"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NzgzNjQ4MjcsImV4cCI6MTY3ODM2ODQyNywicm9sZXMiOlsiUk9MRV9VU0VSIl0sInVzZXJuYW1lIjoiKzQ4NTAyODU0OTg4In0.StDBhRVu2nuysUbGuFPejV1IgO5Yz2KKqfbA87bUxuijcsnTjdVOjTW545hDao-4sIoIieL26YSthQPJlY-BhnCmyKdbGAl1R8hqikwZy9vT36yMtLhYwwQVduBCnYjLW8EpGN34Eo4GUMJm6KdCF3HjT2IUbZy_Mq9PkgHYHa_tJ_msjrHzE4YE7ZAuNtw08bw_QSpRQ2mJwGtmcG_E6h1f0cK8UiJq49aClZZwjqSSNEwUyIS-weNdNRsaERl0RquqWT0kEASypFr1XtjQLyr3enPSfN7vuk-JNUM_dR69SV9A0ELYzt-ZGgNNyXI7g2JG9njfjvQsIieZvMSE4w"}');
//
//       await tester.tap(find.widgetWithText(ElevatedButton, 'zaloguj'));
//
//       await tester.pump(Duration(seconds: 10));
//
//       expect(find.widgetWithText(ElevatedButton, "Przyciśnij Ekran, aby zamówić"), findsOneWidget);
//
//       await tester.tap(find.widgetWithText(ElevatedButton, "Przyciśnij Ekran, aby zamówić"));
//
//       await tester.pump(Duration(seconds: 10));
//
//       expect(find.widgetWithText(ElevatedButton, "test button"), findsOneWidget);
//
//       _server!.enqueue(body: '{"id":1,"address":"Jagiellonsk 5a, Gdansk","latitude":54.41287712408064,"longitude":18.590699050579197,"status":1,"identifier":"gujh1yNBfR","db":"default"}');
//
//       await tester.tap(find.widgetWithText(ElevatedButton, "test button"));
//
//       await tester.pump(Duration(seconds: 10));
//
//       expect(find.widgetWithText(ElevatedButton, "Dalej"), findsOneWidget);
//
//       _server!.enqueue(body: '[{"id":1,"orderName":"product_1","nameEn":"Margherita Pizza","namePl":"Pizza Margherita","ingredientsEn":"Mozzarella cheese, herb tomato sauce","ingredientsPl":"Mozzarella, ziolowy sos pomidorowy","quantity":21,"price":10.99,"type":1,"seq":1,"image":"margherita.png"},{"id":2,"orderName":"product_2","nameEn":"Pepperoni Pizza","namePl":"Pizza Pepperoni","ingredientsEn":"Pepperoni sausage, mozzarella cheese, herb tomato sauce","ingredientsPl":"Pepperoni, mozzarella,  ziolowy sos pomidorowy","quantity":20,"price":13.49,"type":1,"seq":2,"image":"pepperoni.png"},{"id":3,"orderName":"product_3","nameEn":"Hawaiian Pizza ","namePl":"Pizza Hawajska","ingredientsEn":"Ham, pineapple, mozzarella cheese, herb tomato sauce","ingredientsPl":"Szynka, ananas, ser mozzarella, ziolowy sos pomidorowy","quantity":20,"price":14.99,"type":1,"seq":3,"image":"hawaiian.png"},{"id":4,"orderName":"product_4","nameEn":"Capricciosa Pizza","namePl":"Pizza Capricciosa","ingredientsEn":"Ham, mushrooms, cherry tomatoes, olives, mozzarella cheese, herb tomato sauce","ingredientsPl":"Szynka, pieczarki, pomidorki koktajlowe, oliwki, ser mozzarella, sos pomidorowy","quantity":20,"price":14.99,"type":1,"seq":4,"image":"capriccisa.png"},{"id":5,"orderName":"product_5","nameEn":"Meat Pizza","namePl":"Pizza Miesna","ingredientsEn":"Beef, spicy pork, pepperoni sausage, mozzarella cheese, herb tomato sauce","ingredientsPl":"Wolowina, pikantna wieprzowina, pepperoni, mozzarella, ziolowy sos","quantity":20,"price":16.99,"type":1,"seq":5,"image":"meat.png"},{"id":6,"orderName":"product_6","nameEn":"Cheesy Pizza","namePl":"Pizza Serowa","ingredientsEn":"Cheddar, mozzarella, fresh mozzarella, corregio, garlic sauce","ingredientsPl":"Cheddar, mozzarella swieza, ser corregio, sos czosnkowy","quantity":20,"price":14.99,"type":1,"seq":6,"image":"cheese.png"},{"id":7,"orderName":"product_7","nameEn":"Chicken Pizza","namePl":"Pizza Kurczak","ingredientsEn":"Grilled chicken, corn, mozzarella, herb tomato sauce","ingredientsPl":"Grillowany kurczak, kukurydza, mozzarella, ziolowy sos pomidorowy","quantity":20,"price":13.49,"type":1,"seq":7,"image":"chicken.png"},{"id":8,"orderName":"product_8","nameEn":"Farmer Pizza","namePl":"Pizza Farmerska","ingredientsEn":"Grilled chicken, onion, green peppers, mushrooms, mozzarella cheese, herb tomato sauce","ingredientsPl":"Grillowany kurczak, cebula, zielona papryka, pieczarki, mozzarella, ziolowy sos pomidorowy","quantity":20,"price":14.99,"type":1,"seq":8,"image":"farmer.png"},{"id":9,"orderName":"product_9","nameEn":"Supreme Pizza","namePl":"Pizza Supreme","ingredientsEn":"Beef, pepperoni sausage, onion, green peppers, mushrooms, mozzarella","ingredientsPl":"Wolowina, pepperoni, cebula, zielona papryka, pieczarki, mozzarella, ziolowy sos pomidorowy","quantity":20,"price":16.49,"type":1,"seq":9,"image":"supreme.png"},{"id":10,"orderName":"drink_1","nameEn":"Coca-Cola","namePl":"Coca-Cola","ingredientsEn":"0,33 l, can","ingredientsPl":"0,33 l, puszka","quantity":20,"price":6.99,"type":2,"seq":1,"image":"cocacola.png"},{"id":11,"orderName":"drink_2","nameEn":"Coca-Cola light","namePl":"Coca-Cola light","ingredientsEn":"0,33 l, can","ingredientsPl":"0,33 ml, puszka","quantity":20,"price":6.99,"type":2,"seq":2,"image":"cocacolalight.png"},{"id":12,"orderName":"drink_3","nameEn":"Fanta","namePl":"Fanta","ingredientsEn":"0,33 l, can","ingredientsPl":"0,33 l, puszka","quantity":20,"price":6.99,"type":2,"seq":3,"image":"fanta.png"},{"id":13,"orderName":"drink_4","nameEn":"Sprite","namePl":"Sprite","ingredientsEn":"0,33 l, can","ingredientsPl":"0,33 l, puszka","quantity":20,"price":6.99,"type":2,"seq":4,"image":"sprite.png"},{"id":14,"orderName":"drink_5","nameEn":"Water","namePl":"Woda niegazowana","ingredientsEn":"0,5 l, butelka","ingredientsPl":"0,5 l butelka","quantity":20,"price":6.99,"type":2,"seq":5,"image":"woda.png"},{"id":15,"orderName":"drink_6","nameEn":"Sparkling Water","namePl":"Woda gazowana","ingredientsEn":"0,5 l, butelka","ingredientsPl":"0,5 l, butelka","quantity":20,"price":6.99,"type":2,"seq":6,"image":"wodagazowana.png"},{"id":16,"orderName":"sauce_1","nameEn":"Ketchup","namePl":"Keczup","ingredientsEn":"12 g","ingredientsPl":"12 g","quantity":20,"price":1.99,"type":3,"seq":1,"image":"ketchup.png"},{"id":17,"orderName":"sauce_2","nameEn":"Majo","namePl":"Sos majonezowy","ingredientsEn":"12 g","ingredientsPl":"12 g","quantity":20,"price":1.99,"type":3,"seq":2,"image":"mayo.png"},{"id":18,"orderName":"box","nameEn":"Takout box","namePl":"Pudelko na wynos","ingredientsEn":"Eko paper bag for 1 pizza","ingredientsPl":"ekologiczne papierowe pudelkona na 1 pizze","quantity":20,"price":1.99,"type":4,"seq":1,"image":"box.png"},{"id":19,"orderName":"bag","nameEn":"Paper bag","namePl":"Papierowa torba","ingredientsEn":"Eko paper bag that can contain up to 5 boxes","ingredientsPl":"Ekologiczna papierowa torba, ktora moze pomiescic do 5 pudelek","quantity":20,"price":0.99,"type":4,"seq":2,"image":"bag.png"}]');
//
//       _server!.enqueue(body: '[{"order_name":"product_1","quantity":12},{"order_name":"product_2","quantity":6},{"order_name":"product_3","quantity":3},{"order_name":"product_4","quantity":3},{"order_name":"product_5","quantity":3},{"order_name":"product_6","quantity":1},{"order_name":"product_7","quantity":1},{"order_name":"product_8","quantity":4},{"order_name":"product_9","quantity":14},{"order_name":"drink_1","quantity":2},{"order_name":"drink_2","quantity":3},{"order_name":"drink_3","quantity":3},{"order_name":"drink_4","quantity":4},{"order_name":"drink_5","quantity":0},{"order_name":"drink_6","quantity":6},{"order_name":"sauce_1","quantity":2},{"order_name":"sauce_2","quantity":5},{"order_name":"box","quantity":1},{"order_name":"bag","quantity":5}]');
//       await tester.tap(find.widgetWithText(ElevatedButton, "Dalej"));
//
//       await tester.pump(Duration(minutes: 1));
//     });
//
//   });
// }
