import 'package:flutter/material.dart';
import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/common/utils/hero_tags.dart';
import 'package:news_app/uikit/app_bar.dart';
import 'package:news_app/uikit/app_elevated_text_button.dart';
import 'package:news_app/uikit/app_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({
    super.key,
    required this.entity,
  });

  static const _imageHeight = 300.0;

  final ArticleEntity entity;

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 16);
    return Scaffold(
      appBar: const CustomAppBar(title: 'All articles'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle(context),
            spacer,
            _buildDescription(context),
            spacer,
            _buildImage(context),
            spacer,
            Align(
              alignment: Alignment.centerRight,
              child: _buildDate(context),
            ),
            spacer,
            _buildContent(context),
            spacer,
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      entity.title,
      style: context.textTheme.titleLarge,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      entity.description,
      style: context.textTheme.titleMedium,
    );
  }

  Widget _buildImage(BuildContext context) {
    final child = entity.imageUrl != null
        ? Hero(
            tag: AppHeroTags.articleImage.tagBy('${entity.id}'),
            child: AppImage(url: entity.imageUrl!),
          )
        : const SizedBox.shrink();

    return LimitedBox(
      maxHeight: _imageHeight,
      child: child,
    );
  }

  Widget _buildDate(BuildContext context) {
    return Text(
      entity.formattedDate,
      style: context.textTheme.bodyMedium,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Text(
      entity.content,
      style: context.textTheme.titleSmall,
    );
  }

  Widget _buildButton(BuildContext context) {
    return AppElevatedTextButton(
      onPressed: _onViewButtonPressed,
      value: 'View full article',
    );
  }

  Future<void> _onViewButtonPressed() async {
    try {
      await launchUrlString(entity.url, mode: LaunchMode.platformDefault);
    } catch (_) {}
  }
}
