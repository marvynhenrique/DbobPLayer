import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/server_config.dart';

class ServerConfigService {
  Future<List<ServerConfig>> loadServers() async {
    final raw = await rootBundle.loadString('assets/config/servers.json');
    final decoded = jsonDecode(raw);

    if (decoded is! List) {
      return [];
    }

    final servers = decoded
        .whereType<Map<String, dynamic>>()
        .map(ServerConfig.fromJson)
        .where((server) => server.active && server.url.trim().isNotEmpty)
        .toList();

    servers.sort((a, b) => a.priority.compareTo(b.priority));
    return servers;
  }
}
