import 'package:hacker_news/src/models/item_model.dart';

enum CommentStatus {initial, loading, loaded, error}

class CommentState{
  final CommentStatus? status;
  final Map<int, Future<ItemModel?>>? comments;
  final String?message;

  const CommentState({required this.status, this.comments =const {},this.message});
}

