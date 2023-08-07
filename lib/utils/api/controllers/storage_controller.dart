import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:kiosk_flutter/utils/api/clients/local_backend_client.dart';
import 'package:kiosk_flutter/utils/api/response/resonse_object.dart';

class StorageController {
  final LocalBackendClient localBackendClient;

  StorageController(this.localBackendClient);

  ProductStateObject serialize(Map<String,dynamic> body){
    //var map = <String,dynamic>{};
    //body["quantity"]
    return ProductStateObject(body["order_name"], body["quantity"]);

  }

  Future<ResponseObject> fetchStorageState() async {
    return localBackendClient.get(endpoint: ApiConstants.getProductStorageState("product_1"), serializer: serialize);
  }
}

class ProductStateObject extends ResponseObject {
  String productName;
  int quantity;

  ProductStateObject(this.productName, this.quantity);
}