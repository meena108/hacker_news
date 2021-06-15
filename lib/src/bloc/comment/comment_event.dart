abstract class CommentEvent {
  const CommentEvent();
}

class FetchCommentEvent extends CommentEvent {
  final int id;

  FetchCommentEvent(this.id);
}