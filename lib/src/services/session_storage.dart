import 'package:shared_preferences/shared_preferences.dart';

import '../models/session_data.dart';

class SessionStorage {
  static const _keys = [
    'baseUrl',
    'username',
    'password',
    'mode',
    'status',
    'createdAt',
    'expDate',
    'maxConnections',
  ];

  Future<void> save(SessionData session) async {
    final prefs = await SharedPreferences.getInstance();
    for (final entry in session.toPrefs().entries) {
      await prefs.setString('session_${entry.key}', entry.value);
    }
  }

  Future<SessionData?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final map = <String, String>{};

    for (final key in _keys) {
      final value = prefs.getString('session_$key');
      if (value != null) {
        map[key] = value;
      }
    }

    if ((map['baseUrl'] ?? '').isEmpty ||
        (map['username'] ?? '').isEmpty ||
        (map['password'] ?? '').isEmpty) {
      return null;
    }

    return SessionData.fromPrefs(map);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    for (final key in _keys) {
      await prefs.remove('session_$key');
    }
  }
}
