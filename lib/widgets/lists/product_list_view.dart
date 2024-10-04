import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/big_screen_product_list_row.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/small_screen_product_list_row.dart';

class ProductList extends StatefulWidget {
  final List<MenuItemWithDescription> items;

  const ProductList({
    super.key,
    required this.items,
  });

  @override
  State createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];

        return Builder(
          builder: (context) {
            final quantity = context.select<OrderBloc, int>(
              (bloc) => bloc.state.getQuantityOfItemInOrder(item.itemDescription.id!),
            );
            final availableQuantity = context.select<OrderBloc, int>(
              (bloc) => bloc.state.getAvailableQuantity(item.itemDescription.id!),
            );

            bool isVisiblePlus = availableQuantity > 0 && quantity < availableQuantity;
            bool isVisibleMinus = quantity > 0;

            if (MediaQuery.of(context).size.height > 1000) {
              return BigScreenProductListRow(
                item: item,
                isVisiblePlus: isVisiblePlus,
                isVisibleMinus: isVisibleMinus,
              );
            } else {
              return SmallScreenProductListRow(
                item: item,
                isVisiblePlus: isVisiblePlus,
                isVisibleMinus: isVisibleMinus,
              );
            }
          },
        );
      },
    );
  }
}
