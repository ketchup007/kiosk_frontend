import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/container_model.dart';

class Localization{

  static Future<LatLng> getGPS(ContainerModel container) async {
    var permission = await Geolocator.checkPermission();
    //print('permission = $permission');

    if(permission != LocationPermission.always && permission != LocationPermission.whileInUse){
      //print("ow now");
      return LatLng(0, 0);
    }

    var status = await Geolocator.isLocationServiceEnabled();
    //print("status = ${status}");
    if(status != true){
      return LatLng(0, 0);
    }

    Position location = await Geolocator.getCurrentPosition();
    return LatLng(location.latitude, location.longitude);
    //print("LAT: ${location.latitude}, LNG: ${location.longitude}");
   // print("container: LAT - ${container.latitude}, LNG: ${container.longitude}");


  }

  static double getDistance(ContainerModel container, LatLng position) {
    var deltaLat = (container.latitude * pi/180 - position.latitude * pi/180) * pi/180;
    var deltaLNG = (container.longitude * pi/180 - position.longitude * pi/180) * pi/180;
    var a = sin(deltaLat/2) * sin(deltaLat/2) + cos(container.latitude * pi/180) * cos(position.latitude * pi/180) * sin(deltaLNG/2) * sin(deltaLNG/2);
    var c = 2* atan2(sqrt(a), sqrt(1-a));
    var distance = 6371e3 * c;
    //print("distance $distance m");
    return distance;
  }


}