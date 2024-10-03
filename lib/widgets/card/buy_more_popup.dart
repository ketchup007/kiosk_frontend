import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/buttons/category_buttons.dart';
import 'package:kiosk_flutter/widgets/lists/product_list_view.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';

class BuyMorePopup extends StatefulWidget {
  const BuyMorePopup({super.key});

  @override
  State<StatefulWidget> createState() => _BuyMorePopupState();
}

class _BuyMorePopupState extends State<BuyMorePopup> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: size.height * 0.68,
            width: size.width * 0.9,
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTapDown: (_) {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.01,
                            size.width * 0.01,
                            size.width * 0.03,
                            0,
                          ),
                          child: SizedBox(
                            width: size.width * 0.06,
                            height: size.width * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.red,
                              ),
                              child: const Center(
                                child: FittedBox(
                                  child: Text(
                                    "X",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, size.height * 0.02, 0, 0),
                            child: SizedBox(
                              width: size.width * 0.55,
                              child: FittedBox(
                                child: Text(
                                  AppText.of(context).begPopupTitle,
                                  textHeightBehavior: const TextHeightBehavior(
                                    applyHeightToFirstAscent: false,
                                    applyHeightToLastDescent: false,
                                    leadingDistribution: TextLeadingDistribution.even,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: "GloryBold",
                                    fontSize: 77,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              width: size.width * 0.54,
                              height: size.height * 0.06,
                              child: AutoSizeText(
                                AppText.of(context).begPopupInformation,
                                maxLines: 3,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontFamily: "GloryMedium",
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(size.width * 0.09, size.height * 0.01, 0, 0),
                    child: Row(
                      children: [
                        CategoryButton(
                          selected: false,
                          onPressed: () {
                            context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.snack));
                            Navigator.of(context).pop();
                          },
                          number: 1,
                          text: AppText.of(context).pizzaItemLabel,
                        ),
                        CategoryButton(
                          selected: false,
                          onPressed: () {
                            context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.drink));
                            Navigator.of(context).pop();
                          },
                          number: 2,
                          text: AppText.of(context).drinksItemLabel,
                        ),
                        CategoryButton(
                          selected: false,
                          onPressed: () {
                            context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.takeAwayBox));
                            Navigator.of(context).pop();
                          },
                          number: 3,
                          text: AppText.of(context).boxesItemLabel,
                        ),
                        CategoryButton(
                          selected: false,
                          onPressed: () {
                            context.read<OrderBloc>().add(const OrderEvent.changeTabCategory(TabCategory.sauce));
                            Navigator.of(context).pop();
                          },
                          number: 4,
                          text: AppText.of(context).saucesItemLabel,
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width > 1000 ? size.width * 0.27 : size.width * 0.40,
                      child: FittedBox(
                        child: Text(
                          AppText.of(context).productPropositionText,
                          style: const TextStyle(
                            fontFamily: 'GloryExtraBold',
                            fontSize: 30,
                            color: AppColors.mediumBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      height: size.height * 0.3,
                      child: Builder(builder: (context) {
                        final List<MenuItemWithDescription> suggestItems = context.select<OrderBloc, List<MenuItemWithDescription>>(
                          (bloc) => bloc.state.suggestItemsForPurchase(),
                        );

                        return ProductList(
                          items: suggestItems,
                        );
                      }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, size.height * 0.01, 0, 0),
                    child: Center(
                      child: InkWell(
                        onTapDown: (_) {
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                          height: size.height * 0.06,
                          width: size.width > 1000 ? size.width * 0.8 : size.width * 0.6,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                            child: FittedBox(
                              child: Text(
                                AppText.of(context).goToSummaryButtonLabel,
                                style: const TextStyle(
                                  fontFamily: 'GloryMedium',
                                  fontSize: 25,
                                ),
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
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, size.height * 0.195, size.width * 0.05 - size.height * 0.02, 0),
          alignment: Alignment.topRight,
          child: SizedBox(
            height: size.height * 0.15,
            child: Image.asset(
              'assets/images/robotAnimation/orderMenuRobot/newRobotBeg.png',
              alignment: Alignment.bottomRight,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }
}
