import 'package:news_app/app/models/source_entity.dart';

abstract class SourcesRepository {
  Future<List<SourceEntity>> fetch();
}

class SourcesFetchException implements Exception {
  SourcesFetchException({this.message = 'Failed to fetch sources'});

  final String message;
}
