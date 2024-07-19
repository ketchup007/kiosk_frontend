import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';

import 'package:kiosk_flutter/widgets/lists/order_list_view.dart';

import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/screens/order_screen.dart';

import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:kiosk_flutter/screens/transaction_screen.dart';

class SumScreen extends StatefulWidget {
  const SumScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SumScreenState();
}

class _SumScreenState extends State<SumScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: svg.Svg('assets/images/background.svg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.05, 0),
                child: LanguageButtons(
                  ribbonHeight: MediaQuery.of(context).size.height * 0.08,
                  ribbonWidth: MediaQuery.of(context).size.width * 0.075,
                ),
              ),
              Center(
                child: SvgPicture.asset('assets/images/MuchiesLogoPlain.svg', width: MediaQuery.of(context).size.width * 0.6),
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
                          child: const Text('Change'),
                        )
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
                        Row(children: [Text(AppText.current!.priceToPayInfo), Text('${provider.sum}')]),
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
                    ElevatedButton(
                      onPressed: () {
                        //provider.payment.startTransaction(11);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionScreen()));
                      },
                      child: Text(AppText.current!.paymentButtonLabel),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppText.current!.summaryInfo),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Card(
                          elevation: 6,
                          surfaceTintColor: Colors.white,
                          child: OrderList(products: provider.storageOrders),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      provider.orderCancel();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreen()));
                    },
                    child: Text(AppText.current!.cancelOrderButtonLabel),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderScreen()));
                    },
                    child: Text(AppText.current!.editOrderButtonLabel),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
