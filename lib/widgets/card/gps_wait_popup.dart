import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/container_model.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/fetch_json.dart';
import 'package:kiosk_flutter/utils/geolocation/location_service.dart';

class GpsWaitPopup extends StatefulWidget {
  final void Function() onPress;

  const GpsWaitPopup({
    Key? key,
    required this.onPress
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => GpsWaitPopupState();
}

class GpsWaitPopupState extends State<GpsWaitPopup>{
  int _state = 0;
  late ContainerModel containerChose;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.01),
                child: Text("Wybierz punkt sprzedarzy")
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.2,
                child: FutureBuilder(
                  future: fetchContainer(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator(color: AppColors.darkBlue);
                    }
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return Text('Error');
                      }

                      if(snapshot.hasData){
                        List<ContainerModel> containers = snapshot.data as List<ContainerModel>;
                        return ListView.builder(
                            itemCount: containers.length,
                            itemBuilder: (context, index) {
                              return ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      containerChose = containers[index];
                                      _state = 1;
                                    });
                                  },
                                  child: Row(
                                children: [
                                  Text("${containers[index].id}  "),
                                  Text("${containers[index].address}")
                                ],
                              ));
                            });
                      }

                      return Text('Empty data');
                    }

                    return Text(snapshot.connectionState.toString());
                  })),
              _state == 1 ? FutureBuilder(
                  future: Localization.getGPS(containerChose),
                  builder: (context, snapshot) {

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator(color: AppColors.darkBlue);
                    }

                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return Text('Error');
                      }

                      if(snapshot.hasData){
                        double distance = snapshot.data as double;
                        if( distance < 10){
                          return ElevatedButton(
                              onPressed: widget.onPress,
                              child: Text("Przejdź do składania zamówienia"));
                        } else {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text("Jesteś za daleko kontenera, podejdź bliżej albo wybierz inny kontener "));
                        }
                      }

                      return Text('Empty data');
                    }

                    return Text(snapshot.connectionState.toString());
                  }) : Container()
            ],
          ))));
  }


}