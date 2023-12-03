import 'package:flutter/material.dart';
import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/common/utils/hero_tags.dart';
import 'package:news_app/features/article/presentation/article_screen.dart';
import 'package:news_app/uikit/app_image.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({super.key, required this.entity});

  static const _imageHeight = 210.0;
  static const _imageWidth = double.maxFinite;
  static const _radius = BorderRadius.all(Radius.circular(10));

  final ArticleEntity entity;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: _radius,
      elevation: 2,
      color: Colors.black,
      child: InkWell(
        borderRadius: _radius,
        onTap: () => _onTap(context),
        child: ClipRRect(
          borderRadius: _radius,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildImage(context),
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
                      _buildTitle(context),
                      const SizedBox(height: 16),
                      _buildSubtitle(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    context.navigator.push(
      MaterialPageRoute(
        builder: (context) => ArticleScreen(entity: entity),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return entity.imageUrl != null
        ? Hero(
            tag: AppHeroTags.articleImage.tagBy('${entity.id}'),
            child: Opacity(
              opacity: 0.5,
              child: AppImage(
                url: entity.imageUrl!,
                imageHeight: _imageHeight,
                imageWidth: _imageWidth,
              ),
            ),
          )
        : AppImage.placeholderOf(
            context,
            width: _imageWidth,
            height: _imageHeight,
          );
  }

  Widget _buildTitle(BuildContext context) {
    return Hero(
      tag: AppHeroTags.articleTitle.tagBy('${entity.id}'),
      child: Text(
        entity.title,
        style: context.textTheme.titleLarge?.copyWith(
          color: Colors.white,
        ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      entity.formattedDate,
      style: context.textTheme.bodyMedium?.copyWith(
        color: Colors.white,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
