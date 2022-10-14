import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';

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
          return Row(children: [
            Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.05,
                    height: MediaQuery.of(context).size.width * 0.05,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 86, 197, 208),
                    ),
                    child: Center(
                        child: Text('${widget.storage[index].number}x',
                            style: TextStyle(
                                fontFamily: 'GloryLight',
                                fontSize: 30,
                                color: Colors.white))))),
            Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.02, 0, 0, 0),
                width: MediaQuery.of(context).size.width * 0.62,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.storage[index].namePl,
                      style: TextStyle(fontFamily: 'GloryBold', fontSize: 20),
                    ),
                    Text(
                      widget.storage[index].ingredientsPl,
                      style: TextStyle(
                          fontFamily: 'GloryLightItalic', fontSize: 15),
                    )
                  ],
                )),
            Text(
              '${widget.storage[index].price.toStringAsFixed(2)} zł',
              style: TextStyle(fontFamily: 'GloryLightItalic', fontSize: 15),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01,
                  0,
                  MediaQuery.of(context).size.width * 0.01,
                  0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.02,
                  height: MediaQuery.of(context).size.width * 0.02,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 86, 197, 208),
                  ),
                  child: Center(
                      child: Text('${widget.storage[index].number}x',
                          style: TextStyle(
                              fontFamily: 'GloryLight',
                              fontSize: 12,
                              color: Colors.white)))),
            ),
            Text(
              '${(widget.storage[index].number * widget.storage[index].price).toStringAsFixed(2)} zł',
              style: TextStyle(fontFamily: 'GloryBold', fontSize: 20),
            )
          ]);
        });
  }
}
