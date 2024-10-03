import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/images/product_network_image.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';

class BigScreenProductListRow extends StatefulWidget {
  final MenuItemWithDescription item;
  final bool isVisiblePlus;
  final bool isVisibleMinus;

  const BigScreenProductListRow({
    super.key,
    required this.item,
    required this.isVisiblePlus,
    required this.isVisibleMinus,
  });

  @override
  State<BigScreenProductListRow> createState() => _BigScreenProductListRowState();
}

class _BigScreenProductListRowState extends State<BigScreenProductListRow> {
  void plusButtonAction() {
    if (widget.item.itemDescription.id != null) {
      final quantity = context.read<OrderBloc>().state.getQuantityOfItemInOrder(widget.item.itemDescription.id!);
      final availableQuantity = context.read<OrderBloc>().state.getAvailableQuantity(widget.item.itemDescription.id!);

      if (quantity < availableQuantity) {
        context.read<OrderBloc>().add(OrderEvent.addItemToOrder(widget.item.itemDescription.id!));
      }
    }
  }

  void minusButtonAction() {
    final quantity = context.read<OrderBloc>().state.getQuantityOfItemInOrder(widget.item.itemDescription.id!);
    if (quantity > 0) {
      context.read<OrderBloc>().add(OrderEvent.removeItemToOrder(widget.item.itemDescription.id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final quantity = context.select<OrderBloc, int>(
        (bloc) => bloc.state.getQuantityOfItemInOrder(widget.item.itemDescription.id!),
      );

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.025, 5, 5, 0),
              child: ProductNetworkImage(
                size: MediaQuery.of(context).size.width * 0.12,
                imageName: widget.item.itemDescription.image,
              )),
          Container(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.008, 5, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.06,
                    child: FittedBox(
                      child: Text(
                        widget.item.itemDescription.name(Localizations.localeOf(context).languageCode),
                        textAlign: TextAlign.start,
                        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                        style: const TextStyle(
                          fontFamily: 'GloryBold',
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.04,
                    child: AutoSizeText(
                      widget.item.itemDescription.description(Localizations.localeOf(context).languageCode),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontFamily: 'GloryLightItalic',
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.017, 5, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              child: FittedBox(
                child: Text(
                  "${widget.item.menuItemPrice.price.toStringAsFixed(2)} zł",
                  style: const TextStyle(
                    fontFamily: 'GloryLightItalic',
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.015, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.07,
              decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.mediumBlue), borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: FittedBox(
                  child: Text(
                    "$quantity ${AppText.of(context).pcs}",
                    style: const TextStyle(
                      fontFamily: 'GloryMedium',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.005, 0, 0),
                    child: Visibility(
                      visible: widget.isVisibleMinus,
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: MediaQuery.of(context).size.width * 0.06,
                        child: ElevatedButton(
                          onPressed: minusButtonAction,
                          style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: AppColors.red),
                          child: const Text(
                            "-",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.005, 0, 0),
                      child: Visibility(
                          visible: widget.isVisiblePlus,
                          maintainState: true,
                          maintainSize: true,
                          maintainAnimation: true,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                            height: MediaQuery.of(context).size.width * 0.06,
                            child: ElevatedButton(
                              onPressed: plusButtonAction,
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.mediumBlue,
                              ),
                              child: const Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          )))
                ],
              ),
              Text(
                "${(widget.item.menuItemPrice.price * quantity).toStringAsFixed(2)} zł",
                style: const TextStyle(
                  fontFamily: "GloryMedium",
                  fontSize: 20,
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
