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
  int product_10;
  int product_11;
  int product_12;
  int product_13;
  int product_14;
  int product_15;
  int product_16;
  int product_17;
  int product_18;
  int product_19;
  int product_20;
  int product_21;
  int product_22;
  int product_23;
  int status;
  String client_phone_number;

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
    required this.product_10,
    required this.product_11,
    required this.product_12,
    required this.product_13,
    required this.product_14,
    required this.product_15,
    required this.product_16,
    required this.product_17,
    required this.product_18,
    required this.product_19,
    required this.product_20,
    required this.product_21,
    required this.product_22,
    required this.product_23,
    required this.status,
    required this.client_phone_number
  });

  //TO DO JSON FACTORY
  // factory OrderModel.fromJson(Map<String, dynamic> json) {
  //   return OrderModel(
  //     id: json["id"] as int,
  //     type_of_order: 0,
  //     product_1: 0,
  //     product_2: 0,
  //     product_3: 0,
  //     product_4: 0,
  //     product_5: 0,
  //     product_6: 0,
  //     product_7: 0,
  //     product_8: 0,
  //     product_9: 0,
  //     product_10: 0,
  //     product_11: 0,
  //     product_12: 0,
  //     product_13: 0,
  //     product_14: 0,
  //     product_15: 0,
  //     product_16: 0,
  //     product_17: 0,
  //     product_18: 0,
  //     product_19: 0,
  //     status: 0,
  //     client_phone_number: '',
  //   );
  // }

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
      product_10: 0,
      product_11: 0,
      product_12: 0,
      product_13: 0,
      product_14: 0,
      product_15: 0,
      product_16: 0,
      product_17: 0,
      product_18: 0,
      product_19: 0,
      product_20: 0,
      product_21: 0,
      product_22: 0,
      product_23: 0,
      status: 0,
      client_phone_number: '',
    );
  }
}