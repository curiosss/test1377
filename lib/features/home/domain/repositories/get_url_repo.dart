import 'package:test1377/core/errors/errors.dart';

abstract class GetUrlRepo {
  Future<(KError? err, String url)> getUrl();
}
