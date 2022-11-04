import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/themes/color.dart';


class BigScreenOrderListRow extends StatelessWidget{
  List<StorageModel> storage;
  int index;
  String name;
  String ingredients;

  BigScreenOrderListRow({
    Key? key,
    required this.storage,
    required this.index,
    required this.name,
    required this.ingredients
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.width * 0.001),
        child: Row(children: [
          Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.width * 0.05,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mediumBlue),
                  child: Center(
                      child: FittedBox(
                          child: Text('${storage[index].number}x',
                              style: const TextStyle(
                                  fontFamily: 'GloryLight',
                                  fontSize: 30,
                                  color: Colors.white)))))),
          Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, 0, MediaQuery.of(context).size.width * 0.05, 0),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.025,
                        child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(name,
                                style: const TextStyle(
                                    fontFamily: 'GloryBold',
                                    fontSize: 20)))),
                    SizedBox(
                        height: MediaQuery.of(context).size.width * 0.025,
                        child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(ingredients,
                                style: const TextStyle(
                                    fontFamily: 'GloryLightItalic',
                                    fontSize: 15))))])),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              child: FittedBox(
                  child: Text('${storage[index].price.toStringAsFixed(2)} zł',
                      style: const TextStyle(
                          fontFamily: 'GloryLightItalic',
                          fontSize: 15)))),
          Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, MediaQuery.of(context).size.width * 0.01, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.02,
                  height: MediaQuery.of(context).size.width * 0.02,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mediumBlue,),
                  child: Center(
                      child: FittedBox(
                          child: Text('${storage[index].number}x',
                              style: const TextStyle(
                                  fontFamily: 'GloryLight',
                                  fontSize: 12,
                                  color: Colors.white)))))),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: FittedBox(
                  child: Text('${(storage[index].number * storage[index].price).toStringAsFixed(2)} zł',
                      style: const TextStyle(
                          fontFamily: 'GloryBold',
                          fontSize: 20))))]));
  }

}