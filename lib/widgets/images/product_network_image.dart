import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/themes/color.dart';

class ProductNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  const ProductNetworkImage({Key? key, required this.size, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(border: Border.all(width: size / 20, color: AppColors.beige), borderRadius: BorderRadius.circular(size / 4)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 5),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
