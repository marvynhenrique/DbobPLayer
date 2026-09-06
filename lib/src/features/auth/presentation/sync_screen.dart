import 'package:flutter/material.dart';

import '../../../core/errors/app_exception.dart';
import '../../../models/connection_request.dart';
import '../../../repositories/auth_repository.dart';
import '../../home/presentation/home_screen.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  static const routeName = '/sync';

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  final _authRepository = AuthRepository();

  String _message = 'Preparando conexão...';
  bool _hasError = false;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_started) return;
    _started = true;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ConnectionRequest) {
      _connect(args);
    } else {
      setState(() {
        _hasError = true;
        _message = 'Dados de conexão não encontrados.';
      });
    }
  }

  Future<void> _connect(ConnectionRequest request) async {
    try {
      setState(() {
        _hasError = false;
        _message = request.mode == ConnectionMode.loginPassword
            ? 'Testando servidores internos...'
            : 'Validando Xtream Codes...';
      });

      await _authRepository.connect(request);

      if (!mounted) return;

      setState(() {
        _message = 'Login validado. Carregando app...';
      });

      await Future<void>.delayed(const Duration(milliseconds: 400));

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on AppException catch (error) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _message = error.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _message = 'Erro inesperado ao conectar.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _hasError ? Icons.error_outline : Icons.sync,
                  size: 58,
                  color: _hasError ? Colors.redAccent : null,
                ),
                const SizedBox(height: 18),
                Text(
                  _hasError ? 'Falha na conexão' : 'Sincronizando',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  _message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (!_hasError) const LinearProgressIndicator(),
                if (_hasError) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/connection-method');
                    },
                    child: const Text('VOLTAR E TENTAR NOVAMENTE'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
