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
   final item =  repo.fetchItem(event.id);
        yield loadComment(item,event.id);
      }
    }


  CommentState loadComment(Future<ItemModel?> item, int id) {
    Map<int, Future<ItemModel?>> map =Map.from(state.comments!);
    // map[id] =item;
    map.putIfAbsent(id, () => item);

    return CommentState(status: CommentStatus.loaded, comments: map);
  }
}
