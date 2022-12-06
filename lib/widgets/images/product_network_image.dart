import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:provider/provider.dart';

class ProductNetworkImage extends StatelessWidget{
  final String imageName;
  final double size;

  const ProductNetworkImage({
    Key? key,
    required this.size,
    required this.imageName
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            border: Border.all(
                width: size/20,
                color: AppColors.beige),
            borderRadius: BorderRadius.circular(size/4)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(size/5),
            child: Image.network( ApiConstants.baseUrl + '/assets/${imageName}')));
  }

}
