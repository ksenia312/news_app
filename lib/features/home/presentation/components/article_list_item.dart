import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/common/context_extension.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({super.key, required this.entity});

  static const imageSize = 200.0;

  final ArticleEntity entity;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      height: imageSize,
      color: context.colorScheme.secondary,
    );
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      color: Colors.black,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            entity.imageUrl != null
                ? Opacity(
                    opacity: 0.5,
                    child: CachedNetworkImage(
                      imageUrl: entity.imageUrl!,
                      width: double.maxFinite,
                      height: imageSize,
                      alignment: Alignment.topCenter,
                      fadeInCurve: Curves.easeInOutQuad,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => placeholder,
                      placeholder: (_, __) => placeholder,
                    ),
                  )
                : placeholder,
            Center(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      entity.title,
                      style:context.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      entity.publishedAt != null
                          ? DateFormat(DateFormat.YEAR_MONTH_DAY)
                              .format(entity.publishedAt!)
                          : 'No date',
                      style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
