import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'book.dart';
import 'shen_image.dart';

class Chapter extends Equatable {
  const Chapter({
    required this.id,
    required this.name,
    required this.link,
    required this.source,
    this.chapterImages,
    this.chapterParagraphs,
  });

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source));

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      link: map['link'] ?? '',
      source: chapterSourceFromMap(map['source']),
      chapterImages: map['chapterImages'] != null
          ? List<ShenImage>.from(
              map['chapterImages']?.map((x) => ShenImage.fromMap(x)))
          : null,
      chapterParagraphs: List<String>.from(map['chapterParagraphs'] ?? []),
    );
  }

  final List<ShenImage>? chapterImages;
  final List<String>? chapterParagraphs;
  final String id;
  final String link;
  final String name;
  final ChapterSource source;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'source': source.toMap(),
      'chapterImages': chapterImages?.map((x) => x.toMap()).toList(),
      'chapterParagraphs': chapterParagraphs,
    };
  }

  static ChapterSource chapterSourceFromMap(String source) =>
      source == 'network' ? ChapterSource.network : ChapterSource.file;

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [id];

  bool hasContent(BookType type) => type == BookType.manga
      ? chapterImages?.isNotEmpty ?? false
      : chapterParagraphs?.isNotEmpty ?? false;

  int contentLength(BookType type) => type == BookType.manga
      ? chapterImages?.length ?? 0
      : chapterParagraphs?.length ?? 0;

  Chapter copyWith({
    List<ShenImage>? chapterImages,
    List<String>? chapterParagraphs,
    String? id,
    String? link,
    String? name,
    ChapterSource? source,
  }) {
    return Chapter(
      chapterImages: chapterImages ?? this.chapterImages,
      chapterParagraphs: chapterParagraphs ?? this.chapterParagraphs,
      id: id ?? this.id,
      link: link ?? this.link,
      name: name ?? this.name,
      source: source ?? this.source,
    );
  }

  @override
  String toString() {
    return 'Chapter(chapterImages: $chapterImages, chapterParagraphs: ${chapterParagraphs?.length}, id: $id, link: $link, name: $name, source: $source)';
  }
}

enum ChapterSource { network, file }

extension EnumSerialisation on ChapterSource {
  String toMap() => this == ChapterSource.network ? 'network' : 'file';
}
