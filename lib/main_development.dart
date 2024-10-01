import 'package:kiosk_flutter/bootstrap.dart';
import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/my_app.dart';

void main() {
  AppConfig.initialize(flavor: Flavor.development);
  bootstrap(() => const MyApp());
}
