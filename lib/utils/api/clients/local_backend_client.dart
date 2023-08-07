import 'package:kiosk_flutter/utils/api/api_client.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';

class LocalBackendClient extends ApiClient {

  LocalBackendClient(): super(ApiConstants.localUrl);


}