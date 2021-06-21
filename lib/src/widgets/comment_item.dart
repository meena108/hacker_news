import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/src/bloc/comment/comment_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_event.dart';
import 'package:hacker_news/src/models/item_model.dart';

import 'loading_container.dart';

class CommentItem extends StatelessWidget {
  final Map<int, Future<ItemModel?>> item;
  const CommentItem({Key? key, required this.item, required this.commentId, required this.depth})
      : super(key: key);
  final int commentId;
  final int depth;

  @override
  Widget build(BuildContext context) {

    final CommentBloc bloc = BlocProvider.of<CommentBloc>(context);
    if(item[commentId]==null){  //to prevent continuous rebuild
      bloc.add(FetchCommentEvent(commentId));
    }
    return FutureBuilder(
        future: item[commentId],
        builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
          if(!snapshot.hasData){
            return LoadingContainer();
          }
          if(snapshot.data == null){
            return Container();
          }
          final data = snapshot.data!;
          return _buildCommentItem(data);
        }
    );
  }
  Widget _buildCommentItem(ItemModel data) {
    String text = data.by == null ? "" : data.text == null ? "" : data.text!;
    return Column(
      children: [
        ListTile(
          title: Html(data: data.text),
          subtitle: Text(data.by == null ? "Deleted": "By: ${data.by}"),
          contentPadding: EdgeInsets.only(left: 16,right: 16),
        ),
        ListView.builder(
          itemCount: data.kids!.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index){
            return CommentItem(item: item, commentId: data.kids![index],depth: depth+1,);
          },
        )
      ],
    );
  }
}