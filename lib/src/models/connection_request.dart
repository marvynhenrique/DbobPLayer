class ConnectionRequest {
  const ConnectionRequest({
    required this.mode,
    required this.username,
    required this.password,
    this.serverUrl,
  });

  final ConnectionMode mode;
  final String username;
  final String password;
  final String? serverUrl;

  factory ConnectionRequest.loginPassword({
    required String username,
    required String password,
  }) {
    return ConnectionRequest(
      mode: ConnectionMode.loginPassword,
      username: username,
      password: password,
    );
  }

  factory ConnectionRequest.xtreamCodes({
    required String serverUrl,
    required String username,
    required String password,
  }) {
    return ConnectionRequest(
      mode: ConnectionMode.xtreamCodes,
      serverUrl: serverUrl,
      username: username,
      password: password,
    );
  }
}

enum ConnectionMode {
  loginPassword,
  xtreamCodes,
}
