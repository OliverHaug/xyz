abstract class PostEvent {}

class PostRequested extends PostEvent {
  final bool forceRefresh;
  PostRequested({this.forceRefresh = false});
}

class PostLikeToggled extends PostEvent {
  final String postId;
  PostLikeToggled(this.postId);
}

class PostCommentsRequested extends PostEvent {
  final String postId;
  PostCommentsRequested(this.postId);
}
