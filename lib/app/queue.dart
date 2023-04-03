class Queue<T> {
  Queue({Iterable<T>? items}) : _items = items?.toList() ?? [];

  bool busy = false;

  final List<T> _items;

  T? get next => _items.isNotEmpty ? _items.removeAt(0) : null;

  void enqueue(T item) => _items.add(item);

  void reserve() => busy = true;

  void release() => busy = false;
}
