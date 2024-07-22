import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/menus/product_translated.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/card/product_details_popup.dart';
import 'package:kiosk_flutter/widgets/images/product_network_image.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';

class SmallScreenProductListRow extends StatelessWidget {
  final ProductTranslated product;
  final bool isVisiblePlus;
  final bool isVisibleMinus;

  const SmallScreenProductListRow({
    super.key,
    required this.isVisiblePlus,
    required this.isVisibleMinus,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    int productCount = provider.getProductInOrderCount(product.productId);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return ProductDetailsPopup(
                    name: product.name,
                    ingredients: product.ingredientNamesAsString,
                    imageName: product.image,
                  );
                });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.025, 5, 5, 0),
            child: ProductNetworkImage(
              size: MediaQuery.of(context).size.height * 0.075,
              imageUrl: product.image,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return ProductDetailsPopup(
                    name: product.name,
                    ingredients: product.ingredientNamesAsString,
                    imageName: product.image,
                  );
                });
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: AutoSizeText(
                    product.name,
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
                      "${product.price.toStringAsFixed(2)} zł",
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
                  "${productCount} ${AppText.current.pcs}",
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
                visible: isVisibleMinus,
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: ElevatedButton(
                    onPressed: () {
                      int productCount = provider.getProductInOrderCount(product.productId);
                      if (productCount > 0) {
                        provider.removeProductToOrder(product.productId);
                      }
                    },
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
                visible: isVisiblePlus,
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: ElevatedButton(
                    onPressed: () {
                      int productCount = provider.getProductInOrderCount(product.productId);
                      if (productCount < provider.limits[product.productId]!) {
                        provider.addProductToOrder(product.productId);
                      }
                    },
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
  }
}
