import 'package:flopio/app/streamed_value.dart';

import '../data/models/book.dart';

class BookState {
  static StreamedValue<Book?> state = StreamedValue<Book?>(initialValue: null);
}
