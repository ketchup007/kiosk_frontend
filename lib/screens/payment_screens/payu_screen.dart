import 'package:flutter/material.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:provider/provider.dart';

class PayUScreen extends StatefulWidget {
  const PayUScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PayUScreenState();
}

class _PayUScreenState extends State<PayUScreen> {
  late MainProvider provider;
  @override
  Widget build(context) {
    provider = Provider.of<MainProvider>(context, listen: true);
    return Background(
      child: Builder(
        builder: (context) {
          final totalOrderAmount = context.read<OrderBloc>().state.totalOrderAmount;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PayUTopBar(
                onPress: () => Navigator.pop(context),
                amount: totalOrderAmount,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: MobilePayment(amount: totalOrderAmount),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
