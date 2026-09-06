class XtreamAccount {
  const XtreamAccount({
    required this.authorized,
    required this.status,
    this.expDate,
    this.maxConnections,
  });

  final bool authorized;
  final String status;
  final String? expDate;
  final String? maxConnections;

  bool get isActive {
    final normalized = status.toLowerCase().trim();
    return authorized &&
        (normalized == 'active' ||
            normalized == 'ativo' ||
            normalized == '1' ||
            normalized == 'enabled');
  }

  factory XtreamAccount.fromJson(Map<String, dynamic> json) {
    final userInfo = json['user_info'];
    if (userInfo is! Map<String, dynamic>) {
      return const XtreamAccount(
        authorized: false,
        status: 'invalid',
      );
    }

    final authValue = userInfo['auth'];
    final authorized = authValue == 1 ||
        authValue == '1' ||
        authValue == true ||
        userInfo.containsKey('username');

    return XtreamAccount(
      authorized: authorized,
      status: userInfo['status']?.toString() ?? 'unknown',
      expDate: userInfo['exp_date']?.toString(),
      maxConnections: userInfo['max_connections']?.toString(),
    );
  }
}
