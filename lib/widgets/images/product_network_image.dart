import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';

class ProductNetworkImage extends StatelessWidget {
  final String imageName;
  final double size;

  const ProductNetworkImage({Key? key, required this.size, required this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bucket = SupabaseManager.instance.clientGlobalDB.storage.from('Product_Images');
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(border: Border.all(width: size / 20, color: AppColors.beige), borderRadius: BorderRadius.circular(size / 4)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 5),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: bucket.getPublicUrl(imageName),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
