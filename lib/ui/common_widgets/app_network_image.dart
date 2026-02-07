import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;

  // optionals
  final bool viewFullImage;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.viewFullImage = true,
    this.height,
    this.fit,
  });

  Widget _assetPlacholderImage() {
    return Icon(Icons.image_not_supported_rounded, size: width);
    // return Image.asset(
    //   ImageResource.INV_PLACEHOLDER,
    //   width: width,
    //   height: height,
    //   fit: fit ?? BoxFit.contain,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      placeholder: (_, __) => _assetPlacholderImage(),
      errorWidget: (_, __, ___) => _assetPlacholderImage(),
    );
  }
}
