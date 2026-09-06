import 'catalog_category.dart';

class ContentItem {
  const ContentItem({
    required this.id,
    required this.name,
    required this.type,
    this.categoryId,
    this.imageUrl,
  });

  final String id;
  final String name;
  final CatalogType type;
  final String? categoryId;
  final String? imageUrl;

  factory ContentItem.fromJson(Map<String, dynamic> json, CatalogType type) {
    late final String id;

    switch (type) {
      case CatalogType.live:
      case CatalogType.movies:
        id = json['stream_id']?.toString() ?? '';
        break;
      case CatalogType.series:
        id = json['series_id']?.toString() ?? '';
        break;
    }

    final image = json['stream_icon'] ??
        json['cover'] ??
        json['movie_image'] ??
        json['youtube_trailer'];

    return ContentItem(
      id: id,
      name: json['name']?.toString() ?? 'Sem título',
      type: type,
      categoryId: json['category_id']?.toString(),
      imageUrl: image?.toString(),
    );
  }
}
