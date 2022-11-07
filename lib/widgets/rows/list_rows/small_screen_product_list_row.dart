import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/card/product_details_popup.dart';
import 'package:kiosk_flutter/widgets/images/product_network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SmallScreenProductListRow extends StatelessWidget{
  String name;
  String ingredients;
  List<StorageModel> storage;
  int index;
  List<bool> isVisiblePlus;
  List<bool> isVisibleMinus;

  SmallScreenProductListRow({
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

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ProductDetailsPopup(
                  name: name,
                  ingredients: ingredients,
                  imageName: storage[index].image);
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.025, 5, 5, 0),
            child: ProductNetworkImage(
              size: MediaQuery.of(context).size.height * 0.075,
              imageName: storage[index].image))),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
              return ProductDetailsPopup(
              name: name,
              ingredients: ingredients,
              imageName: storage[index].image);
            });
          },
          child: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: AutoSizeText(name,
                            textAlign: TextAlign.start,
                            minFontSize: 10,
                            maxFontSize: 17,
                            maxLines: 1,
                            style: const TextStyle(
                                fontFamily: 'GloryBold',
                                fontSize:  20)))),
            Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: FittedBox(
                      child: Text("${storage[index].price.toStringAsFixed(2)} zł",
                          style: const TextStyle(
                              fontFamily: 'GloryLightItalic', fontSize: 15)))))])),
        Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, 0, 0, 0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.11,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: AppColors.mediumBlue),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: FittedBox(child: Text("${storage[index].number} ${AppLocalizations.of(context)!.pcs}",
                        style: const TextStyle(fontFamily: 'GloryMedium', fontSize: 15)))))),
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
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
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
                              child: const Center(
                                  child: FittedBox(
                                      child: Text("-",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30)))))))),
              Container(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.005, 0, 0),
                  child: Visibility(
                      visible: isVisiblePlus[index],
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
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
                              child: const Center(
                                  child: FittedBox(
                                      child: Text("+",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30))))))))])]);
  }
}