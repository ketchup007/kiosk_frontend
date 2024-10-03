import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';

import 'package:kiosk_flutter/widgets/rows/list_rows/big_screen_order_list_row.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/small_screnn_order_list_row.dart';

class OrderList extends StatelessWidget {
  final List<MenuItemWithDescription> orderedItems;

  const OrderList({
    super.key,
    required this.orderedItems,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orderedItems.length,
      itemBuilder: (context, index) {
        if (MediaQuery.of(context).size.height > 1000) {
          return BigScreenOrderListRow(item: orderedItems[index]);
        } else {
          return SmallScreenOrderListRow(item: orderedItems[index]);
        }
      },
    );
  }
}
