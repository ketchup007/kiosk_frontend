import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:provider/provider.dart';

class SmallScreenOrderListRow extends StatelessWidget {
  const SmallScreenOrderListRow({super.key, required this.item});

  final MenuItemWithDescription item;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    int productCount = provider.getQuantityOfItemInOrder(item.itemDescription.id);

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.width * 0.02),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, 0, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.mediumBlue),
              child: Center(
                child: FittedBox(
                  child: Text(
                    '${productCount}x',
                    style: const TextStyle(
                      fontFamily: 'GloryLight',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, 0, MediaQuery.of(context).size.width * 0.05, 0),
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  item.itemDescription.name(Localizations.localeOf(context).languageCode),
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: 'GloryBold',
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: AutoSizeText(
                    '${item.menuItemPrice.price.toStringAsFixed(2)} zł',
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: 'GloryLightItalic',
                      fontSize: 10,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, MediaQuery.of(context).size.width * 0.01, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.05,
                    height: MediaQuery.of(context).size.width * 0.05,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mediumBlue,
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          '${productCount}x',
                          style: const TextStyle(
                            fontFamily: 'GloryLight',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.05, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: AutoSizeText(
                      '${(productCount * item.menuItemPrice.price).toStringAsFixed(2)} zł',
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      style: const TextStyle(
                        fontFamily: 'GloryBold',
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
