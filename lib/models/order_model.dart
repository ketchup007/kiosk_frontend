class OrderModel{
  int id;
  int type_of_order;
  int product_1;
  int product_2;
  int product_3;
  int product_4;
  int product_5;
  int product_6;
  int product_7;
  int product_8;
  int product_9;
  int drink_1;
  int drink_2;
  int drink_3;
  int drink_4;
  int drink_5;
  int drink_6;
  int sauce_1;
  int sauce_2;
  int box;
  int bag;
  int status;
  String client_name;
  bool promotion_permision = false;

  OrderModel({
    required this.id,
    required this.type_of_order,
    required this.product_1,
    required this.product_2,
    required this.product_3,
    required this.product_4,
    required this.product_5,
    required this.product_6,
    required this.product_7,
    required this.product_8,
    required this.product_9,
    required this.drink_1,
    required this.drink_2,
    required this.drink_3,
    required this.drink_4,
    required this.drink_5,
    required this.drink_6,
    required this.sauce_1,
    required this.sauce_2,
    required this.box,
    required this.bag,
    required this.status,
    required this.client_name
  });

  //TO DO JSON FACTORY
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"] as int,
      type_of_order: 0,
      product_1: 0,
      product_2: 0,
      product_3: 0,
      product_4: 0,
      product_5: 0,
      product_6: 0,
      product_7: 0,
      product_8: 0,
      product_9: 0,
      drink_1: 0,
      drink_2: 0,
      drink_3: 0,
      drink_4: 0,
      drink_5: 0,
      drink_6: 0,
      sauce_1: 0,
      sauce_2: 0,
      box: 0,
      bag: 0,
      status: 0,
      client_name: '',
    );
  }

  factory OrderModel.resetModel() {
    return OrderModel(
      id: 0,
      type_of_order: 0,
      product_1: 0,
      product_2: 0,
      product_3: 0,
      product_4: 0,
      product_5: 0,
      product_6: 0,
      product_7: 0,
      product_8: 0,
      product_9: 0,
      drink_1: 0,
      drink_2: 0,
      drink_3: 0,
      drink_4: 0,
      drink_5: 0,
      drink_6: 0,
      sauce_1: 0,
      sauce_2: 0,
      box: 0,
      bag: 0,
      status: 0,
      client_name: '',
    );
  }
}