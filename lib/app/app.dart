import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/di/setup_dependencies.dart';
import 'package:news_app/features/news_sources/presentation/sources_state_builder.dart';
import 'package:news_app/features/news_sources/domain/news_sources_store.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NewsSourcesStore>()..init(),
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        ),
        home: const SourcesStateBuilder(),
      ),
    );
  }
}
