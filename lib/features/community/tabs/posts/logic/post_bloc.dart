import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xyz/features/community/tabs/posts/data/comment_model.dart';
import 'package:xyz/features/community/tabs/posts/data/post_repository.dart';
import 'package:xyz/features/community/tabs/posts/logic/post_event.dart';
import 'package:xyz/features/community/tabs/posts/logic/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _repo;

  PostBloc(this._repo) : super(const PostState()) {
    on<PostRequested>(_onFeedRequested);
    on<PostLikeToggled>(_onLikeToggled);
    on<PostCommentsRequested>(_onCommentsRequested);
  }

  Future<void> _onFeedRequested(
    PostRequested e,
    Emitter<PostState> emit,
  ) async {
    if (state.status == PostStatus.success && !e.forceRefresh) return;

    emit(state.copyWith(status: PostStatus.loading, error: null));
    try {
      final posts = await _repo.fetchFeed(limit: 25);
      emit(state.copyWith(status: PostStatus.success, feed: posts));
    } catch (err) {
      emit(state.copyWith(status: PostStatus.failure, error: err.toString()));
    }
  }

  Future<void> _onLikeToggled(
    PostLikeToggled e,
    Emitter<PostState> emit,
  ) async {
    final post = state.feed.firstWhere((p) => p.id == e.postId);
    final optimistic = post.youLiked
        ? post.copyWith(youLiked: false, likesCount: post.likesCount - 1)
        : post.copyWith(youLiked: true, likesCount: post.likesCount + 1);

    emit(state.updatePost(optimistic));

    try {
      if (post.youLiked) {
        await _repo.unlikePost(post.id);
      } else {
        await _repo.likePost(post.id);
      }
    } catch (err) {
      emit(state.updatePost(post));
    }
  }

  Future<void> _onCommentsRequested(
    PostCommentsRequested e,
    Emitter<PostState> emit,
  ) async {
    if (state.commentsByPost.containsKey(e.postId)) return;

    try {
      final comments = await _repo.fetchComments(e.postId);
      final newMap = Map<String, List<CommentModel>>.from(state.commentsByPost)
        ..[e.postId] = comments;
      emit(state.copyWith(commentsByPost: newMap));
    } catch (_) {}
  }
}
