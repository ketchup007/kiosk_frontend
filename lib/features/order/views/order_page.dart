import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:kiosk_flutter/screens/start_screen_kiosk.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/buttons/category_buttons.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:kiosk_flutter/widgets/card/buy_more_popup.dart';
import 'package:kiosk_flutter/widgets/card/summary_card.dart';
import 'package:kiosk_flutter/widgets/lists/product_list_view.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  RestartableTimer? _timer;

  @override
  void initState() {
    super.initState();

    _timerStart();
  }

  void _timerStart({int minutes = 10}) {
    _timer?.cancel();
    _timer = RestartableTimer(Duration(minutes: minutes), () {
      context.read<OrderBloc>().add(const OrderEvent.cancelOrder());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
    });
  }

  void _timerReset() {
    if (_timer?.isActive == true) {
      _timer?.reset();
    }
  }

  void _cancelOrder() {
    _timer?.cancel();
    context.read<OrderBloc>().add(const OrderEvent.cancelOrder());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
  }

  void _summaryPressed() {
    _timerStart(minutes: 30);
    context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.summary));
    final totalOrderAmount = context.read<OrderBloc>().state.totalOrderAmount;

    if (totalOrderAmount != 0) {
      showDialog(
        context: context,
        builder: (context) {
          return const BuyMorePopup();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _timerReset(),
      child: Background(
        child: Column(
          children: [
            Stack(
              children: [
                const _Label(),
                const _AnimationBody(),
                _Buttons(
                  timerStart: _timerStart,
                  summaryPressed: _summaryPressed,
                ),
                const _AnimationArm(),
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.9, 0, 0),
                    width: MediaQuery.of(context).size.width > 1000 ? MediaQuery.of(context).size.width * 0.89 : MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.width * 0.18 : MediaQuery.of(context).size.width * 0.25,
                              child: Visibility(
                                visible: !provider.inPayment,
                                maintainState: true,
                                maintainSize: true,
                                maintainAnimation: true,
                                child: ElevatedButton(
                                  onPressed: _cancelOrder,
                                  style: ButtonStyle(
                                    foregroundColor: WidgetStateProperty.resolveWith((states) => Colors.white),
                                    backgroundColor: WidgetStateProperty.resolveWith((states) => AppColors.red),
                                    shape: WidgetStateProperty.resolveWith(
                                      (states) => const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.0),
                                          bottomRight: Radius.circular(15.0),
                                        ),
                                      ),
                                    ),
                                    elevation: WidgetStateProperty.resolveWith((states) => 0.0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.02),
                                    child: FittedBox(
                                      child: Text(
                                        AppText.of(context).cancelButtonLabel,
                                        style: const TextStyle(
                                          fontFamily: 'GloryExtraBold',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.width * 0.18 + 2 : MediaQuery.of(context).size.width * 0.25 + 2,
                              height: MediaQuery.of(context).size.height * 0.021,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.015, 0, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.025,
                                  child: FittedBox(
                                    child: Text(
                                      AppText.of(context).orderTotalText,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'GloryLight',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: FittedBox(
                                    child: Builder(builder: (context) {
                                      final totalOrderAmount = context.select((OrderBloc bloc) => bloc.state.totalOrderAmount);
                                      return Text(
                                        '${totalOrderAmount.toStringAsFixed(2)} zł',
                                        textHeightBehavior: const TextHeightBehavior(
                                          applyHeightToFirstAscent: false,
                                          applyHeightToLastDescent: false,
                                          leadingDistribution: TextLeadingDistribution.even,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontFamily: 'GloryBold',
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.015,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: FittedBox(
                                    child: Text(
                                      AppText.of(context).paymentConformationText,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'GloryLightItalic',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.width * 0.18 : MediaQuery.of(context).size.width * 0.25,
                              child: Visibility(
                                visible: !provider.inPayment,
                                maintainState: true,
                                maintainSize: true,
                                maintainAnimation: true,
                                child: InkWell(
                                  onTapDown: (_) {
                                    _summaryPressed();
                                  },
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _summaryPressed();
                                    },
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStateProperty.resolveWith((states) => Colors.white),
                                      backgroundColor: WidgetStateProperty.resolveWith((states) => AppColors.green),
                                      shape: WidgetStateProperty.resolveWith(
                                        (states) => const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0),
                                          ),
                                        ),
                                      ),
                                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.02),
                                      child: FittedBox(
                                        child: Text(
                                          AppText.of(context).summaryButtonLabel,
                                          style: const TextStyle(
                                            fontFamily: 'GloryExtraBold',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.width * 0.18 + 2 : MediaQuery.of(context).size.width * 0.25 + 2,
                              height: MediaQuery.of(context).size.height * 0.021,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  final selectedTab = context.select((OrderBloc bloc) => bloc.state.selectedTab);
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.27, 0, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: MediaQuery.of(context).size.width > 1000 ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width * 0.91,

                      // TODO: do przemyslenia co robi to inne card?

                      child: selectedTab == TabCategory.summary
                          ? SummaryCard(
                              onInteraction: () => _timer?.reset(),
                              onPopUpFinish: () => _timer?.cancel(),
                            )
                          : Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: AppColors.mediumBlue),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 6,
                              surfaceTintColor: Colors.white,
                              child: Builder(
                                builder: (context) {
                                  final items = context.select((OrderBloc bloc) => bloc.state.menuItemsBySelectedTab());
                                  return ProductList(items: items);
                                },
                              ),
                            ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimationArm extends StatelessWidget {
  const _AnimationArm();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.fromLTRB(
        0,
        MediaQuery.of(context).size.height * 0.123,
        MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.width * 0.065 : MediaQuery.of(context).size.width * 0.055,
        0,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.11, child: const Text("tu powinna być animacja"),
        // RiveAnimation.asset(
        //    'assets/animations/newArms.riv',
        //      alignment: Alignment.bottomRight)
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.timerStart,
    required this.summaryPressed,
  });

  final void Function({int minutes}) timerStart;
  final void Function() summaryPressed;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final selectedTab = context.select((OrderBloc bloc) => bloc.state.selectedTab);

      return Container(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.055, MediaQuery.of(context).size.height * 0.20, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EdgeCategoryButton(
              selected: selectedTab == TabCategory.snack,
              onPressed: () {
                timerStart();
                context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.snack));
              },
              number: 1,
              text: AppText.of(context).pizzaItemLabel,
            ),
            CategoryButton(
              selected: selectedTab == TabCategory.drink,
              text: AppText.of(context).drinksItemLabel,
              number: 2,
              onPressed: () {
                timerStart();
                context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.drink));
              },
            ),
            CategoryButton(
              selected: selectedTab == TabCategory.takeAwayBox,
              text: AppText.of(context).boxesItemLabel,
              number: 3,
              onPressed: () {
                timerStart();
                context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.takeAwayBox));
              },
            ),
            CategoryButton(
              selected: selectedTab == TabCategory.sauce,
              text: AppText.of(context).saucesItemLabel,
              number: 4,
              onPressed: () {
                timerStart();
                context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.sauce));
              },
            ),
            SummaryButton(
              selected: selectedTab == TabCategory.summary,
              onPressed: summaryPressed,
              number: 5,
              text: AppText.of(context).summaryButtonLabel,
            ),
          ],
        ),
      );
    });
  }
}

class _AnimationBody extends StatelessWidget {
  const _AnimationBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.fromLTRB(
        0,
        MediaQuery.of(context).size.height * 0.123,
        MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.width * 0.065 : MediaQuery.of(context).size.width * 0.055,
        0,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.11,
        child: const Text("tu powinna być animacja"),
        // child: RiveAnimation.asset(
        //  'assets/animations/newBody.riv',//Ri
        //  alignment: Alignment.bottomRight,
        // ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: size.height * 0.14,
              width: size.width * 0.55,
              padding: EdgeInsets.fromLTRB(size.width * 0.06, size.height * 0.03, 0, 0),
              child: SvgPicture.asset(
                'assets/images/MuchiesLogoPlain.svg',
                alignment: Alignment.centerLeft,
                fit: BoxFit.fitWidth,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Przewidywany czas oczekiwania: 16 min (TODO)"),
            ),
          ],
        ),
        Container(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(
                  right: size.width * 0.08,
                ),
                child: LanguageButtons(
                  ribbonHeight: size.height * 0.05,
                  ribbonWidth: size.width * 0.05,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  0,
                  size.height * 0.015,
                  size.width * 0.05,
                  0,
                ),
                width: size.width * 0.2,
                child: const FittedBox(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: 60,
                      fontFamily: 'GloryMedium',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
