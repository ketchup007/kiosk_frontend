import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiosk_flutter/utils/fetch_json.dart';

import '../../models/container_model.dart';

class Localization{

  static Future<double> getGPS(ContainerModel container) async {
    var permission = await Geolocator.checkPermission();
    print('permission = $permission');

    if(permission != LocationPermission.always && permission != LocationPermission.whileInUse){
      print("ow now");
      return -1;
    }

    var status = await Geolocator.isLocationServiceEnabled();
    print("status = ${status}");
    if(status != true){
      return -1;
    }

    Position location = await Geolocator.getCurrentPosition();
    print("LAT: ${location.latitude}, LNG: ${location.longitude}");
    print("container: LAT - ${container.latitude}, LNG: ${container.longitude}");

    var deltaLat = (container.latitude * pi/180 - location.latitude * pi/180) * pi/180;
    var deltaLNG = (container.longitude * pi/180 - location.longitude * pi/180) * pi/180;

    var a = sin(deltaLat/2) * sin(deltaLat/2) + cos(container.latitude * pi/180) * cos(location.latitude * pi/180) * sin(deltaLNG/2) * sin(deltaLNG/2);

    var c = 2* atan2(sqrt(a), sqrt(1-a));

    var distance = 6371e3 * c;
    print("distance $distance m");
    return distance;
  }
}