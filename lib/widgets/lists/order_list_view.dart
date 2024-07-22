import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/menus/product_translated.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/big_screen_order_list_row.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/small_screnn_order_list_row.dart';

class OrderList extends StatelessWidget {
  final List<ProductTranslated> products;

  const OrderList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        if (MediaQuery.of(context).size.height > 1000) {
          return BigScreenOrderListRow(product: products[index]);
        } else {
          return SmallScreenOrderListRow(product: products[index]);
        }
      },
    );
  }
}
