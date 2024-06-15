import 'package:rxdart/rxdart.dart';

class MemoryStorage<T> {
  final _data = BehaviorSubject<T?>.seeded(null);

  Stream<T?> watch() => _data.stream;

  T? get() => _data.valueOrNull;

  void set(T value) => _data.add(value);

  void clear() => _data.add(null);
}
