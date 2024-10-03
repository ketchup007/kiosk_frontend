import 'package:flutter/material.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/start_screen_kiosk.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:provider/provider.dart';

class PaymentStatusScreen extends StatefulWidget {
  final int id;

  const PaymentStatusScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PaymentStatusScreenState();
}

class PaymentStatusScreenState extends State<PaymentStatusScreen> {
  late MainProvider provider;
  int status = 0;

  int orderNumber = 1;

  bool paymentFlag = false;
  bool smsFlag = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    if (status == 0) {
      //Checking payment status state
      if (!paymentFlag) {
        paymentFlag = true;
        ApiService(token: provider.loginToken).checkPaymentStatus(widget.id).then((value) => {
              if (value == "COMPLETED")
                {
                  setState(() {
                    status = 1;

                    context.read<OrderBloc>().add(const OrderEvent.updateOrderStatus(OrderStatus.paid));
                  })
                }
              else if (value == "CANCELED")
                {
                  setState(() {
                    status = 3;
                    context.read<OrderBloc>().add(const OrderEvent.updateOrderStatus(OrderStatus.canceled));
                  })
                }
            });
      }
    } else if (status == 1) {
      //Sending SMS state
      if (!smsFlag) {
        smsFlag = true;
        provider.testRoute().then((value) => {
              setState(() {
                orderNumber = value;
                status = 2;
              })
            });
      }
    } else {}

    return Background(
      child: Column(
        children: [
          Builder(
            builder: (context) {
              final double totalOrderAmount = context.select<OrderBloc, double>(
                (bloc) => bloc.state.totalOrderAmount,
              );

              return PayUTopBar(
                onPress: () {},
                amount: totalOrderAmount,
              );
            },
          ),
          status == 0
              ? Column(
                  children: [
                    Container(padding: const EdgeInsets.all(20), child: const Text("Płatność rozpoczęta")),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.5, height: MediaQuery.of(context).size.width * 0.5, child: const CircularProgressIndicator())
                  ],
                )
              : status == 1
                  ? Column(
                      children: [Container(padding: const EdgeInsets.all(10), child: const Text("Płatność zakończona powodzeniem", style: TextStyle(fontSize: 20))), const CircularProgressIndicator()])
                  : status == 2
                      ? Column(children: [
                          Container(padding: const EdgeInsets.all(10), child: const Text("Płatność zakończona powodzeniem", style: TextStyle(fontSize: 20))),
                          Container(padding: const EdgeInsets.all(10), child: Text('Twoje zamówienie ma nr $orderNumber', style: const TextStyle(fontSize: 15))),
                          ElevatedButton(
                            onPressed: () {
                              context.read<OrderBloc>().add(const OrderEvent.finishOrder());
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
                            },
                            child: const Text("Zakończ transakcje"),
                          )
                        ])
                      : Column(
                          children: [
                            const Text("Płatność anulowana"),
                            ElevatedButton(
                              onPressed: () {
                                context.read<OrderBloc>().add(const OrderEvent.cancelOrder());
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
                              },
                              child: const Text("Zakończ transakcje"),
                            ),
                          ],
                        ),
        ],
      ),
    );
  }
}
