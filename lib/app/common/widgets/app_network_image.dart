import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/asset_resource.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;

  // optionals
  final bool viewFullImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.viewFullImage = true,
    this.height,
    this.fit,
    this.borderRadius,
  });

  Widget _assetPlacholderImage(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      child: SvgPicture.asset(
        AppUtils.isDarkMode(context)
            ? AssetResource.image_placeholder_dark_svg
            : AssetResource.image_placeholder_light_svg,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (_, _) => _assetPlacholderImage(context),
        errorWidget: (_, _, _) => _assetPlacholderImage(context),
      ),
    );
  }
}
