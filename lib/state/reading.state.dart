import 'package:flutter/material.dart';

import '../app/streamed_value.dart';
import '../data/models/book.dart';

class ReadingState {
  static StreamedValue<Book?> state = StreamedValue<Book?>(initialValue: null);
  static StreamedValue<String?> chapterIdState =
      StreamedValue<String?>(initialValue: null);
  static ScrollController scrollController = ScrollController();
}
