import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/card/product_details_popup.dart';
import 'package:kiosk_flutter/widgets/images/product_network_image.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';

class SmallScreenProductListRow extends StatefulWidget {
  final MenuItemWithDescription item;
  final bool isVisiblePlus;
  final bool isVisibleMinus;

  const SmallScreenProductListRow({
    super.key,
    required this.isVisiblePlus,
    required this.isVisibleMinus,
    required this.item,
  });

  @override
  State<SmallScreenProductListRow> createState() => _SmallScreenProductListRowState();
}

class _SmallScreenProductListRowState extends State<SmallScreenProductListRow> {
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
    return Builder(
      builder: (context) {
        final quantity = context.select<OrderBloc, int>(
          (bloc) => bloc.state.getQuantityOfItemInOrder(widget.item.itemDescription.id!),
        );

        return Row(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ProductDetailsPopup(
                      name: widget.item.itemDescription.name(Localizations.localeOf(context).languageCode),
                      ingredients: widget.item.itemDescription.description(Localizations.localeOf(context).languageCode),
                      imageUrl: widget.item.itemDescription.image,
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.025, 5, 5, 0),
                child: ProductNetworkImage(
                  size: MediaQuery.of(context).size.height * 0.075,
                  imageName: widget.item.itemDescription.image,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ProductDetailsPopup(
                      name: widget.item.itemDescription.name(Localizations.localeOf(context).languageCode),
                      ingredients: widget.item.itemDescription.description(Localizations.localeOf(context).languageCode),
                      imageUrl: widget.item.itemDescription.image,
                    );
                  },
                );
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: AutoSizeText(
                        widget.item.itemDescription.name(Localizations.localeOf(context).languageCode),
                        textAlign: TextAlign.start,
                        minFontSize: 10,
                        maxFontSize: 17,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: 'GloryBold',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, 0, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.11,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.mediumBlue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      "$quantity ${AppText.of(context).pcs}",
                      style: const TextStyle(fontFamily: 'GloryMedium', fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
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
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: ElevatedButton(
                        onPressed: plusButtonAction,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: AppColors.red,
                        ),
                        child: const Center(
                          child: FittedBox(
                            child: Text(
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
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: ElevatedButton(
                        onPressed: minusButtonAction,
                        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: AppColors.mediumBlue),
                        child: const Center(
                          child: FittedBox(
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
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
          ],
        );
      },
    );
  }
}
