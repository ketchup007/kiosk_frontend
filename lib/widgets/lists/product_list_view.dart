import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/images/product_network_image.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/big_screen_product_list_row.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../widgets/rows/list_rows/small_screen_product_list_row.dart';

class ProductList extends StatefulWidget {
  final List<StorageModel> storage;

  const ProductList({Key? key, required this.storage}) : super(key: key);

  @override
  State createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<bool> isVisiblePlus = [];
  List<bool> isVisibleMinus = [];

  @override
  void initState() {
    super.initState();
    isVisiblePlus = List<bool>.filled(widget.storage.length, true);
    isVisibleMinus = List<bool>.filled(widget.storage.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    setState(() {
      isVisiblePlus = List<bool>.filled(widget.storage.length, true);
      isVisibleMinus = List<bool>.filled(widget.storage.length, false);
    });



    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: widget.storage.length,
        itemBuilder: (context, index) {
          provider.getLimit(widget.storage[index].orderName, widget.storage[index].number);
          if(provider.limits[widget.storage[index].orderName]! == 0){
            isVisiblePlus[index] = false;
            isVisibleMinus[index] = false;
          } else if (widget.storage[index].number == 0) {
            isVisiblePlus[index] = true;
            isVisibleMinus[index] = false;
          } else if (widget.storage[index].number > 0 && widget.storage[index].number < provider.limits[widget.storage[index].orderName]!) {
            isVisiblePlus[index] = true;
            isVisibleMinus[index] = true;
          } else if (widget.storage[index].number == provider.limits[widget.storage[index].orderName]!) {
            isVisiblePlus[index] = false;
            isVisibleMinus[index] = true;
          }

          String name = widget.storage[index].namePl;
          String ingredients = widget.storage[index].ingredientsPl;

          if (Localizations.localeOf(context).toString() == 'en') {
            name = widget.storage[index].nameEn;
            ingredients = widget.storage[index].ingredientsEn;
          }

          if(MediaQuery.of(context).size.height > 1000){
            return BigScreenProductListRow(
                name: name,
                ingredients: ingredients,
                storage: widget.storage,
                index: index,
                isVisiblePlus: isVisiblePlus,
                isVisibleMinus: isVisibleMinus);
          }else{
            return SmallScreenProductListRow(
                name: name,
                ingredients: ingredients,
                storage: widget.storage,
                index: index,
                isVisiblePlus: isVisiblePlus,
                isVisibleMinus: isVisibleMinus);
          }


        });
  }
}





