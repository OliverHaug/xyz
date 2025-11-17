import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xyz/features/community/tabs/posts/data/comment_model.dart';
import 'package:xyz/features/community/tabs/posts/data/post_models.dart';

class PostRepository {
  final SupabaseClient _client;
  PostRepository(this._client);

  Future<List<PostModel>> fetchFeed({int limit = 20}) async {
    final uid = _client.auth.currentUser?.id;

    final data = await _client
        .from('posts')
        .select('''
          id, content, image_url, created_at,
          likes_count, comments_count,
          author:author_id (id, name, avatar_url),
          post_likes (user_id)
        ''')
        .order('created_at', ascending: false)
        .limit(limit);

    print(data);
    return (data as List)
        .map(
          (p) =>
              PostModel.fromMap(p as Map<String, dynamic>, currentUserId: uid),
        )
        .toList();
  }

  Future<List<CommentModel>> fetchComments(String postId) async {
    final uid = _client.auth.currentUser?.id;
    final data = await _client
        .from('comments')
        .select('''
          id, post_id, parent_id, content, created_at, author:author_id (id, name, avatar_url),
          comment_likes (user_id),
          replies:comments!parent_id (id)
        ''')
        .eq('post_id', postId)
        .isFilter('parent_id', null)
        .order('created_at', ascending: true);

    return (data as List)
        .map(
          (c) => CommentModel.fromMap(
            c as Map<String, dynamic>,
            currentUserId: uid ?? '',
          ),
        )
        .toList();
  }

  Future<void> likePost(String postId) async {
    final uid = _client.auth.currentUser!.id;
    await _client.from('post_likes').insert({
      'post_id': postId,
      'user_id': uid,
    });
  }

  Future<void> unlikePost(String postId) async {
    final uid = _client.auth.currentUser!.id;
    await _client.from('post_likes').delete().match({
      'post_id': postId,
      'user_id': uid,
    });
  }

  Future<String> createPost({required String content, String? imageUrl}) async {
    final uid = _client.auth.currentUser!.id;

    final inserted = await _client
        .from('posts')
        .insert({'author_id': uid, 'content': content, 'image_url': imageUrl})
        .select('id')
        .single();

    return inserted['id'] as String;
  }
}
