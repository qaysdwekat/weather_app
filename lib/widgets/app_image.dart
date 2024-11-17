import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final String? package;
  final String? placeholder;
  final Widget? placeholderWidget;

  const AppImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.package,
    this.placeholder,
    this.placeholderWidget,
  });

  @override
  Widget build(BuildContext context) {
    var isSvgImage = imageUrl.split('.').last == 'svg';

    if (imageUrl.isEmpty) {
      return placeholderWidget ?? ((placeholder != null) ? loadLocalAsset(placeholder!) : const SizedBox());
    }

    if (!imageUrl.contains('http')) {
      return loadLocalAsset(imageUrl);
    }

    if (isSvgImage) {
      return SvgPicture.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: color,
      );
    }

    return ExtendedImage.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.loading:
          case LoadState.failed:
            return placeholderWidget ?? ((placeholder != null) ? loadLocalAsset(placeholder!) : const SizedBox());
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget loadLocalAsset(String imageUrl) {
    var isSvgImage = imageUrl.split('.').last == 'svg';

    if (isSvgImage) {
      return SvgPicture.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: color,
        package: package,
      );
    }
    if (Platform.isAndroid) {
      final file = File(imageUrl);
      if (file.existsSync()) {
        return Image.file(
          File(imageUrl),
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
      }
    }

    if (imageUrl.startsWith('assets')) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        package: package,
      );
    }
    return placeholderWidget ?? ((placeholder != null) ? loadLocalAsset(placeholder!) : const SizedBox());
  }
}
