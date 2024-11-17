import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

mixin BaseLoadingCard {
  Widget buildContainer(
    BuildContext context, {
    double? height,
    double? width,
    BorderRadiusGeometry? borderRadius,
    Color color = const Color(0xffFFFFFF),
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        color: color,
      ),
    );
  }

  Widget buildShimmer(
    BuildContext context,
    Widget child, {
    double opacity = 0.6,
    Color color = const Color(0xffFFFFFF),
  }) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: color.withOpacity(opacity),
      highlightColor: color,
      child: child,
    );
  }
}
