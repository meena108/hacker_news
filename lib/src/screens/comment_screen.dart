import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_bloc.dart';
import 'package:hacker_news/src/bloc/comment/comment_event.dart';
import 'package:hacker_news/src/bloc/comment/comment_state.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/repo/repository.dart';

class CommentScreen extends StatelessWidget {
  final ItemModel item;



  const CommentScreen({Key? key, required this.item}) : super(key: key);



  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News detail"),
      ),
      body: BlocProvider(
        create: (_) => CommentBloc(Repository()),
        child: Builder(
            builder: (context) {
              return _buildComments(context);
            }
        ),
      ),
    );
  }



  Widget _buildComments(BuildContext context) {
    final CommentBloc bloc = BlocProvider.of<CommentBloc>(context);
    item.kids!.forEach((element) {
      bloc.add(FetchCommentEvent(element));
    });
    // for (var value in item.kids!) {
    //   bloc.add(FetchCommentEvent(value));
    // }



    return Column(
      children: [
        Text(item.title!, style: Theme.of(context).textTheme.headline6),
        Divider(),
        /// --- comments
        BlocBuilder<CommentBloc, CommentState>(
          builder: (BuildContext context, CommentState state) {
            print('comment state is ${state.status}');
            if (state.status == CommentStatus.initial ||
                state.status == CommentStatus.loaded) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.status == CommentStatus.error) {
              return Center(child: Text(state.message!));
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.comments!.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(state.comments![index].title!);
              },
            );
          },
        )
      ],
    );
  }
}
