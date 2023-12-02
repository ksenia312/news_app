import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/di/setup_dependencies.dart';
import 'package:news_app/features/news_sources/presentation/sources_state_builder.dart';
import 'package:news_app/features/news_sources/domain/news_sources_store.dart';
import 'package:news_app/features/uikit/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (context) {
        final themeMode = context.select<AppTheme, ThemeMode>(
          (theme) => theme.mode,
        );
        return MaterialApp(
          title: 'News App',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppThemeConfig.lightTheme,
          darkTheme: AppThemeConfig.darkTheme,
          home: const SourcesStateBuilder(),
        );
      },
    );
  }
}

class AppBuilder extends StatelessWidget {
  const AppBuilder({super.key, required this.builder});

  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<NewsSourcesStore>()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppTheme.initialized(),
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
