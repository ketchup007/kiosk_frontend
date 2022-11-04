import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/big_screen_order_list_row.dart';
import 'package:kiosk_flutter/widgets/rows/list_rows/small_screnn_order_list_row.dart';

class OrderList extends StatefulWidget {
  final List<StorageModel> storage;

  const OrderList({Key? key, required this.storage}) : super(key: key);

  @override
  State createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.storage.length,
        itemBuilder: (context, index) {
          String name = widget.storage[index].namePl;
          String ingredients = widget.storage[index].ingredientsPl;

          if (Localizations.localeOf(context).toString() == 'en') {
            name = widget.storage[index].nameEn;
            ingredients = widget.storage[index].ingredientsEn;
          }

          if(MediaQuery.of(context).size.height > 1000){
            return BigScreenOrderListRow(
                storage: widget.storage,
                index: index,
                name: name,
                ingredients: ingredients);
          }else {
            return SmallScreenOrderListRow(
                storage: widget.storage,
                index: index,
                name: name,
                ingredients: ingredients);
          }});
  }
}
