import 'dart:async';

class IterableToStreamConverter {
  const IterableToStreamConverter();

  Stream<T> convert<T extends Object?>(Iterable<T> iterable) async* {
    final stopwatch = Stopwatch()..start();
    final iterator = iterable.iterator;
    while (iterator.moveNext()) {
      if (stopwatch.elapsedMilliseconds > 8) {
        await Future<void>.delayed(Duration.zero);
        stopwatch.reset();
      }
      yield iterator.current;
    }
    stopwatch.stop();
  }
}

extension IterableToStreamConverterX<T extends Object?> on Iterable<T> {
  Stream<T> convert() => const IterableToStreamConverter().convert<T>(this);
}
