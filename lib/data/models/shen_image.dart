import 'dart:convert';

class ShenImage {
  const ShenImage(this.url, [this.source = ImageSource.network]);

  factory ShenImage.fromJson(String source) =>
      ShenImage.fromMap(json.decode(source));

  factory ShenImage.fromMap(Map<String, dynamic> map) {
    return ShenImage(
      map['url'] ?? '',
      imageSourceFromMap(map['source']),
    );
  }

  final ImageSource source;
  final String url;

  Map<String, dynamic> toMap() {
    return {
      'source': source.toMap(),
      'url': url,
    };
  }

  static ImageSource imageSourceFromMap(String source) => source == 'network'
      ? ImageSource.network
      : source == 'asset'
          ? ImageSource.asset
          : ImageSource.file;

  String toJson() => json.encode(toMap());

  ShenImage copyWith({
    ImageSource? source,
    String? url,
  }) {
    return ShenImage(
      url ?? this.url,
      source ?? this.source,
    );
  }
}

enum ImageSource { network, asset, file }

extension EnumSerialisation on ImageSource {
  String toMap() => this == ImageSource.network
      ? 'network'
      : this == ImageSource.asset
          ? 'asset'
          : 'file';
}
