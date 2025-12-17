abstract class PostEvent {}

class PostRequested extends PostEvent {
  final bool forceRefresh;
  PostRequested({this.forceRefresh = false});
}

class PostCreated extends PostEvent {
  final String content;
  final String? imageUrl;
  final String? imagePath;

  PostCreated({required this.content, this.imageUrl, this.imagePath});
}

class PostEditSubmitted extends PostEvent {
  final String postId;
  final String content;
  final String? imageUrl;
  final String? imagePath;
  final bool removeImage;

  PostEditSubmitted({
    required this.postId,
    required this.content,
    this.imageUrl,
    this.imagePath,
    this.removeImage = false,
  });
}

class PostDeleteRequested extends PostEvent {
  final String postId;
  PostDeleteRequested(this.postId);
}

class PostLikeToggled extends PostEvent {
  final String postId;
  PostLikeToggled(this.postId);
}

class PostCommentsCountPatched extends PostEvent {
  final String postId;
  final int delta;
  PostCommentsCountPatched({required this.postId, required this.delta});
}
