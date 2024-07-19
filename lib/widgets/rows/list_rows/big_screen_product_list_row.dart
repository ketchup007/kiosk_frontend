import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/menus/munchie_product.dart';

import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/images/product_network_image.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';

class BigScreenProductListRow extends StatefulWidget {
  final MunchieProduct product;
  final bool isVisiblePlus;
  final bool isVisibleMinus;

  const BigScreenProductListRow({
    super.key,
    required this.product,
    required this.isVisiblePlus,
    required this.isVisibleMinus,
  });

  @override
  State<BigScreenProductListRow> createState() => _BigScreenProductListRowState();
}

class _BigScreenProductListRowState extends State<BigScreenProductListRow> {
  bool minusButtonActionPerformed = false;
  bool plusButtonActionPerformed = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    void plusButtonAction() {
      int productCount = provider.getProductInOrderCount(widget.product.productId);
      if (productCount < provider.limits[widget.product.productId]!) {
        provider.addProductToOrder(widget.product.productId);
      }
    }

    void minusButtonAction() {
      int productCount = provider.getProductInOrderCount(widget.product.productId);
      if (productCount > 0) {
        provider.removeProductToOrder(widget.product.productId);
      }
    }

    int productCount = provider.getProductInOrderCount(widget.product.productId);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.025, 5, 5, 0),
            child: ProductNetworkImage(
              size: MediaQuery.of(context).size.width * 0.12,
              imageUrl: widget.product.image,
            )),
        Container(
          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.008, 5, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.06,
                  child: FittedBox(
                    child: Text(
                      widget.product.name,
                      textAlign: TextAlign.start,
                      textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                      style: const TextStyle(
                        fontFamily: 'GloryBold',
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: AutoSizeText(
                    widget.product.ingredientNamesAsString,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontFamily: 'GloryLightItalic',
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.017, 5, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
            child: FittedBox(
              child: Text(
                "${widget.product.price.toStringAsFixed(2)} zł",
                style: const TextStyle(
                  fontFamily: 'GloryLightItalic',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.015, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.07,
            decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.mediumBlue), borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: FittedBox(
                child: Text(
                  "$productCount ${AppText.current!.pcs}",
                  style: const TextStyle(
                    fontFamily: 'GloryMedium',
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
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
                    visible: widget.isVisibleMinus,
                    maintainState: true,
                    maintainSize: true,
                    maintainAnimation: true,
                    child: InkWell(
                      onTapDown: (_) {
                        minusButtonAction();
                        minusButtonActionPerformed = true;
                      },
                      onTapCancel: () {
                        minusButtonActionPerformed = false;
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: MediaQuery.of(context).size.width * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            if (minusButtonActionPerformed) {
                              minusButtonActionPerformed = false;
                            } else {
                              minusButtonAction();
                            }
                          },
                          style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: AppColors.red),
                          child: const Text(
                            "-",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.005, 0, 0),
                    child: Visibility(
                        visible: widget.isVisiblePlus,
                        maintainState: true,
                        maintainSize: true,
                        maintainAnimation: true,
                        child: InkWell(
                          onTapDown: (_) {
                            plusButtonAction();
                            plusButtonActionPerformed = true;
                          },
                          onTapCancel: () {
                            plusButtonActionPerformed = false;
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                            height: MediaQuery.of(context).size.width * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                if (plusButtonActionPerformed) {
                                  plusButtonActionPerformed = false;
                                } else {
                                  plusButtonAction();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.mediumBlue,
                              ),
                              child: const Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        )))
              ],
            ),
            Text(
              "${(widget.product.price * productCount).toStringAsFixed(2)} zł",
              style: const TextStyle(
                fontFamily: "GloryMedium",
                fontSize: 20,
              ),
            )
          ],
        )
      ],
    );

    // Your build method implementation...
    // Use widget.name, widget.ingredients, etc. to access the properties.
  }
}

// class BigScreenProductListRow extends StatelessWidget{
//   String name;
//   String ingredients;
//   List<StorageModel> storage;
//   int index;
//   List<bool> isVisiblePlus;
//   List<bool> isVisibleMinus;
//   bool minusButtonActionPerformed = false;
//
//   BigScreenProductListRow({
//     Key? key,
//     required this.name,
//     required this.ingredients,
//     required this.storage,
//     required this.index,
//     required this.isVisiblePlus,
//     required this.isVisibleMinus
//   }) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<MainProvider>(context, listen: true);
//
//     void plusButtonAction() {
//       if (storage[index].number < provider.limits[storage[index].orderName]!) {
//         storage[index].number++;
//         if (provider.order.id == 0) {provider.getFirstOrder(
//             storage[index].orderName,
//             storage[index].number);
//         } else {
//           provider.changeOrder(storage[index].orderName, storage[index].number);
//         }
//         provider.getSum();
//       }
//     }
//
//     void minusButtonAction() {
//       if (storage[index].number > 0) {
//         storage[index].number--;
//         if (provider.order.id == 0) {
//           provider.getFirstOrder(storage[index].orderName, storage[index].number);
//         } else {
//           provider.changeOrder(storage[index].orderName, storage[index].number);
//         }
//         provider.getSum();
//       }
//     }
//
//     return Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               padding: EdgeInsets.fromLTRB(
//                   MediaQuery.of(context).size.width * 0.025, 5, 5, 0),
//               child: ProductNetworkImage(
//                 size: MediaQuery.of(context).size.width * 0.12,
//                 imageName: storage[index].image,
//               )),
//           Container(
//               padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.008, 5, 0),
//               child: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.4,
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                             height: MediaQuery.of(context).size.width*0.06,
//                             child: FittedBox(
//                                 child:Text(name,
//                                   textAlign: TextAlign.start,
//                                   textHeightBehavior: const TextHeightBehavior(
//                                     applyHeightToFirstAscent: false),
//                                   style: const TextStyle(
//                                       fontFamily: 'GloryBold',
//                                       fontSize: 25)))),
//                         SizedBox(height: MediaQuery.of(context).size.width*0.04,
//                             child:
//                             AutoSizeText(ingredients,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.clip,
//                                 style: const TextStyle(
//                                     fontFamily: 'GloryLightItalic', fontSize: 15)))]))),
//           Container(
//               padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.017, 5, 0),
//               child: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.05,
//                   child: FittedBox(
//                       child: Text("${storage[index].price.toStringAsFixed(2)} zł",
//                           style: const TextStyle(
//                               fontFamily: 'GloryLightItalic', fontSize: 15))))),
//           Container(
//               padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.015, 0, 0),
//               child: Container(
//                   width: MediaQuery.of(context).size.width * 0.07,
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                           width: 2,
//                           color: AppColors.mediumBlue),
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Center(
//                       child: FittedBox(child: Text("${storage[index].number} ${AppText.current!.pcs}",
//                           style: const TextStyle(fontFamily: 'GloryMedium', fontSize: 15)))))),
//           Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                           padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.005, 0, 0),
//                           child: Visibility(
//                               visible: isVisibleMinus[index],
//                               maintainState: true,
//                               maintainSize: true,
//                               maintainAnimation: true,
//                               child: InkWell(
//                                 onTapDown: (_) {
//                                   print("tap-DOWN ${minusButtonActionPerformed}");
//
//                                   minusButtonAction();
//                                   minusButtonActionPerformed = true;
//                                 },
//                                 onTapCancel: () {
//                                   print("onTap_Cancel ${minusButtonActionPerformed}");
//                                   minusButtonActionPerformed = false;
//                                 },
//                                 onTapUp: (_) {
//                                   print("tap-UP");
//                                 },
//                                 child: SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.06,
//                                     height: MediaQuery.of(context).size.width * 0.06,
//                                     child: ElevatedButton(
//                                         onPressed: () {
//                                           print("click ${minusButtonActionPerformed}");
//                                           if(minusButtonActionPerformed){
//                                             minusButtonAction();
//                                           }else{
//                                             minusButtonActionPerformed = false;
//                                           }
//
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                             shape: const CircleBorder(),
//                                             backgroundColor: AppColors.red),
//                                         child: const Text("-",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 30)))),
//                               ))),
//                       Container(
//                           padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.005, 0, 0),
//                           child: Visibility(
//                               visible: isVisiblePlus[index],
//                               maintainState: true,
//                               maintainSize: true,
//                               maintainAnimation: true,
//                               child: InkWell(
//                                 onTapDown: (_) {
//                                   plusButtonAction();
//                                 },
//                                 child: SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.06,
//                                     height: MediaQuery.of(context).size.width * 0.06,
//                                     child: ElevatedButton(
//                                         onPressed: () {
//                                           plusButtonAction();
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                             shape: const CircleBorder(),
//                                             backgroundColor: AppColors.mediumBlue),
//                                         child: const Text("+",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 30)))),
//                               )))]),
//                 Text("${(storage[index].price * storage[index].number).toStringAsFixed(2)} zł",
//                     style: const TextStyle(
//                         fontFamily: "GloryMedium",
//                         fontSize: 20))])]);
//   }
// }