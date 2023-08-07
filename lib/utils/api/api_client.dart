import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiosk_flutter/utils/api/api_response.dart';
import 'package:kiosk_flutter/utils/api/response/resonse_object.dart';

final DIO = Dio();

class ApiClient {
  final String _baseUrl;
  //final String apiKey;
  //final Logger logger;

  ApiClient(this._baseUrl);

  String buildUrl({
    required String endpoint,
    Map<String, String>? queryParams}) {
    var apiUri = Uri.parse(_baseUrl);
    print(apiUri);
    final apiPath = apiUri.path + endpoint;
    print(apiPath);
    final uri = Uri(
      scheme: apiUri.scheme,
      host:apiUri.host,
      port: apiUri.port,
      path: apiPath,
      queryParameters: queryParams).toString();
    return uri;
  }

  Map<String, dynamic> buildHeaders({String? token}) {
    Map<String,String> headers = {};

    if(token != "") {
      print(token);
    }
    return headers;
  }

  ApiResponse handleResponse(Response response) {

    Map<String, dynamic> body = <String, dynamic>{};

    if(response.data.isNotEmpty){
      body = response.data;
    }
    final apiResponse = ApiResponse(response.statusCode!, body);

    if (apiResponse.wasSuccessful()) {
      return apiResponse;
    } else {
      throw Exception();
    }
  }

  Future<ResponseObject> get({
      required String endpoint,
      required ResponseObject Function(Map<String, dynamic>) serializer,
      Map<String, String>? queryParams,
      Map<String, dynamic>? headers,
      String? token}) async {

    final String url = buildUrl(
      endpoint: endpoint,
      queryParams: queryParams);
    print(url);

    Map<String, dynamic> requestHeaders = buildHeaders(token: token);
    if(headers != null) {
      requestHeaders.addAll(headers);
    }
    //in try
    try {
      final response = await DIO.get(url, options: Options(headers: requestHeaders));
      ApiResponse apiResponse = handleResponse(response);

      return serializer(apiResponse.body);
    } on DioException catch (ex) {
      print(ex);
      throw Exception();
    }
  }

  void handleError(Response response) {}

}