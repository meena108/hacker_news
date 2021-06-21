import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/core/sources.dart';
import 'package:hacker_news/src/repo/news_db_provider.dart';
import 'news_api_provider.dart';

class Repository {
  final NewsDbProvider dbProvider = NewsDbProvider();
  final NewsApiProvider apiProvider = NewsApiProvider();

  late final List<Source> sources = [
    dbProvider,
    apiProvider,
  ];

  late final List<Cache> caches = [
    dbProvider,
  ];

  Future<List<int>> fetchTopIds() async {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    ItemModel? item;
    Source? source;
    for (var source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }
    if (item != null) {
      for (var cache in caches) {
        if (source is NewsApiProvider) {
          cache.insertItem(item);
        }
      }
    }
    return item;
  }
  Future<void>clearData() async {
    await dbProvider.clearData();
  }
}
