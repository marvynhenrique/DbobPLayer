import 'package:flutter/material.dart';

import '../../../models/session_data.dart';
import '../../../services/server_config_service.dart';
import '../../../services/session_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _sessionStorage = SessionStorage();
  final _serverConfigService = ServerConfigService();

  late Future<_SettingsData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_SettingsData> _load() async {
    final session = await _sessionStorage.load();
    final servers = await _serverConfigService.loadServers();

    return _SettingsData(
      session: session,
      activeServersCount: servers.length,
    );
  }

  Future<void> _clearSession() async {
    await _sessionStorage.clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sessão removida.')),
    );
    setState(() {
      _future = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: FutureBuilder<_SettingsData>(
        future: _future,
        builder: (context, snapshot) {
          final data = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Text(
                'Status do app',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.rocket_launch_outlined),
                  title: const Text('Sprint 02 — Xtream Core'),
                  subtitle: Text(
                    data == null
                        ? 'Carregando...'
                        : '${data.activeServersCount} servidores internos ativos',
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Sessão',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.account_circle_outlined),
                  title: Text(
                    data?.session == null
                        ? 'Nenhuma conta conectada'
                        : 'Conta conectada',
                  ),
                  subtitle: Text(
                    data?.session == null
                        ? 'Faça login para carregar o catálogo.'
                        : 'Modo: ${data!.session!.mode} • Status: ${data.session!.status}',
                  ),
                ),
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: _clearSession,
                icon: const Icon(Icons.logout),
                label: const Text('LIMPAR SESSÃO'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SettingsData {
  const _SettingsData({
    required this.session,
    required this.activeServersCount,
  });

  final SessionData? session;
  final int activeServersCount;
}
