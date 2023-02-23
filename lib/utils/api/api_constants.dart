class ApiConstants {
  static String baseUrl = "https://mnctest.avena.pl";

  //Container Controller Endpoints
  static String getContainersList = "/api/containers/getList";

  //Orders Controller Endpoints
  static String createOrder = "/api/orders/createOrder";
  static String updateOrder = "/api/orders/updateOrder";
  static String getClientName(int id) => "/api/orders/getClientName/$id";
  static String setClientNumber = "/api/orders/setClientNumber";
  static String sendSms(int id) => "/api/orders/sendSms/$id";
  //static String setClientName(int id) => "/api/orders/setClientName/$id";

  //Payment Controller Endpoints
  static String getPaymentMethods = "/api/payment/getPaymentMethods";
  static String getPaymentCredentials = "/api/payment/getCredentials";
  static String paymentNotifySet(int id) => "/api/payment/notify/set/$id";
  static String paymentNotifyGet(int id) => "/api/payment/notify/get/$id";
  static String payBlik = "/api/payment/pay/blik";
  static String payCard = "/api/payment/pay/card";
  static String payTokenCard = "/api/payment/pay/cardToken";
  static String payGpay = "/api/payment/pay/gpay";

  static String payAuth = "/api/payment/getCredentialsEmail";
  static String payMethodsAuth(int id) => "/api/payment/getPaymentMethodsV2/$id";

  static String transactionStatus(int id) => "/api/payment/getTransactionData/$id";
  static String orderStatus(int id) => "/api/payment/getOrderData/$id";

  //Storage Controller Endpoints
  static String getProducts = "/api/storage/getProducts";
  static String getStorageState = "/api/storage/getStorageState";
  static String getProductStorageState(String orderName) => "/api/storage/getProductStorageState/$orderName";
  static String getProductImage(String fileName) => "/api/storage/getProductImage/$fileName";

  //Login Controller Endpoints
  static String smsLogin = "/api/smsLogin";
  static String getSmsToken = "/api/getSmsToken";
  static String loginToken = "/api/login_check";
}