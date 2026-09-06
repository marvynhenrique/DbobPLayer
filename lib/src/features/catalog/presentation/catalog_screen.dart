import 'package:flutter/material.dart';

import '../../../models/catalog_category.dart';
import '../../../models/content_item.dart';
import '../../../repositories/catalog_repository.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  static const routeName = '/catalog';

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _catalogRepository = CatalogRepository();

  CatalogType? _type;
  CatalogCategory? _selectedCategory;
  late Future<_CatalogData> _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (_type == null && args is CatalogType) {
      _type = args;
      _future = _load(args);
    }
  }

  Future<_CatalogData> _load(CatalogType type, {String? categoryId}) async {
    final categories = await _catalogRepository.getCategories(type);
    final content = await _catalogRepository.getContent(
      type,
      categoryId: categoryId,
    );

    return _CatalogData(categories: categories, content: content);
  }

  void _selectCategory(CatalogCategory category) {
    setState(() {
      _selectedCategory = category;
      _future = _load(category.type, categoryId: category.id);
    });
  }

  void _clearCategory() {
    final type = _type;
    if (type == null) return;

    setState(() {
      _selectedCategory = null;
      _future = _load(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final type = _type;

    if (type == null) {
      return const Scaffold(
        body: Center(child: Text('Tipo de catálogo não informado.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(type.label),
        actions: [
          if (_selectedCategory != null)
            TextButton(
              onPressed: _clearCategory,
              child: const Text('Todas'),
            ),
        ],
      ),
      body: FutureBuilder<_CatalogData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _ErrorCatalogState(
              onRetry: () {
                setState(() {
                  _future = _load(type, categoryId: _selectedCategory?.id);
                });
              },
            );
          }

          final data = snapshot.data ?? const _CatalogData.empty();

          return Column(
            children: [
              SizedBox(
                height: 56,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = data.categories[index];
                    final selected = category.id == _selectedCategory?.id;

                    return ChoiceChip(
                      label: Text(category.name),
                      selected: selected,
                      onSelected: (_) => _selectCategory(category),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: data.categories.length,
                ),
              ),
              Expanded(
                child: data.content.isEmpty
                    ? const Center(child: Text('Nenhum conteúdo encontrado.'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(14),
                        itemCount: data.content.length,
                        itemBuilder: (context, index) {
                          final item = data.content[index];

                          return Card(
                            child: ListTile(
                              leading: _ContentImage(url: item.imageUrl),
                              title: Text(item.name),
                              subtitle: Text(item.id.isEmpty
                                  ? type.label
                                  : '${type.label} • ID ${item.id}'),
                              trailing: const Icon(Icons.play_arrow),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Player será conectado na próxima sprint.',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ContentImage extends StatelessWidget {
  const _ContentImage({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final validUrl = url != null &&
        (url!.startsWith('http://') || url!.startsWith('https://'));

    if (!validUrl) {
      return const SizedBox(
        width: 48,
        height: 48,
        child: Icon(Icons.movie_outlined),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url!,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox(
          width: 48,
          height: 48,
          child: Icon(Icons.movie_outlined),
        ),
      ),
    );
  }
}

class _ErrorCatalogState extends StatelessWidget {
  const _ErrorCatalogState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 54),
            const SizedBox(height: 14),
            const Text(
              'Não foi possível carregar este catálogo.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('TENTAR NOVAMENTE'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CatalogData {
  const _CatalogData({
    required this.categories,
    required this.content,
  });

  const _CatalogData.empty()
      : categories = const [],
        content = const [];

  final List<CatalogCategory> categories;
  final List<ContentItem> content;
}
