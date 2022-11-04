import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/themes/color.dart';

class SmallScreenOrderListRow extends StatelessWidget{
  List<StorageModel> storage;
  int index;
  String name;
  String ingredients;

  SmallScreenOrderListRow({
    Key? key,
    required this.storage,
    required this.index,
    required this.name,
    required this.ingredients
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.width * 0.02),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02, 0, 0, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
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
            alignment: Alignment.center,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Container(
                  alignment: Alignment.centerLeft,
                   child: AutoSizeText(name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: 'GloryBold',
                      fontSize: 15))))),
          Flexible(
              fit: FlexFit.loose,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: AutoSizeText('${storage[index].price.toStringAsFixed(2)} zł',
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: 'GloryLightItalic',
                            fontSize: 10))),
                    Container(
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, MediaQuery.of(context).size.width * 0.01, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.width * 0.05,
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
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width* 0.05, 0),

                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: AutoSizeText('${(storage[index].number * storage[index].price).toStringAsFixed(2)} zł',
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          style: const TextStyle(
                          fontFamily: 'GloryBold',
                          fontSize: 20))))
                  ]
                )
              ))
        ],
      )
    );
  }}