import 'dart:async';

import 'package:equatable/equatable.dart';

import '../data/models/book.dart';
import '../data/models/chapter.dart';

abstract class BookSource extends Equatable {
  const BookSource(this.name);

  final String name;

  String get domain;

  Future<List<Book>> getHomePage();

  Future<List<Book>> search(String term);

  Future<Book> getBookDetails(Book book, {required List<String> fields});

  Future<Chapter> getBookChapterDetails(Chapter chapter);

  @override
  List<Object> get props => [name];
}

extension Iterator<T> on List<T> {
  void iterate(Function(T element, int index) iterator) {
    for (int i = 0; i < length; i++) {
      iterator(this[i], i);
    }
  }
}
