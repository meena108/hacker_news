import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_state.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/repo/repository.dart';

import 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final Repository repo;
  CommentBloc(this.repo) : super(CommentState(status: CommentStatus.initial));
  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is FetchCommentEvent) {
      yield (CommentState(status: CommentStatus.loading));
      final item = await repo.fetchItem(event.id);
      if (item == null) {
        yield (CommentState(
            status: CommentStatus.error, message: 'Could not fetch item'));
      } else {
        yield loadComment(item);
      }
    }
  }

  CommentState loadComment(ItemModel item) {
    var list =List.from(state.comments!).cast<ItemModel>();
    list.add(item);
    return CommentState(status: CommentStatus.loaded, comments: list);
  }
}