import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/errors/app_exception.dart';
import '../models/catalog_category.dart';
import '../models/content_item.dart';
import '../models/xtream_account.dart';

class XtreamService {
  XtreamService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<XtreamAccount> validateLogin({
    required String baseUrl,
    required String username,
    required String password,
  }) async {
    final json = await _get(
      baseUrl: baseUrl,
      username: username,
      password: password,
    );

    if (json is! Map<String, dynamic>) {
      throw const AppException('Resposta inválida do servidor.');
    }

    return XtreamAccount.fromJson(json);
  }

  Future<List<CatalogCategory>> getCategories({
    required String baseUrl,
    required String username,
    required String password,
    required CatalogType type,
  }) async {
    final json = await _get(
      baseUrl: baseUrl,
      username: username,
      password: password,
      action: type.categoriesAction,
    );

    if (json is! List) {
      return [];
    }

    return json
        .whereType<Map<String, dynamic>>()
        .map((item) => CatalogCategory.fromJson(item, type))
        .toList();
  }

  Future<List<ContentItem>> getContent({
    required String baseUrl,
    required String username,
    required String password,
    required CatalogType type,
    String? categoryId,
  }) async {
    final json = await _get(
      baseUrl: baseUrl,
      username: username,
      password: password,
      action: type.streamsAction,
      categoryId: categoryId,
    );

    if (json is! List) {
      return [];
    }

    return json
        .whereType<Map<String, dynamic>>()
        .map((item) => ContentItem.fromJson(item, type))
        .toList();
  }

  Future<dynamic> _get({
    required String baseUrl,
    required String username,
    required String password,
    String? action,
    String? categoryId,
  }) async {
    final normalizedBaseUrl = _normalizeBaseUrl(baseUrl);

    final params = <String, String>{
      'username': username,
      'password': password,
      if (action != null) 'action': action,
      if (categoryId != null && categoryId.isNotEmpty) 'category_id': categoryId,
    };

    final uri = Uri.parse('$normalizedBaseUrl/player_api.php').replace(
      queryParameters: params,
    );

    try {
      final response = await _client.get(uri).timeout(
            const Duration(seconds: 12),
          );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw AppException(
          'Servidor respondeu com erro HTTP ${response.statusCode}.',
        );
      }

      return jsonDecode(response.body);
    } on FormatException {
      throw const AppException('Resposta inválida do servidor.');
    } on AppException {
      rethrow;
    } catch (_) {
      throw const AppException('Não foi possível conectar ao servidor.');
    }
  }

  String _normalizeBaseUrl(String baseUrl) {
    var url = baseUrl.trim();
    while (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'http://$url';
    }

    return url;
  }
}
