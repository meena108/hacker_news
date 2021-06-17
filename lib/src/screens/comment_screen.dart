import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_event.dart';
import 'package:hacker_news/src/bloc/comment/comment_state.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/repo/repository.dart';
import 'package:hacker_news/src/widgets/comment_item.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key, required this.item}) : super(key: key);
  final ItemModel item;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News detail"),
      ),
      body: BlocProvider(
        create: (_) => CommentBloc(Repository()),
        child: Builder(builder: (context) {
          return _buildComments(context);
        }),
      ),
    );
  }

  Widget _buildComments(BuildContext context) {
     // for (var value in item.kids!) {
    //   bloc.add(FetchCommentEvent(value));
    // }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(item.title!, style: Theme.of(context).textTheme.headline6),
        ),
        Divider(),

        /// --- comments
        BlocBuilder<CommentBloc, CommentState>(
          builder: (BuildContext context, CommentState state) {
            print('comment state is ${state.status}');

            return Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                itemCount: item.kids!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CommentItem(
                      item: state.comments![item.kids![index]],
                    commentId: item.kids![index],
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
