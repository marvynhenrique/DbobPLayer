import 'package:flutter/material.dart';

import 'sync_screen.dart';

class XtreamCodesScreen extends StatefulWidget {
  const XtreamCodesScreen({super.key});

  static const routeName = '/xtream-codes';

  @override
  State<XtreamCodesScreen> createState() => _XtreamCodesScreenState();
}

class _XtreamCodesScreenState extends State<XtreamCodesScreen> {
  final _urlController = TextEditingController();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _urlController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _connect() {
    if (_urlController.text.trim().isEmpty ||
        _userController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe URL, usuário e senha.')),
      );
      return;
    }

    Navigator.of(context).pushReplacementNamed(
      SyncScreen.routeName,
      arguments: 'xtream_codes',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xtream Codes'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 20),
          Text(
            'Conexão avançada',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          const Text('Use URL do servidor, usuário e senha.'),
          const SizedBox(height: 28),
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'URL do servidor',
              hintText: 'http://servidor.com:8080',
              prefixIcon: Icon(Icons.dns_outlined),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _userController,
            decoration: const InputDecoration(
              labelText: 'Usuário',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _passwordController,
            obscureText: _obscure,
            decoration: InputDecoration(
              labelText: 'Senha',
              prefixIcon: const Icon(Icons.password),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton(
            onPressed: _connect,
            child: const Text('CONECTAR'),
          ),
        ],
      ),
    );
  }
}
