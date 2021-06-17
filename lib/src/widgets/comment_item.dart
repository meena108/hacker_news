import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_event.dart';
import 'package:hacker_news/src/models/item_model.dart';

import 'loading_container.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, required this.item, required this.commentId}) : super(key: key);
  final Future<ItemModel?>? item;
  final int commentId;

  @override
  Widget build(BuildContext context) {
    final CommentBloc bloc = BlocProvider.of<CommentBloc>(context);
    bloc.add(FetchCommentEvent(commentId));
    return FutureBuilder(
        future: item,
        builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }
          if (snapshot.data == null) {
            return Container();
          }
          final item = snapshot.data!;
          return ListTile(
            title: Text(item.by == null ? "" : item.text!),
            subtitle: Text(item.by == null ? "Deleted" : "By; ${item.by}"),
          );
        });
  }
}
