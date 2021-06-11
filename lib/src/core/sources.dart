import 'package:hacker_news/src/bloc/models/item_model.dart';

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel?> fetchItem(int id);

}
abstract class Cache {
  Future<int> insertItem(ItemModel model);
}