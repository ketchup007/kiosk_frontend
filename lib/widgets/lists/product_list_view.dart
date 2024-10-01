import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/big_screen_product_list_row.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/small_screen_product_list_row.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final List<MenuItemWithDescription> menuItems;

  const ProductList({
    super.key,
    required this.menuItems,
  });

  @override
  State createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<bool> isVisiblePlus = [];
  List<bool> isVisibleMinus = [];

  @override
  void initState() {
    super.initState();
    isVisiblePlus = List<bool>.filled(widget.menuItems.length, true);
    isVisibleMinus = List<bool>.filled(widget.menuItems.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    isVisiblePlus = List<bool>.filled(widget.menuItems.length, true);
    isVisibleMinus = List<bool>.filled(widget.menuItems.length, false);

    provider.refreshLimit();

    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: widget.menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = widget.menuItems[index];

          int productCount = provider.getQuantityOfItemInOrder(menuItem.itemDescription.id);

          if ((provider.limits[menuItem.itemDescription.id] ?? 0) <= 0) {
            isVisiblePlus[index] = false;
            isVisibleMinus[index] = false;
          } else if (productCount == 0) {
            isVisiblePlus[index] = true;
            isVisibleMinus[index] = false;
          } else if (productCount > 0 && productCount < provider.limits[menuItem.itemDescription.id]!) {
            isVisiblePlus[index] = true;
            isVisibleMinus[index] = true;
          } else if (productCount == provider.limits[menuItem.itemDescription.id]!) {
            isVisiblePlus[index] = false;
            isVisibleMinus[index] = true;
          }

          if (MediaQuery.of(context).size.height > 1000) {
            return BigScreenProductListRow(
              item: menuItem,
              isVisiblePlus: isVisiblePlus[index],
              isVisibleMinus: isVisibleMinus[index],
            );
          } else {
            return SmallScreenProductListRow(
              item: menuItem,
              isVisiblePlus: isVisiblePlus[index],
              isVisibleMinus: isVisibleMinus[index],
            );
          }
        });
  }
}
