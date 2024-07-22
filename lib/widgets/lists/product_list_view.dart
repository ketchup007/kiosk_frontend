import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/menus/product_translated.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/big_screen_product_list_row.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/small_screen_product_list_row.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final List<ProductTranslated> products;

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

    isVisiblePlus = List<bool>.filled(widget.products.length, true);
    isVisibleMinus = List<bool>.filled(widget.products.length, false);

    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];

          // TODO: await
          provider.refreshLimit(product.productId);
          int productCount = provider.getProductInOrderCount(product.productId);

          if ((provider.limits[product.productId] ?? 0) <= 0) {
            isVisiblePlus[index] = false;
            isVisibleMinus[index] = false;
          } else if (productCount == 0) {
            isVisiblePlus[index] = true;
            isVisibleMinus[index] = false;
          } else if (productCount > 0 && productCount < provider.limits[product.productId]!) {
            isVisiblePlus[index] = true;
            isVisibleMinus[index] = true;
          } else if (productCount == provider.limits[product.productId]!) {
            isVisiblePlus[index] = false;
            isVisibleMinus[index] = true;
          }

          if (MediaQuery.of(context).size.height > 1000) {
            return BigScreenProductListRow(
              product: product,
              isVisiblePlus: isVisiblePlus[index],
              isVisibleMinus: isVisibleMinus[index],
            );
          } else {
            return SmallScreenProductListRow(
              product: product,
              isVisiblePlus: isVisiblePlus[index],
              isVisibleMinus: isVisibleMinus[index],
            );
          }
        });
  }
}
