import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> gettingIP() async{
  await Permission.location.request();
  final info = NetworkInfo();
  var hostAddress = await info.getWifiIP();
  //print(hostAddress);
  return hostAddress!;
}