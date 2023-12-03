import 'dart:math';

class AppRandom {
  final random = Random();

  int getInt({int start = 0, int end = 100000}) {
    assert(start < end, 'Start value should be less than end value');
    return random.nextInt(end - start) + start;
  }
}
