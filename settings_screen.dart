import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<dynamic> _servers = [];

  @override
  void initState() {
    super.initState();
    _loadServers();
  }

  Future<void> _loadServers() async {
    final raw = await rootBundle.loadString('assets/config/servers.json');
    setState(() {
      _servers = jsonDecode(raw) as List<dynamic>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            'Servidores internos',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          const Text(
            'No modo Login e Senha, o app usará essa lista por prioridade.',
          ),
          const SizedBox(height: 14),
          for (final server in _servers)
            Card(
              child: ListTile(
                leading: const Icon(Icons.dns_outlined),
                title: Text(server['name'].toString()),
                subtitle: Text(server['url'].toString()),
                trailing: Text('#${server['priority']}'),
              ),
            ),
          const SizedBox(height: 22),
          Text(
            'Sprint atual',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          const Card(
            child: ListTile(
              leading: Icon(Icons.rocket_launch_outlined),
              title: Text('Sprint 01 — Foundation'),
              subtitle: Text('Base Flutter + GitHub Actions + navegação.'),
            ),
          ),
        ],
      ),
    );
  }
}
