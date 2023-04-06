import 'dart:async';

class StreamedValue<T> {
  StreamedValue({required T initialValue})
      : _state = initialValue,
        _streamController = StreamController<T>.broadcast()..add(initialValue);

  late T _state;
  final StreamController<T> _streamController;

  T get value => _state;

  Stream<T> get stream => _streamController.stream;

  StreamController<T> get streamController => _streamController;

  update(T newState, {String? tag, String Function(T state)? message}) =>
      _emit(newState, tag, message);

  mutate(void Function(T state) mutate,
      {String? tag, String Function(T state)? message}) {
    mutate(_state);
    _streamController.add(_state);
    // LogUtil.devLog(
    //   tag ?? "StreamedValue<$T>.mutate()",
    //   message: message?.call(_state) ?? "Mutating state",
    // );
  }

  void dispose() {
    _streamController.close();
  }

  void _emit(T newState, [String? tag, String Function(T state)? message]) {
    _state = newState;
    _streamController.add(newState);
    // LogUtil.devLog(
    //   tag ?? "StreamedValue<$T>.update()",
    //   message: message?.call(_state) ?? "Updating state",
    // );
  }
}
