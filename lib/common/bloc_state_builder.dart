import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/models/async_state.dart';

abstract class BlocIterableStateBuilder<B extends BlocBase<S>, S, Entity>
    extends StatelessWidget {
  const BlocIterableStateBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        return asyncStateInjector(state)?.buildWhen(
              inProgress: progressBuilder,
              onData: dataBuilder,
              onError: errorBuilder,
            ) ??
            progressBuilder();
      },
    );
  }

  AsyncState<Iterable<Entity>>? asyncStateInjector(S state);

  Widget progressBuilder([
    Iterable<Entity>? lastData,
  ]);

  Widget errorBuilder(
    Iterable<Entity>? lastData,
    String error,
  );

  Widget dataBuilder(
    Iterable<Entity> data,
  );
}
