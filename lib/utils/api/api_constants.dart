class ApiConstants {
  static const String baseUrl = "https://mnctest.avena.pl";

  static const String localUrl = "http://10.3.15.11:8000"; //10.3.15.11

  //Container Controller Endpoints
  static String getContainersList = "/api/containers/getList";

  //Orders Controller Endpoints
  static String order = "/kiosk/order"; //supabase
  static String updateOrder (int id) => "/kiosk/order/$id"; //supabase
  static String updateOrderStatus (int id) => "/kiosk/order/$id/status"; //supabase
  static String setClientNumber (int id) => "/kiosk/order/$id/client_phone"; //supabase
  static String setOrderNumber(int id) => "/kiosk/order/$id/order_number"; //supabase

  //Payment Controller Endpoints
  static String getPaymentMethods = "/api/payment/getPaymentMethods";
  static String getPaymentCredentials = "/api/payment/getCredentials";
  static String paymentNotifySet(int id) => "/api/payment/notify/set/$id";
  static String paymentNotifyGet(int id) => "/api/payment/notify/get/$id";
  static String payBlik = "/api/payment/pay/blik";
  static String payCard = "/api/payment/pay/card";
  static String payTokenCard = "/api/payment/pay/cardToken";
  static String payGpay = "/api/payment/pay/gpay";
  static String payApplePay = "/api/payment/pay/apple";

  static String payAuth = "/api/payment/getCredentialsEmail";
  static String payMethodsAuth(int id) =>
      "/api/payment/getPaymentMethodsV2/$id";

  static String transactionStatus(int id) =>
      "/api/payment/getTransactionData/$id";
  static String orderStatus(int id) => "/api/payment/getOrderData/$id";

  //Storage Controller Endpoints
  static String getProducts = "/api/storage/getProducts";
  static String getStorageState = "/kiosk/storage_limit"; // supabase
  static String getProductStorageState(String product) =>
      "/kiosk/storage_limit/$product"; //supabase

  static String getProductImage(String fileName) =>
      "/api/storage/getProductImage/$fileName";

  //Login Controller Endpoints
  static String smsLogin = "/api/smsLogin";
  static String getSmsToken = "/api/getSmsToken";
  static String loginToken = "/api/login_check";
}
