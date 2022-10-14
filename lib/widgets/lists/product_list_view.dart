import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';

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

    print(widget.storage.length);
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: widget.storage.length,
        itemBuilder: (context, index) {
          print(index);
          provider.getlimit(widget.storage[index].orderName, widget.storage[index].number);
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

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.025, 5, 5, 0),
                  child: Container(
                      height: MediaQuery.of(context).size.width * 0.12,
                      width: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 5,
                            color: Color.fromARGB(255, 248, 220, 173)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                              'http://10.3.15.98:8000/assets/${widget.storage[index].image}')))),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.008, 5, 0),
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${name}",
                      style: TextStyle(fontFamily: 'GloryBold', fontSize: 25),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          "${ingredients}",
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontFamily: 'GloryLightItalic', fontSize: 15),
                        ))
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.017, 5, 0),
                  child: Text(
                      "${widget.storage[index].price.toStringAsFixed(2)} zł",
                      style: TextStyle(
                          fontFamily: 'GloryLightItalic', fontSize: 15))),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.015, 0, 0),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 86, 197, 208)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        "${widget.storage[index].number} szt.",
                        style:
                            TextStyle(fontFamily: 'GloryMedium', fontSize: 15),
                      )))),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.01,
                                MediaQuery.of(context).size.height * 0.005,
                                0,
                                0),
                            child: Visibility(
                                visible: isVisibleMinus[index],
                                maintainState: true,
                                maintainSize: true,
                                maintainAnimation: true,
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                    height: MediaQuery.of(context).size.width *
                                        0.06,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (widget.storage[index].number >
                                              0) {
                                            widget.storage[index].number--;
                                            if (provider.order.id == 0) {
                                              provider.getFirstOrder(
                                                  widget
                                                      .storage[index].orderName,
                                                  widget.storage[index].number);
                                            } else {
                                              provider.changeOrder(
                                                  widget
                                                      .storage[index].orderName,
                                                  widget.storage[index].number);
                                            }
                                            provider.getSum();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            backgroundColor: Color.fromARGB(
                                                255, 218, 49, 62)),
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                        ))))),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.01,
                                MediaQuery.of(context).size.height * 0.005,
                                0,
                                0),
                            child: Visibility(
                                visible: isVisiblePlus[index],
                                maintainState: true,
                                maintainSize: true,
                                maintainAnimation: true,
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                    height: MediaQuery.of(context).size.width *
                                        0.06,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (widget.storage[index].number <
                                              provider.limits[widget
                                                  .storage[index].orderName]!) {
                                            widget.storage[index].number++;
                                            if (provider.order.id == 0) {
                                              provider.getFirstOrder(
                                                  widget
                                                      .storage[index].orderName,
                                                  widget.storage[index].number);
                                            } else {
                                              provider.changeOrder(
                                                  widget
                                                      .storage[index].orderName,
                                                  widget.storage[index].number);
                                            }
                                            provider.getSum();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            backgroundColor: Color.fromARGB(
                                                255, 86, 197, 208)),
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                        )))))
                      ]),
                  Text(
                    "${(widget.storage[index].price * widget.storage[index].number).toStringAsFixed(2)} zł",
                    style: TextStyle(fontFamily: "GloryMedium", fontSize: 20),
                  )
                ],
              )
            ],
          );
        });
  }
}
