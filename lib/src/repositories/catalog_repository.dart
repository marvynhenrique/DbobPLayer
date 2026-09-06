import '../models/catalog_category.dart';
import '../models/content_item.dart';
import '../models/session_data.dart';
import '../services/session_storage.dart';
import '../services/xtream_service.dart';

class CatalogRepository {
  CatalogRepository({
    XtreamService? xtreamService,
    SessionStorage? sessionStorage,
  })  : _xtreamService = xtreamService ?? XtreamService(),
        _sessionStorage = sessionStorage ?? SessionStorage();

  final XtreamService _xtreamService;
  final SessionStorage _sessionStorage;

  Future<List<CatalogCategory>> getCategories(CatalogType type) async {
    final session = await _requireSession();

    return _xtreamService.getCategories(
      baseUrl: session.baseUrl,
      username: session.username,
      password: session.password,
      type: type,
    );
  }

  Future<List<ContentItem>> getContent(
    CatalogType type, {
    String? categoryId,
  }) async {
    final session = await _requireSession();

    return _xtreamService.getContent(
      baseUrl: session.baseUrl,
      username: session.username,
      password: session.password,
      type: type,
      categoryId: categoryId,
    );
  }

  Future<SessionData> _requireSession() async {
    final session = await _sessionStorage.load();

    if (session == null) {
      throw StateError('Sessão não encontrada.');
    }

    return session;
  }
}
