import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/menus/munchie_product.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/big_screen_product_list_row.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/small_screen_product_list_row.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final List<MunchieProduct> products;

  const ProductList({
    super.key,
    required this.products,
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
    isVisiblePlus = List<bool>.filled(widget.products.length, true);
    isVisibleMinus = List<bool>.filled(widget.products.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    setState(() {
      isVisiblePlus = List<bool>.filled(widget.products.length, true);
      isVisibleMinus = List<bool>.filled(widget.products.length, false);
    });

    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          provider.getLimit(widget.products[index].productKey);
          if (provider.limits[widget.products[index].productKey]! <= 0) {
            isVisiblePlus[index] = false;
            isVisibleMinus[index] = false;
          } else if (widget.products[index].number == 0) {
            isVisiblePlus[index] = true;
            isVisibleMinus[index] = false;
          } else if (widget.products[index].number > 0 && widget.products[index].number < provider.limits[widget.products[index].productKey]!) {
            isVisiblePlus[index] = true;
            isVisibleMinus[index] = true;
          } else if (widget.products[index].number == provider.limits[widget.products[index].productKey]!) {
            isVisiblePlus[index] = false;
            isVisibleMinus[index] = true;
          }

          if (MediaQuery.of(context).size.height > 1000) {
            return BigScreenProductListRow(
              product: widget.products[index],
              isVisiblePlus: isVisiblePlus[index],
              isVisibleMinus: isVisibleMinus[index],
            );
          } else {
            return SmallScreenProductListRow(
              product: widget.products[index],
              isVisiblePlus: isVisiblePlus[index],
              isVisibleMinus: isVisibleMinus[index],
            );
          }
        });
  }
}
