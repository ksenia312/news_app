import 'package:flutter/material.dart';
import 'package:news_app/uikit/app_icon_button.dart';
import 'package:provider/provider.dart';

import '../domain/app_theme_model.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeModel>(
      builder: (context, appTheme, _) {
        return AppIconButton(
          icon: Icon(
            appTheme.isLight ? Icons.nightlight_outlined : Icons.nightlight,
          ),
          onPressed: appTheme.toggle,
        );
      },
    );
  }
}
