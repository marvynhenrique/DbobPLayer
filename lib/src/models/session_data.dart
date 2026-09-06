class SessionData {
  const SessionData({
    required this.baseUrl,
    required this.username,
    required this.password,
    required this.mode,
    required this.status,
    required this.createdAt,
    this.expDate,
    this.maxConnections,
  });

  final String baseUrl;
  final String username;
  final String password;
  final String mode;
  final String status;
  final DateTime createdAt;
  final String? expDate;
  final String? maxConnections;

  Map<String, String> toPrefs() {
    return {
      'baseUrl': baseUrl,
      'username': username,
      'password': password,
      'mode': mode,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      if (expDate != null) 'expDate': expDate!,
      if (maxConnections != null) 'maxConnections': maxConnections!,
    };
  }

  factory SessionData.fromPrefs(Map<String, String> map) {
    return SessionData(
      baseUrl: map['baseUrl'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      mode: map['mode'] ?? '',
      status: map['status'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      expDate: map['expDate'],
      maxConnections: map['maxConnections'],
    );
  }
}
