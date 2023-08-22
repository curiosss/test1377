import 'package:test1377/core/errors/errors.dart';

import '../entities/article.dart';

abstract class ArticlesRepo {
  Future<(KError? err, List<Article> articles)> getArticles();
}
