import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/widgets/images/product_network_image.dart';
import 'package:kiosk_flutter/widgets/lists/product_list_view.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../themes/color.dart';
import '../../widgets/buttons/category_buttons.dart';

class ProductDetailsPopup extends StatelessWidget{
  String name;
  String ingredients;
  String imageName;

  ProductDetailsPopup({
    Key? key,
    required this.name,
    required this.ingredients,
    required this.imageName
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            elevation: 6,
            surfaceTintColor: Colors.white,
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * 0.03, MediaQuery.of(context).size.width * 0.03, 0),
                    alignment: Alignment.topRight,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: MediaQuery.of(context).size.width * 0.06,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.red),
                            child: const Center(
                              child: FittedBox(
                              child: Text("X",
                                  textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15))))))),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.03, MediaQuery.of(context).size.height * 0.02, 0, 0),
                      child: ProductNetworkImage(
                        size: MediaQuery.of(context).size.width* 0.3,
                        imageName: imageName)),
                    Container(
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, MediaQuery.of(context).size.height * 0.05 , 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        AutoSizeText(name,
                          maxLines: 1,
                            style: const TextStyle(
                                fontFamily: 'GloryBold',
                                fontSize:  20)
                          ),
                        AutoSizeText(ingredients,
                          maxLines: 3,
                            style: const TextStyle(
                                fontFamily: 'GloryLightItalic', fontSize: 15)
                          )
                      ],
                    )))
                  ],
                )
              ],
            )
          )
        ));
  }


}
