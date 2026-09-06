import 'package:flutter/material.dart';

import '../../../shared/widgets/dbob_logo.dart';
import 'login_password_screen.dart';
import 'xtream_codes_screen.dart';

class ConnectionMethodScreen extends StatelessWidget {
  const ConnectionMethodScreen({super.key});

  static const routeName = '/connection-method';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conexão')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 18),
          const DBobLogo(),
          const SizedBox(height: 34),
          Text(
            'Como deseja conectar?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          _ConnectionCard(
            title: 'Login e Senha',
            subtitle: 'O app testa os servidores internos automaticamente.',
            icon: Icons.lock_outline,
            onTap: () {
              Navigator.of(context).pushNamed(LoginPasswordScreen.routeName);
            },
          ),
          const SizedBox(height: 14),
          _ConnectionCard(
            title: 'Xtream Codes',
            subtitle: 'Use URL do servidor, usuário e senha.',
            icon: Icons.link,
            onTap: () {
              Navigator.of(context).pushNamed(XtreamCodesScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class _ConnectionCard extends StatelessWidget {
  const _ConnectionCard({
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
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(icon, size: 34),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
