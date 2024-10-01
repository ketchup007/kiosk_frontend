import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/supabase/supabase_manager.dart';

class ProductNetworkImage extends StatefulWidget {
  final String? imageName;
  final double size;

  const ProductNetworkImage({Key? key, required this.size, required this.imageName}) : super(key: key);

  @override
  State<ProductNetworkImage> createState() => _ProductNetworkImageState();
}

class _ProductNetworkImageState extends State<ProductNetworkImage> {
  String? imagePublicUrl;

  @override
  void initState() {
    super.initState();
    if (widget.imageName != null) {
      imagePublicUrl = SupabaseManager.instance.clientGlobalDB.storage.from('images').getPublicUrl(widget.imageName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(border: Border.all(width: widget.size / 20, color: AppColors.beige), borderRadius: BorderRadius.circular(widget.size / 4)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size / 5),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imagePublicUrl ?? 'https://picsum.photos/200/300',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
