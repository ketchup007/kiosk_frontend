import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/features/order/views/order_page.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/utils/payment_sockets.dart';
import 'package:kiosk_flutter/widgets/lists/order_list_view.dart';
import 'package:kiosk_flutter/screens/start_screen_kiosk.dart';
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
    return Background(
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
                          RepositoryProvider.of<PaymentService>(context).priceToAscii(123);
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
                      Row(
                        children: [
                          Text(AppText.of(context).priceToPayInfo),
                          Builder(
                            builder: (context) {
                              final totalOrderAmount = context.select<OrderBloc, double>(
                                (bloc) => bloc.state.totalOrderAmount,
                              );
                              return Text(
                                '$totalOrderAmount',
                              );
                            },
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 5,
                        color: Colors.black,
                      ),
                      Text(AppText.of(context).conformationInfo)
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      RepositoryProvider.of<PaymentService>(context).startTransaction(11);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionScreen()));
                    },
                    child: Text(
                      AppText.of(context).paymentButtonLabel,
                    ),
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
                    Text(AppText.of(context).summaryInfo),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        elevation: 6,
                        surfaceTintColor: Colors.white,
                        child: Builder(
                          builder: (context) {
                            final orderedItems = context.select<OrderBloc, List<MenuItemWithDescription>>(
                              (bloc) => bloc.state.getOrderList(),
                            );

                            return OrderList(orderedItems: orderedItems);
                          },
                        ),
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
                    context.read<OrderBloc>().add(const OrderEvent.cancelOrder());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
                  },
                  child: Text(AppText.of(context).cancelOrderButtonLabel),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPage()));
                  },
                  child: Text(AppText.of(context).editOrderButtonLabel),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
