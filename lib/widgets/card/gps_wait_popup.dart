import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiosk_flutter/models/container_model.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/utils/geolocation/location_service.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';

class GpsWaitPopup extends StatefulWidget {
  final void Function() onPress;

  const GpsWaitPopup({
    Key? key,
    required this.onPress
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => GpsWaitPopupState();
}

class GpsWaitPopupState extends State<GpsWaitPopup> {
  int _state = 0;
  late ContainerModel containerChose;
  List<ContainerModel> containers = [];
  Set<Marker> markers = {};
  late Future<List<ContainerModel>?> _data;
  var _loading = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);
    if (_loading == true) {
      _data = ApiService(token: provider.loginToken).fetchContainer().whenComplete(() {
      _loading = false;
      });
    print("heh is loading $_loading");
    }

    return Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.57,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
                color: Colors.white,
                child: FutureBuilder(
                  future: _data,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator(color: AppColors.darkBlue);
                    }

                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return Text("Error");
                      }

                      if(!snapshot.hasData){
                        return Text("No data");
                      }else{
                        containers = snapshot.data as List<ContainerModel>;
                        for (int i = 0; i < containers.length; i++) {
                          markers.add(Marker(
                              markerId: MarkerId("${containers[i].address}"),
                              position: LatLng(containers[i].latitude, containers[i].longitude),
                              infoWindow: InfoWindow(
                                title: containers[i].address
                          )));
                        }
                        return Column(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01, 0, MediaQuery.of(context).size.height * 0.01),
                                child: Text("Wybierz punkt sprzedaży",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "GloryBold"))),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: RawScrollbar(
                                  thumbColor: AppColors.green,
                                  trackColor: Colors.white10,
                                  thumbVisibility: true,
                                  trackVisibility: true,
                                  thickness: 10,
                                  radius: Radius.circular(20),
                                  interactive: true,
                                  child: ListView.builder(
                                      itemCount: containers.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.65,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          containerChose = containers[index];
                                                          _state = 1;
                                                        });
                                                        },
                                                      style: ButtonStyle(
                                                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.white38)),
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                                padding: EdgeInsets.zero,
                                                                height: 30,
                                                                width: 30,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: AppColors.darkBlue),
                                                                child: Center(
                                                                    child: FittedBox(
                                                                        child: Text("${containers[index].id}",
                                                                            style: TextStyle(
                                                                                color: Colors.white
                                                                            ))))),
                                                            Text("  ${containers[index].address}",
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontFamily: "GloryMedium",
                                                                    color: Colors.black
                                                                ))])))]);
                                      }))),
                            Stack(
                              children: [
                                _state == 1 ? FutureBuilder(
                                    future: Localization.getGPS(containerChose),
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return  Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            height: MediaQuery.of(context).size.width * 0.2,
                                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2, MediaQuery.of(context).size.height * 0.25, 0, 0),
                                            child: CircularProgressIndicator(color: AppColors.darkBlue));
                                      }

                                      if(snapshot.connectionState == ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Text('Error');
                                        }

                                        if (!snapshot.hasData){
                                          return Text("noData");
                                        }else{
                                          LatLng currentPosition = snapshot.data as LatLng;
                                          double distance = Localization.getDistance(containerChose, currentPosition);
                                          if(distance<10 && distance > 0){
                                            return Container(
                                              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.21, MediaQuery.of(context).size.height*0.23, 0, 0),
                                              child: SizedBox(
                                                height: MediaQuery.of(context).size.height * 0.08,
                                                width: MediaQuery.of(context).size.width*0.5,
                                                child: ElevatedButton(
                                                    onPressed: widget.onPress,
                                                    style: ButtonStyle(
                                                        foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                                        backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.green),
                                                        shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))))
                                                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                                    child: Container(
                                                        alignment: Alignment.bottomCenter,
                                                        padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.02),
                                                        child: Text("Przejdź do składania zamówienia",
                                                            style: const TextStyle(
                                                                fontFamily: 'GloryExtraBold',
                                                                fontSize: 12)))),
                                              ),
                                            );
                                          }else{
                                            return Container(
                                              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.03, MediaQuery.of(context).size.height*0.27, 0, 0),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.6,
                                                  child: Text("Jesteś za daleko kontenera, podejdź bliżej albo wybierz inny kontener ",
                                                    textAlign: TextAlign.center,)),
                                            );
                                          }
                                        }
                                      }
                                      return Text("");
                                    }) : Text(""),

                                Card(
                                  color: AppColors.mediumBlue,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    child: Center(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.65,
                                        height: MediaQuery.of(context).size.height * 0.24,
                                        child: GoogleMap(
                                          mapType: MapType.terrain,
                                          mapToolbarEnabled: false,
                                          compassEnabled: false,
                                          myLocationButtonEnabled: true,
                                          myLocationEnabled: true,
                                          markers: markers,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(containers[0].latitude, containers[0].longitude),
                                            zoom: 14.0))))))
                              ],
                            )
                          ]);
                      }
                    }
                    return Text(snapshot.connectionState.toString());
                  }))));
  }
}