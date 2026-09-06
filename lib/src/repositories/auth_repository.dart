import '../core/errors/app_exception.dart';
import '../models/connection_request.dart';
import '../models/session_data.dart';
import '../services/server_config_service.dart';
import '../services/session_storage.dart';
import '../services/xtream_service.dart';

class AuthRepository {
  AuthRepository({
    ServerConfigService? serverConfigService,
    XtreamService? xtreamService,
    SessionStorage? sessionStorage,
  })  : _serverConfigService = serverConfigService ?? ServerConfigService(),
        _xtreamService = xtreamService ?? XtreamService(),
        _sessionStorage = sessionStorage ?? SessionStorage();

  final ServerConfigService _serverConfigService;
  final XtreamService _xtreamService;
  final SessionStorage _sessionStorage;

  Future<SessionData> connect(ConnectionRequest request) async {
    switch (request.mode) {
      case ConnectionMode.loginPassword:
        return _connectUsingInternalServers(request);
      case ConnectionMode.xtreamCodes:
        return _connectUsingManualServer(request);
    }
  }

  Future<SessionData> _connectUsingManualServer(ConnectionRequest request) async {
    final baseUrl = request.serverUrl?.trim() ?? '';

    if (baseUrl.isEmpty) {
      throw const AppException('URL do servidor não informada.');
    }

    final account = await _xtreamService.validateLogin(
      baseUrl: baseUrl,
      username: request.username,
      password: request.password,
    );

    if (!account.isActive) {
      throw AppException('Conta inválida ou inativa. Status: ${account.status}');
    }

    final session = SessionData(
      baseUrl: baseUrl,
      username: request.username,
      password: request.password,
      mode: 'xtream_codes',
      status: account.status,
      createdAt: DateTime.now(),
      expDate: account.expDate,
      maxConnections: account.maxConnections,
    );

    await _sessionStorage.save(session);
    return session;
  }

  Future<SessionData> _connectUsingInternalServers(
    ConnectionRequest request,
  ) async {
    final servers = await _serverConfigService.loadServers();

    if (servers.isEmpty) {
      throw const AppException('Nenhum servidor interno configurado.');
    }

    AppException? lastError;

    for (final server in servers) {
      try {
        final account = await _xtreamService.validateLogin(
          baseUrl: server.url,
          username: request.username,
          password: request.password,
        );

        if (!account.isActive) {
          lastError = AppException(
            'Servidor ${server.name}: conta ${account.status}.',
          );
          continue;
        }

        final session = SessionData(
          baseUrl: server.url,
          username: request.username,
          password: request.password,
          mode: 'login_password',
          status: account.status,
          createdAt: DateTime.now(),
          expDate: account.expDate,
          maxConnections: account.maxConnections,
        );

        await _sessionStorage.save(session);
        return session;
      } on AppException catch (error) {
        lastError = error;
      }
    }

    throw lastError ??
        const AppException('Não foi possível validar login em nenhum servidor.');
  }
}
