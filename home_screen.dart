import 'package:flutter/material.dart';

import '../../../shared/widgets/dbob_logo.dart';
import '../../../shared/widgets/section_title.dart';
import '../../settings/presentation/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final items = [
      ('TV Ao Vivo', Icons.live_tv),
      ('Filmes', Icons.movie_outlined),
      ('Séries', Icons.video_library_outlined),
      ('Favoritos', Icons.star_border),
      ('Downloads', Icons.download_outlined),
      ('Configurações', Icons.settings_outlined),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const DBobLogo(size: 24),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            child: Container(
              height: 160,
              padding: const EdgeInsets.all(22),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Streaming organizado, rápido e com identidade DBob.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ),
          const SectionTitle('Continuar assistindo'),
          const _ProgressDemoCard(),
          const SectionTitle('Biblioteca'),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 230,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.$1} entra na Sprint 02.')),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.$2, size: 36),
                      const SizedBox(height: 8),
                      Text(
                        item.$1,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProgressDemoCard extends StatelessWidget {
  const _ProgressDemoCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.play_circle_outline, size: 38),
        title: const Text('Nenhum conteúdo iniciado ainda'),
        subtitle: const Text('O checkpoint será implementado no player.'),
        trailing: SizedBox(
          width: 80,
          child: LinearProgressIndicator(
            value: 0,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
