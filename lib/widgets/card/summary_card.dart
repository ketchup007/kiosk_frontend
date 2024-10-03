import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_flutter/common/loading_status.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/screens/payment_screens/new_payu_screen.dart';
import 'package:kiosk_flutter/utils/payment_sockets.dart';
import 'package:kiosk_flutter/screens/start_screen_kiosk.dart';

import 'package:kiosk_flutter/widgets/lists/order_list_view.dart';
import 'package:kiosk_flutter/widgets/card/phone_popup_card.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:async/async.dart';

class SummaryCard extends StatefulWidget {
  final Function onInteraction;
  final Function onPopUpFinish;

  const SummaryCard({Key? key, required this.onInteraction, required this.onPopUpFinish}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SummaryCardState();
}

class SummaryCardState extends State<SummaryCard> {
  var _paymentState = 0; // 0 - Not Started, 1 - Processing, 2 - Not Accepted, 3 - Accepted

  RestartableTimer? timer;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void _timerStart() {
    timer?.cancel();
    timer = RestartableTimer(const Duration(minutes: 1), () async {
      context.read<OrderBloc>().add(const OrderEvent.cancelOrder());

      setState(() {
        _paymentState = 0;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
    });
  }

  void _timerStop() {
    timer?.cancel();
  }

  void makePayment() {
    final totalOrderAmount = context.read<OrderBloc>().state.totalOrderAmount;
    if (totalOrderAmount != 0) {
      showDialog(
        context: context,
        builder: (context) {
          return PhonePopupCard(
            onInteraction: () {
              widget.onInteraction();
            },
            onPress: (isPromotionChecked) {
              widget.onPopUpFinish();

              if (MediaQuery.of(context).size.height > 1000) {
                setState(() {
                  _paymentState = 1;
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewPayUScreen(),
                  ),
                );
              }
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppColors.green,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      surfaceTintColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: size.height > 1000 ? size.width * 0.4 : size.width * 0.6,
              height: size.height * 0.05,
              child: FittedBox(
                child: Text(
                  AppText.of(context).orderSummaryText,
                  style: const TextStyle(
                    fontFamily: 'GloryExtraBold',
                    fontSize: 30,
                    color: AppColors.mediumBlue,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.4,
            child: Builder(
              builder: (context) {
                final orderedItems = context.select<OrderBloc, List<MenuItemWithDescription>>(
                  (bloc) => bloc.state.getOrderList(),
                );
                return OrderList(orderedItems: orderedItems);
              },
            ),
          ),
          _paymentState == 0
              ? Container(
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.fromLTRB(0, size.height * 0.05, size.width * 0, 0),
                  child: InkWell(
                    onTapDown: (_) {
                      makePayment();
                    },
                    child: SizedBox(
                      width: size.height > 1000 ? size.width * 0.86 : size.width * 0.8,
                      height: size.height > 1000 ? size.height * 0.05 : size.height * 0.075,
                      child: ElevatedButton(
                        onPressed: () {
                          makePayment();
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                        child: SizedBox(
                          width: size.height > 1000 ? size.width * 0.4 : size.width * 0.5,
                          child: FittedBox(
                            child: Text(
                              AppText.of(context).makePaymentButtonLabel,
                              style: const TextStyle(
                                fontFamily: 'GloryBold',
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              : size.height > 1000
                  ? Builder(builder: (context) {
                      final totalOrderAmount = context.select<OrderBloc, double>((bloc) => bloc.state.totalOrderAmount);
                      return FutureBuilder(
                          future: RepositoryProvider.of<PaymentService>(context).startTransaction(totalOrderAmount),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                              _timerStop();
                              return Column(
                                children: [
                                  SizedBox(
                                    height: size.width > 1000 ? size.height * 0.1 : size.height * 0.17,
                                    width: size.width * 0.86,
                                    child: Card(
                                      color: AppColors.green,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: size.width > 1000 ? size.width * 0.04 : size.width * 0.08,
                                            child: FittedBox(
                                              child: Text(
                                                AppText.of(context).paymentStartedText.toUpperCase(),
                                                style: const TextStyle(
                                                  fontFamily: 'GloryExtraBold',
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.width > 1000 ? size.width * 0.03 : size.width * 0.06,
                                            width: size.width * 0.8,
                                            child: FittedBox(
                                              child: Text(
                                                AppText.of(context).paymentInfoText,
                                                style: const TextStyle(
                                                  fontFamily: 'GloryMedium',
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const CircularProgressIndicator(color: AppColors.darkGreen),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasData) {
                                //print("Its done: ${snapshot.data.toString()}");
                                print("snapshot data");
                                print(snapshot.data);
                                if (snapshot.data.toString() == "7") {
                                  // change flag to test 7, for normal 0
                                  //print("Its done: ${snapshot.data.toString()}");
                                  //provider.changeOrderStatus(2);
                                  _timerStop();
                                  context.read<OrderBloc>().add(const OrderEvent.getKDSOrderNumber());
                                  return Column(children: [
                                    SizedBox(
                                      height: size.height * 0.1,
                                      width: size.width * 0.86,
                                      child: Card(
                                        color: AppColors.green,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                AppText.of(context).paymentAcceptedText.toUpperCase(),
                                                style: const TextStyle(
                                                  fontFamily: 'GloryExtraBold',
                                                  fontSize: 25,
                                                ),
                                              ),
                                              Builder(builder: (context) {
                                                final kdsOrderNumberStatus = context.select<OrderBloc, LoadingStatus>((bloc) => bloc.state.kdsOrderNumberStatus);
                                                final String kdsOrderNumber = context.select<OrderBloc, int?>((bloc) => bloc.state.order?.kdsOrderNumber)?.toString() ?? '-';

                                                if (kdsOrderNumberStatus.isFailure) {
                                                  return const Text('Error');
                                                } else if (kdsOrderNumberStatus.isLoading) {
                                                  return const CircularProgressIndicator(color: AppColors.darkGreen);
                                                } else if (kdsOrderNumberStatus.isSuccess) {
                                                  return Text('Twoje zamówienie ma nr $kdsOrderNumber');
                                                } else {
                                                  return const SizedBox();
                                                }
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, size.height * 0.01, 0, 0),
                                      child: SizedBox(
                                        height: size.width > 1000 ? size.height * 0.03 : size.height * 0.05,
                                        width: size.width > 1000 ? size.width * 0.2 : size.width * 0.4,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            context.read<OrderBloc>().add(const OrderEvent.finishOrder());
                                            _paymentState = 0;
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
                                          },
                                          style: OutlinedButton.styleFrom(foregroundColor: AppColors.red, side: const BorderSide(color: AppColors.red, width: 1)),
                                          child: AutoSizeText(
                                            AppText.of(context).returnButtonLabel,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'GloryMedium',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]);
                                } else {
                                  _timerStart();
                                  context.read<OrderBloc>().add(const OrderEvent.cancelOrder());
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.1,
                                        width: size.width * 0.86,
                                        child: Card(
                                          color: AppColors.red,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  AppText.of(context).paymentCancelledText.toUpperCase(),
                                                  style: const TextStyle(
                                                    fontFamily: 'GloryExtraBold',
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(0, size.height * 0.01, 0, 0),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(size.width * 0.02, 0, 0, 0),
                                              child: SizedBox(
                                                height: size.height > 1000 ? size.width * 0.05 : size.width * 0.1,
                                                width: size.height > 1000 ? size.width * 0.2 : size.width * 0.4,
                                                child: InkWell(
                                                  onTapDown: (_) {
                                                    _timerStop();
                                                    context.read<OrderBloc>().add(const OrderEvent.cancelOrder());
                                                    setState(() {
                                                      _paymentState = 0;
                                                    });
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
                                                  },
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      _timerStop();
                                                      context.read<OrderBloc>().add(const OrderEvent.cancelOrder());
                                                      setState(() {
                                                        _paymentState = 0;
                                                      });
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
                                                    },
                                                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.red, side: const BorderSide(color: AppColors.red, width: 1)),
                                                    child: FittedBox(
                                                      child: Text(
                                                        AppText.of(context).returnButtonLabel,
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontFamily: 'GloryMedium',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(size.height > 1000 ? size.width * 0.45 : size.width * 0.05, 0, 0, 0),
                                              child: SizedBox(
                                                height: size.height > 1000 ? size.width * 0.05 : size.width * 0.1,
                                                width: size.height > 1000 ? size.width * 0.2 : size.width * 0.4,
                                                child: InkWell(
                                                  onTapDown: (_) {
                                                    _timerStop();
                                                    context.read<OrderBloc>().add(const OrderEvent.updateOrderStatus(OrderStatus.paymentInProgress));
                                                    setState(() {
                                                      _paymentState = 1;
                                                    });
                                                  },
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      _timerStop();
                                                      context.read<OrderBloc>().add(const OrderEvent.updateOrderStatus(OrderStatus.paymentInProgress));
                                                      setState(() {
                                                        _paymentState = 1;
                                                      });
                                                    },
                                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                                                    child: FittedBox(
                                                      child: Text(
                                                        AppText.of(context).tryAgainButtonLabel,
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontFamily: 'GloryMedium',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              } else {
                                return const Text('Empty data');
                              }
                            } else {
                              return const Text('snapshot.connectionState');
                            }
                          });
                    })
                  : SizedBox(
                      height: size.height * 0.18,
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPayUScreen()));
                        },
                        child: const Text("go"),
                      ),
                    ),
        ],
      ),
    );
  }
}
