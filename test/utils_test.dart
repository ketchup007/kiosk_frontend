// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';

// import 'package:http/http.dart' as http;
// import 'package:kiosk_flutter/models/storage_limits_model.dart';
// import 'package:kiosk_flutter/models/storage_model.dart';
// import 'package:kiosk_flutter/utils/api/api_constants.dart';
// import 'package:kiosk_flutter/utils/api/api_service.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';

// import 'utils_test.mocks.dart';

// @GenerateMocks([http.Client])
// void main() {
  
//   group('APITests', () {
//     test('returns container string if the http call completes successfully', () async {
//       final client = MockClient();
//       String token = "AFAIFHAUIuinaifis1243";
//       when(client
//           .get(Uri.parse('https://mnctest.avena.pl/api/containers/get/gujh1yNBfR'), headers: {'Authorization': 'Bearer $token'}))
//         .thenAnswer((_) async =>
//           http.Response('{"id":1,"address":"Jagiellonsk 5a, Gdansk","latitude":54.41287712408064,"longitude":18.590699050579197,"status":1,"identifier":"gujh1yNBfR","db":"default"}',
//               200));

//       expect(await ApiService(token: token).getFromLink('https://mnctest.avena.pl/api/containers/get/gujh1yNBfR', client),
//           '{"id":1,"address":"Jagiellonsk 5a, Gdansk","latitude":54.41287712408064,"longitude":18.590699050579197,"status":1,"identifier":"gujh1yNBfR","db":"default"}');
//     });

//     test('returns Storage if the http completes successfully', () async {
//       final client = MockClient();
//       String token = "AFAIFHAUIuinaifis1243";

//       when(client
//         .post(Uri.parse(ApiConstants.baseUrl + ApiConstants.getProducts),
//           headers: {'Authorization': 'Bearer $token'},
//           body: jsonEncode(<String, String>{'db': 'default'})
//       ))
//       .thenAnswer((_) async =>
//         http.Response('[{"id":1,"orderName":"product_1","nameEn":"Margherita Pizza","namePl":"Pizza Margherita","ingredientsEn":"Mozzarella cheese, herb tomato sauce","ingredientsPl":"Mozzarella, ziolowy sos pomidorowy","quantity":21,"price":10.99,"type":1,"seq":1,"image":"margherita.png"},{"id":2,"orderName":"product_2","nameEn":"Pepperoni Pizza","namePl":"Pizza Pepperoni","ingredientsEn":"Pepperoni sausage, mozzarella cheese, herb tomato sauce","ingredientsPl":"Pepperoni, mozzarella,  ziolowy sos pomidorowy","quantity":20,"price":13.49,"type":1,"seq":2,"image":"pepperoni.png"},{"id":3,"orderName":"product_3","nameEn":"Hawaiian Pizza ","namePl":"Pizza Hawajska","ingredientsEn":"Ham, pineapple, mozzarella cheese, herb tomato sauce","ingredientsPl":"Szynka, ananas, ser mozzarella, ziolowy sos pomidorowy","quantity":20,"price":14.99,"type":1,"seq":3,"image":"hawaiian.png"},{"id":4,"orderName":"product_4","nameEn":"Capricciosa Pizza","namePl":"Pizza Capricciosa","ingredientsEn":"Ham, mushrooms, cherry tomatoes, olives, mozzarella cheese, herb tomato sauce","ingredientsPl":"Szynka, pieczarki, pomidorki koktajlowe, oliwki, ser mozzarella, sos pomidorowy","quantity":20,"price":14.99,"type":1,"seq":4,"image":"capriccisa.png"},{"id":5,"orderName":"product_5","nameEn":"Meat Pizza","namePl":"Pizza Miesna","ingredientsEn":"Beef, spicy pork, pepperoni sausage, mozzarella cheese, herb tomato sauce","ingredientsPl":"Wolowina, pikantna wieprzowina, pepperoni, mozzarella, ziolowy sos","quantity":20,"price":16.99,"type":1,"seq":5,"image":"meat.png"},{"id":6,"orderName":"product_6","nameEn":"Cheesy Pizza","namePl":"Pizza Serowa","ingredientsEn":"Cheddar, mozzarella, fresh mozzarella, corregio, garlic sauce","ingredientsPl":"Cheddar, mozzarella swiza, ser corregio, sos czosnkowy","quantity":20,"price":14.99,"type":1,"seq":6,"image":"cheese.png"},{"id":7,"orderName":"product_7","nameEn":"Chicken Pizza","namePl":"Pizza Kurczak","ingredientsEn":"Grilled chicken, corn, mozzarella, herb tomato sauce","ingredientsPl":"Grillowany kurczak, kukurydza, mozzarella, ziolowy sos pomidorowy","quantity":20,"price":13.49,"type":1,"seq":7,"image":"chicken.png"},{"id":8,"orderName":"product_8","nameEn":"Farmer Pizza","namePl":"Pizza Farmerska","ingredientsEn":"Grilled chicken, onion, green peppers, mushrooms, mozzarella cheese, herb tomato sauce","ingredientsPl":"Grillowany kurczak, cebula, zielona papryka, pieczarki, mozzarella, ziolowy sos pomidorowy","quantity":20,"price":14.99,"type":1,"seq":8,"image":"farmer.png"},{"id":9,"orderName":"product_9","nameEn":"Supreme Pizza","namePl":"Pizza Supreme","ingredientsEn":"Beef, pepperoni sausage, onion, green peppers, mushrooms, mozzarella","ingredientsPl":"Wolowina, pepperoni, cebula, zielona papryka, pieczarki, mozzarella, ziolowy sos pomidorowy","quantity":20,"price":16.49,"type":1,"seq":9,"image":"supreme.png"},{"id":10,"orderName":"drink_1","nameEn":"Coca-Cola","namePl":"Coca-Cola","ingredientsEn":"0,33 l, can","ingredientsPl":"0,33 l, puszka","quantity":20,"price":6.99,"type":2,"seq":1,"image":"cocacola.png"},{"id":11,"orderName":"drink_2","nameEn":"Coca-Cola light","namePl":"Coca-Cola light","ingredientsEn":"0,33 l, can","ingredientsPl":"0,33 ml, puszka","quantity":20,"price":6.99,"type":2,"seq":2,"image":"cocacolalight.png"},{"id":12,"orderName":"drink_3","nameEn":"Fanta","namePl":"Fanta","ingredientsEn":"0,33 l, can","ingredientsPl":"0,33 l, puszka","quantity":20,"price":6.99,"type":2,"seq":3,"image":"fanta.png"},{"id":13,"orderName":"drink_4","nameEn":"Sprite","namePl":"Sprite","ingredientsEn":"0,33 l, can","ingredientsPl":"0,33 l, puszka","quantity":20,"price":6.99,"type":2,"seq":4,"image":"sprite.png"},{"id":14,"orderName":"drink_5","nameEn":"Water","namePl":"Woda niegazowana","ingredientsEn":"0,5 l, butelka","ingredientsPl":"0,5 l butelka","quantity":20,"price":6.99,"type":2,"seq":5,"image":"woda.png"},{"id":15,"orderName":"drink_6","nameEn":"Sparkling Water","namePl":"Woda gazowana","ingredientsEn":"0,5 l, butelka","ingredientsPl":"0,5 l, butelka","quantity":20,"price":6.99,"type":2,"seq":6,"image":"wodagazowana.png"},{"id":16,"orderName":"sauce_1","nameEn":"Ketchup","namePl":"Keczup","ingredientsEn":"12 g","ingredientsPl":"12 g","quantity":20,"price":1.99,"type":3,"seq":1,"image":"ketchup.png"},{"id":17,"orderName":"sauce_2","nameEn":"Majo","namePl":"Sos majonezowy","ingredientsEn":"12 g","ingredientsPl":"12 g","quantity":20,"price":1.99,"type":3,"seq":2,"image":"mayo.png"},{"id":18,"orderName":"box","nameEn":"Takout box","namePl":"Pudelko na wynos","ingredientsEn":"Eko paper bag for 1 pizza","ingredientsPl":"ekologiczne papierowe pudelkona na 1 pizze","quantity":20,"price":1.99,"type":4,"seq":1,"image":"box.png"},{"id":19,"orderName":"bag","nameEn":"Paper bag","namePl":"Papierowa torba","ingredientsEn":"Eko paper bag that can contain up to 5 boxes","ingredientsPl":"Ekologiczna papierowa torba, ktora moze pomiescic do 5 pudelek","quantity":20,"price":0.99,"type":4,"seq":2,"image":"bag.png"}]',
//             200));

//       expect(await ApiService(token: token).fetchStorage(client), isA<List<StorageModel>>());
//     });

//     test('returns Storage limit if the http completes successfully', () async {
//      final client = MockClient();
//      String token = "AFAIFHAUIuinaifis1243";

//      when(client
//       .post(
//          Uri.parse(ApiConstants.baseUrl + ApiConstants.getStorageState),
//          headers: {'Authorization': 'Bearer $token'},
//          body: jsonEncode(<String, String>{'db': 'default'})))
//      .thenAnswer((_) async =>
//         http.Response('[{"order_name":"product_1","quantity":12},{"order_name":"product_2","quantity":6},{"order_name":"product_3","quantity":3},{"order_name":"product_4","quantity":4},{"order_name":"product_5","quantity":4},{"order_name":"product_6","quantity":1},{"order_name":"product_7","quantity":1},{"order_name":"product_8","quantity":4},{"order_name":"product_9","quantity":14},{"order_name":"drink_1","quantity":2},{"order_name":"drink_2","quantity":4},{"order_name":"drink_3","quantity":4},{"order_name":"drink_4","quantity":4},{"order_name":"drink_5","quantity":0},{"order_name":"drink_6","quantity":6},{"order_name":"sauce_1","quantity":2},{"order_name":"sauce_2","quantity":5},{"order_name":"box","quantity":1},{"order_name":"bag","quantity":5}]', 200));

//      expect(await ApiService(token: token).fetchStorageLimits(client), isA<List<StorageLimitsModel>>());
//     });

//     test('returns id if the http completes successfully', () async {
//       final client = MockClient();
//       String token = "AFAIFHAUIuinaifis1243";

//       when(client
//         .post(
//           Uri.parse(ApiConstants.baseUrl + ApiConstants.order),
//           headers: {'Authorization': 'Bearer $token'},
//           body: jsonEncode(<String, String>{'db': 'default'})))
//       .thenAnswer((_) async =>
//         http.Response('{"id":343}', 200));

//       expect(await ApiService(token: token).createFirstOrder(client), 343);
//     });

//     test('return quantity if the http completes successfully', () async {
//       final client = MockClient();
//       String token = "AFAIFHAUIuinaifis1243";

//       when(client.post(
//           Uri.parse(ApiConstants.baseUrl +
//               ApiConstants.getProductStorageState("product_1")),
//           headers: {'Authorization': 'Bearer $token'},
//           body: jsonEncode(<String, String>{'db': "default"})))
//       .thenAnswer((_) async =>
//         http.Response('{"order_name":"product_1","quantity":12}', 200));

//       expect(await ApiService(token: token).fetchProductState(client, "product_1"), 12);
//     });

//     test('return order number if the http completes successfully', () async {
//       final client = MockClient();
//       String token = "AFAIFHAUIuinaifis1243";

//       when(
//         client.patch(
//             Uri.parse(ApiConstants.localUrl + ApiConstants.setOrderNumber(5)),
//         ))
//         .thenAnswer((_) async =>
//           http.Response('{"order_number":9}', 200));

//       expect(await ApiService(token: token).fetchOrderNumber(client, 5), 9);
//     });

//     //do payment and login tests
//   });
// }