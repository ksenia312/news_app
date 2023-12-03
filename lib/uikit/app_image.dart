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
  });

  static Widget placeholderOf(
    BuildContext context, {
    double? height,
    double? width,
  }) =>
      Container(
        height: height,
        width: width,
        color: context.colorScheme.secondary,
      );

  final double? imageHeight;
  final double? imageWidth;
  final String url;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final defaultPlaceholder = placeholderOf(
      context,
      height: imageHeight,
      width: imageWidth,
    );
    return CachedNetworkImage(
      imageUrl: url,
      width: imageWidth,
      height: imageHeight,
      alignment: Alignment.topCenter,
      fadeInCurve: Curves.easeInOutQuad,
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) => placeholder ?? defaultPlaceholder,
      placeholder: (_, __) => placeholder ?? defaultPlaceholder,
    );
  }
}
