import 'package:kiosk_flutter/bootstrap.dart';
import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/my_app.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';

void main({String url = ApiConstants.baseUrl}) {
  AppConfig.initialize(flavor: Flavor.development);
  bootstrap(() => MyApp(url: url));
}
