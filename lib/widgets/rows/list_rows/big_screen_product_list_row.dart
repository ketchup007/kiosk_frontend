import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/images/product_network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BigScreenProductListRow extends StatelessWidget{
  String name;
  String ingredients;
  List<StorageModel> storage;
  int index;
  List<bool> isVisiblePlus;
  List<bool> isVisibleMinus;

  BigScreenProductListRow({
    Key? key,
    required this.name,
    required this.ingredients,
    required this.storage,
    required this.index,
    required this.isVisiblePlus,
    required this.isVisibleMinus
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    print("Height of image: ${MediaQuery.of(context).size.width * 0.12}");

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025, 5, 5, 0),
              child: ProductNetworkImage(
                size: MediaQuery.of(context).size.width * 0.12,
                imageName: storage[index].image,
              )),
          Container(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.008, 5, 0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.width*0.06,
                            child: FittedBox(
                                child:Text(name,
                                  textAlign: TextAlign.start,
                                  textHeightBehavior: const TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                  style: const TextStyle(
                                      fontFamily: 'GloryBold',
                                      fontSize: 25)))),
                        SizedBox(height: MediaQuery.of(context).size.width*0.04,
                            child:
                            AutoSizeText(ingredients,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontFamily: 'GloryLightItalic', fontSize: 15)))]))),
          Container(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.017, 5, 0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                  child: FittedBox(
                      child: Text("${storage[index].price.toStringAsFixed(2)} zł",
                          style: const TextStyle(
                              fontFamily: 'GloryLightItalic', fontSize: 15))))),
          Container(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.015, 0, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.07,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: AppColors.mediumBlue),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: FittedBox(child: Text("${storage[index].number} ${AppLocalizations.of(context)!.pcs}",
                          style: const TextStyle(fontFamily: 'GloryMedium', fontSize: 15)))))),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.005, 0, 0),
                          child: Visibility(
                              visible: isVisibleMinus[index],
                              maintainState: true,
                              maintainSize: true,
                              maintainAnimation: true,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.06,
                                  height: MediaQuery.of(context).size.width * 0.06,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (storage[index].number > 0) {
                                          storage[index].number--;
                                          if (provider.order.id == 0) {
                                            provider.getFirstOrder(storage[index].orderName, storage[index].number);
                                          } else {
                                            provider.changeOrder(storage[index].orderName, storage[index].number);
                                          }
                                          provider.getSum();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          backgroundColor: AppColors.red),
                                      child: const Text("-",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30)))))),
                      Container(
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.005, 0, 0),
                          child: Visibility(
                              visible: isVisiblePlus[index],
                              maintainState: true,
                              maintainSize: true,
                              maintainAnimation: true,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.06,
                                  height: MediaQuery.of(context).size.width * 0.06,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (storage[index].number < provider.limits[storage[index].orderName]!) {
                                          storage[index].number++;
                                          if (provider.order.id == 0) {provider.getFirstOrder(
                                              storage[index].orderName,
                                              storage[index].number);
                                          } else {
                                            provider.changeOrder(storage[index].orderName, storage[index].number);
                                          }
                                          provider.getSum();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          backgroundColor: AppColors.mediumBlue),
                                      child: const Text("+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30))))))]),
                Text("${(storage[index].price * storage[index].number).toStringAsFixed(2)} zł",
                    style: const TextStyle(
                        fontFamily: "GloryMedium",
                        fontSize: 20))])]);
  }
}