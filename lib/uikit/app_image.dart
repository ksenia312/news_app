import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.url,
    this.placeholder,
    this.imageHeight,
    this.imageWidth,
    this.radius = 10,
    this.color,
    this.colorBlendMode,
  });

  static Widget placeholderOf(
    BuildContext context, {
    double? height,
    double? width,
  }) =>
      Container(
        height: height,
        width: width,
        color: context.themeData.splashColor,
      );

  final double? imageHeight;
  final double? imageWidth;
  final String url;
  final Widget? placeholder;
  final double radius;
  final Color? color;
  final BlendMode? colorBlendMode;

  @override
  Widget build(BuildContext context) {
    final defaultPlaceholder = placeholderOf(
      context,
      height: imageHeight,
      width: imageWidth,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: url,
        width: imageWidth,
        height: imageHeight,
        alignment: Alignment.topCenter,
        fadeInCurve: Curves.easeInOutQuad,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: colorBlendMode,
        errorWidget: (_, __, ___) => placeholder ?? defaultPlaceholder,
        placeholder: (_, __) => placeholder ?? defaultPlaceholder,
      ),
    );
  }
}
