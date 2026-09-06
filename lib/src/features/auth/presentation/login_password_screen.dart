import 'package:flutter/material.dart';

import '../../../models/connection_request.dart';
import 'sync_screen.dart';

class LoginPasswordScreen extends StatefulWidget {
  const LoginPasswordScreen({super.key});

  static const routeName = '/login-password';

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _connect() {
    final username = _loginController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe login e senha.')),
      );
      return;
    }

    Navigator.of(context).pushReplacementNamed(
      SyncScreen.routeName,
      arguments: ConnectionRequest.loginPassword(
        username: username,
        password: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login e Senha'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 20),
          Text(
            'Entre sem informar DNS',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'O DBob Player vai testar os servidores internos por prioridade.',
          ),
          const SizedBox(height: 28),
          TextField(
            controller: _loginController,
            decoration: const InputDecoration(
              labelText: 'Login',
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
            child: const Text('ENTRAR'),
          ),
        ],
      ),
    );
  }
}
