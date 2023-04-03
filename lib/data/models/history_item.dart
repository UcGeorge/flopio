import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookHistoryItem extends Equatable {
  const BookHistoryItem({
    required this.bookId,
    required this.lastReadChapterId,
    required this.chapterHistory,
  });

  factory BookHistoryItem.fromJson(String source) =>
      BookHistoryItem.fromMap(json.decode(source));

  factory BookHistoryItem.fromMap(Map<String, dynamic> map) {
    return BookHistoryItem(
      bookId: map['bookId'] ?? '',
      lastReadChapterId: map['lastReadChapterId'] ?? '',
      chapterHistory: Map<String, dynamic>.from(map['chapterHistory']).map(
          (key, value) => MapEntry(key, ChapterHistoryItem.fromMap(value))),
    );
  }

  final String bookId;
  final Map<String, ChapterHistoryItem> chapterHistory;
  final String lastReadChapterId;

  @override
  List<Object> get props => [bookId];

  @override
  String toString() =>
      'BookHistoryItem(bookId: $bookId, lastReadChapterId: $lastReadChapterId, chapterHistory: $chapterHistory)';

  BookHistoryItem copyWith({
    String? bookId,
    String? lastReadChapterId,
    Map<String, ChapterHistoryItem>? chapterHistory,
  }) {
    return BookHistoryItem(
      bookId: bookId ?? this.bookId,
      lastReadChapterId: lastReadChapterId ?? this.lastReadChapterId,
      chapterHistory: chapterHistory ?? this.chapterHistory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'lastReadChapterId': lastReadChapterId,
      'chapterHistory':
          chapterHistory.map((key, value) => MapEntry(key, value.toMap())),
    };
  }

  String toJson() => json.encode(toMap());
}

class ChapterHistoryItem extends Equatable {
  const ChapterHistoryItem({
    required this.chapterId,
    required this.position,
    required this.pageNumber,
  });

  factory ChapterHistoryItem.fromJson(String source) =>
      ChapterHistoryItem.fromMap(json.decode(source));

  factory ChapterHistoryItem.fromMap(Map<String, dynamic> map) {
    return ChapterHistoryItem(
      chapterId: map['chapterId'] ?? '',
      position: map['position']?.toDouble() ?? 0.0,
      pageNumber: map['pageNumber']?.toInt() ?? 0,
    );
  }

  final String chapterId;
  final int pageNumber;
  final double position;

  @override
  List<Object> get props => [chapterId];

  @override
  String toString() =>
      'ChapterHistoryItem(chapterId: $chapterId, position: $position, pageNumber: $pageNumber)';

  ChapterHistoryItem copyWith({
    String? chapterId,
    double? position,
    int? pageNumber,
  }) {
    return ChapterHistoryItem(
      chapterId: chapterId ?? this.chapterId,
      position: position ?? this.position,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chapterId': chapterId,
      'position': position,
      'pageNumber': pageNumber,
    };
  }

  String toJson() => json.encode(toMap());
}
