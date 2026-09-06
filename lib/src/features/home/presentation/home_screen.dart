import 'package:flutter/material.dart';

import '../../../models/catalog_category.dart';
import '../../../models/session_data.dart';
import '../../../repositories/catalog_repository.dart';
import '../../../services/session_storage.dart';
import '../../../shared/widgets/dbob_logo.dart';
import '../../../shared/widgets/section_title.dart';
import '../../auth/presentation/connection_method_screen.dart';
import '../../catalog/presentation/catalog_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _sessionStorage = SessionStorage();
  final _catalogRepository = CatalogRepository();

  late Future<_HomeData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_HomeData> _load() async {
    final session = await _sessionStorage.load();

    if (session == null) {
      return const _HomeData.empty();
    }

    final results = await Future.wait([
      _catalogRepository.getCategories(CatalogType.live),
      _catalogRepository.getCategories(CatalogType.movies),
      _catalogRepository.getCategories(CatalogType.series),
    ]);

    return _HomeData(
      session: session,
      liveCategories: results[0],
      movieCategories: results[1],
      seriesCategories: results[2],
    );
  }

  Future<void> _logout() async {
    await _sessionStorage.clear();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      ConnectionMethodScreen.routeName,
      (_) => false,
    );
  }

  void _refresh() {
    setState(() {
      _future = _load();
    });
  }

  void _openCatalog(CatalogType type) {
    Navigator.of(context).pushNamed(
      CatalogScreen.routeName,
      arguments: type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DBobLogo(size: 24),
        actions: [
          IconButton(
            tooltip: 'Atualizar catálogo',
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: 'Configurações',
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            tooltip: 'Sair',
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<_HomeData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _ErrorState(
              message: 'Não foi possível carregar o catálogo.',
              onRetry: _refresh,
            );
          }

          final data = snapshot.data;

          if (data == null || data.session == null) {
            return _ErrorState(
              message: 'Sessão não encontrada. Faça login novamente.',
              onRetry: _logout,
            );
          }

          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conta conectada',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text('Status: ${data.session!.status}'),
                      Text('Modo: ${data.session!.mode}'),
                      if (data.session!.maxConnections != null)
                        Text('Conexões: ${data.session!.maxConnections}'),
                    ],
                  ),
                ),
              ),
              const SectionTitle('Catálogo'),
              _CatalogCard(
                title: 'TV Ao Vivo',
                subtitle: '${data.liveCategories.length} categorias',
                icon: Icons.live_tv,
                onTap: () => _openCatalog(CatalogType.live),
              ),
              _CatalogCard(
                title: 'Filmes',
                subtitle: '${data.movieCategories.length} categorias',
                icon: Icons.movie_outlined,
                onTap: () => _openCatalog(CatalogType.movies),
              ),
              _CatalogCard(
                title: 'Séries',
                subtitle: '${data.seriesCategories.length} categorias',
                icon: Icons.video_library_outlined,
                onTap: () => _openCatalog(CatalogType.series),
              ),
              const SectionTitle('Próximos módulos'),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.play_circle_outline),
                  title: Text('Player'),
                  subtitle: Text('Será conectado na Sprint 03/04.'),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Favoritos e histórico'),
                  subtitle: Text('Entram depois do player.'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CatalogCard extends StatelessWidget {
  const _CatalogCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 34),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
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
            Text(message, textAlign: TextAlign.center),
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

class _HomeData {
  const _HomeData({
    required this.session,
    required this.liveCategories,
    required this.movieCategories,
    required this.seriesCategories,
  });

  const _HomeData.empty()
      : session = null,
        liveCategories = const [],
        movieCategories = const [],
        seriesCategories = const [];

  final SessionData? session;
  final List<CatalogCategory> liveCategories;
  final List<CatalogCategory> movieCategories;
  final List<CatalogCategory> seriesCategories;
}
