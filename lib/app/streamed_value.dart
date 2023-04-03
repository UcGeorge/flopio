import 'dart:async';

class StreamedValue<T> {
  StreamedValue({T? initialValue})
      : _state = initialValue,
        _streamController = StreamController<T?>.broadcast()..add(initialValue);

  late T? _state;
  final StreamController<T?> _streamController;

  T? get value => _state;

  Stream<T?> get stream => _streamController.stream;

  StreamController<T?> get streamController => _streamController;

  update(T? newState) => _emit(newState);

  void _emit(T? newState) {
    _state = newState;
    _streamController.add(newState);
  }

  void dispose() {
    _streamController.close();
  }
}