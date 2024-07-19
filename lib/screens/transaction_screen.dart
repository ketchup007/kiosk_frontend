import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiosk_flutter/models/orders/order_status.dart';

import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';

import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);
    provider.updateOrderStatus(OrderStatus.paymentInProgress);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: svg.Svg('assets/images/background.svg'), fit: BoxFit.cover),
        ),
        child: Container(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.05, 0),
                child: LanguageButtons(
                  ribbonHeight: MediaQuery.of(context).size.height * 0.05,
                  ribbonWidth: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/images/MuchiesLogoPlain.svg',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.1, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    surfaceTintColor: Colors.amber,
                    elevation: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Name'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: const Card(surfaceTintColor: Colors.white, child: Center(child: Text('Temp'))),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              provider.payment.priceToAscii(123);
                            },
                            child: const Text('Change'))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(AppText.current!.priceToPayInfo),
                            Text('${provider.sum}'),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 5,
                          indent: 20,
                          endIndent: 5,
                          color: Colors.black,
                        ),
                        Text(AppText.current!.conformationInfo)
                      ],
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: provider.payment.startTransaction(provider.sum),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      if (snapshot.data.toString() == "0") {
                        provider.updateOrderStatus(OrderStatus.paid);
                      } else {
                        print("in transaction");
                        provider.updateOrderStatus(OrderStatus.canceled);
                      }

                      return Text(snapshot.data.toString());
                    } else {
                      print(snapshot.data);
                      return const Text('Empty data');
                    }
                  } else {
                    return const Text('snapshot.connectionState');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
