import 'package:flutter/material.dart';

class AsyncState<T> {
  const AsyncState._({
    required this.inProgress,
    this.data,
    this.error,
  });

  factory AsyncState.nothing() => const AsyncState._(inProgress: false);

  factory AsyncState.data(T data) => AsyncState._(
        inProgress: false,
        data: data,
      );

  factory AsyncState.progress({T? lastData}) => AsyncState._(
        inProgress: true,
        data: lastData,
      );

  factory AsyncState.error({
    T? lastData,
    String? error,
  }) =>
      AsyncState._(
        inProgress: false,
        error: error ?? _defaultError,
        data: lastData,
      );

  static const _defaultError = 'Something went wrong';

  final T? data;

  final String? error;

  final bool inProgress;

  bool get hasData => data != null;

  bool get hasError => error != null;

  Widget buildWhen({
    required Widget Function(T? data) inProgress,
    required Widget Function(T data) onData,
    required Widget Function(T? data, String error) onError,
  }) {
    if (hasError) {
      return onError(data, error!);
    }
    if (hasData && !this.inProgress) {
      return onData(data as T);
    }
    return inProgress(data);
  }
}
