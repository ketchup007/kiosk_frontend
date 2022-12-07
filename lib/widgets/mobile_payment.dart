import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/models/pay_methods_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/blik_payment_screen.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:provider/provider.dart';

class MobilePayment extends StatefulWidget{
  final double amount;
  
  const MobilePayment({
    Key? key,
    required this.amount
  }): super(key: key);
  
  @override
  State<StatefulWidget> createState() => MobilePaymentState();
}

class MobilePaymentState extends State<MobilePayment>{
  int state = 0;
  bool inPayment = false;
  int id = 0;
  TextEditingController controller = TextEditingController();
  late MainProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Text("Wybierz metodę płatności",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.35,
            child:FutureBuilder(
              future: ApiService().fetchPaymentMethods(),
              builder: (context, snapshot){

                if(snapshot.hasData){
                  List<PayMethodsModel> data = snapshot.data as List<PayMethodsModel>;
                  List<PayMethodsModel> output = [];
                  id = data[0].transactionId;
                  for(int i= 0; i < data.length; i++){
                    if(data[i].value == "blik"){
                      output.add(data[i]);
                    }
                  }
                  //print(output.length);
                  
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 /2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                      itemCount: output.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BlikPayScreen(amount: widget.amount, id: id)));
                                //setState(() {state = 1;});
                              },
                                child: Image.network(output[index].brandImageUrl))
                            );
                      },
                  );
                } else if(snapshot.hasError){
                  return Text("");
                } else {
                  return CircularProgressIndicator();
                }
              })),
        ]);
  }
  
}