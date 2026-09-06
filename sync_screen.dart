import 'dart:async';

import 'package:flutter/material.dart';

import '../../home/presentation/home_screen.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  static const routeName = '/sync';

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  int _step = 0;

  final List<String> _steps = const [
    'Validando credenciais',
    'Procurando servidor correto',
    'Preparando catálogo',
    'Salvando sessão local',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (!mounted) return;
      if (_step < _steps.length) {
        setState(() => _step++);
      } else {
        timer.cancel();
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final method = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sincronizando',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text('Método: ${method ?? 'padrão'}'),
                const SizedBox(height: 24),
                for (var index = 0; index < _steps.length; index++)
                  ListTile(
                    leading: Icon(
                      index < _step
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                    ),
                    title: Text(_steps[index]),
                  ),
                const SizedBox(height: 16),
                const LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
