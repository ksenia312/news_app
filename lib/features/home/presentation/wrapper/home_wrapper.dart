import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/models/source_entity.dart';
import 'package:news_app/di/setup_dependencies.dart';
import 'package:news_app/features/home/domain/news_cubit.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key, required this.child, required this.sources});

  final List<SourceEntity> sources;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NewsCubit>()..init(sources: sources),
      child: child,
    );
  }
}
