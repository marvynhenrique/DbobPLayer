class CatalogCategory {
  const CatalogCategory({
    required this.id,
    required this.name,
    required this.type,
  });

  final String id;
  final String name;
  final CatalogType type;

  factory CatalogCategory.fromJson(
    Map<String, dynamic> json,
    CatalogType type,
  ) {
    return CatalogCategory(
      id: json['category_id']?.toString() ?? '',
      name: json['category_name']?.toString() ?? 'Categoria',
      type: type,
    );
  }
}

enum CatalogType {
  live,
  movies,
  series,
}

extension CatalogTypeLabel on CatalogType {
  String get label {
    switch (this) {
      case CatalogType.live:
        return 'TV Ao Vivo';
      case CatalogType.movies:
        return 'Filmes';
      case CatalogType.series:
        return 'Séries';
    }
  }

  String get categoriesAction {
    switch (this) {
      case CatalogType.live:
        return 'get_live_categories';
      case CatalogType.movies:
        return 'get_vod_categories';
      case CatalogType.series:
        return 'get_series_categories';
    }
  }

  String get streamsAction {
    switch (this) {
      case CatalogType.live:
        return 'get_live_streams';
      case CatalogType.movies:
        return 'get_vod_streams';
      case CatalogType.series:
        return 'get_series';
    }
  }
}
