import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:provider/provider.dart';

class BigScreenOrderListRow extends StatelessWidget {
  const BigScreenOrderListRow({
    super.key,
    required this.item,
  });

  final MenuItemWithDescription item;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    int productCount = provider.getQuantityOfItemInOrder(item.itemDescription.id);
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.width * 0.001),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.width * 0.06,
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
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.03,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.itemDescription.name(context),
                      style: const TextStyle(
                        fontFamily: 'GloryBold',
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.025,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.itemDescription.description(context),
                      style: const TextStyle(
                        fontFamily: 'GloryLightItalic',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
            child: FittedBox(
              child: Text(
                '${item.menuItemPrice.price.toStringAsFixed(2)} zł',
                style: const TextStyle(
                  fontFamily: 'GloryLightItalic',
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, MediaQuery.of(context).size.width * 0.01, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.02,
              height: MediaQuery.of(context).size.width * 0.02,
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: AutoSizeText(
              '${(productCount * item.menuItemPrice.price).toStringAsFixed(2)} zł',
              textAlign: TextAlign.end,
              maxLines: 1,
              style: const TextStyle(
                fontFamily: 'GloryBold',
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
