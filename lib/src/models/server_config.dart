class ServerConfig {
  const ServerConfig({
    required this.name,
    required this.url,
    required this.priority,
    required this.active,
  });

  final String name;
  final String url;
  final int priority;
  final bool active;

  factory ServerConfig.fromJson(Map<String, dynamic> json) {
    return ServerConfig(
      name: json['name']?.toString() ?? 'Servidor',
      url: json['url']?.toString() ?? '',
      priority: int.tryParse(json['priority'].toString()) ?? 999,
      active: json['active'] == true,
    );
  }
}
