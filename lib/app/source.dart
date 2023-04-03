import 'dart:async';

import '../data/models/book.dart';
import '../data/models/chapter.dart';

abstract class BookSource {
  BookSource(this.name);

  final String name;

  Future<List<Book>> getHomePage();

  Future<List<Book>> search(String term);

  Future<Book> getBookDetails(Book book, {required List<String> fields});

  Future<Chapter> getBookChapterDetails(Chapter chapter);
}

extension Iterator<T> on List<T> {
  void iterate(Function(T element, int index) iterator) {
    for (int i = 0; i < length; i++) {
      iterator(this[i], i);
    }
  }
}
