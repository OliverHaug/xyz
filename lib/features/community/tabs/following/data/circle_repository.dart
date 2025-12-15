import 'package:supabase_flutter/supabase_flutter.dart';

class CircleRepository {
  final SupabaseClient _client;
  CircleRepository(this._client);

  Future<List<Map<String, dynamic>>> fetchFollowing({int limit = 50}) async {
    final res = await _client.rpc(
      'get_following_profiles',
      params: {'limit_count': limit},
    );
    return (res as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> fetchDiscover({
    String? query,
    int limit = 50,
  }) async {
    final res = await _client.rpc(
      'discover_profiles',
      params: {'search_text': (query ?? ''), 'limit_count': limit},
    );
    return (res as List).cast<Map<String, dynamic>>();
  }

  Future<void> follow(String userId) async {
    final myId = _client.auth.currentUser?.id;
    if (myId == null) throw Exception('Not authenticated');
    if (myId == userId) return;

    await _client.from('follows').insert({
      'follower_id': myId,
      'following_id': userId,
    });
  }

  Future<void> unfollow(String userId) async {
    final myId = _client.auth.currentUser?.id;
    if (myId == null) throw Exception('Not authenticated');

    await _client
        .from('follows')
        .delete()
        .eq('follower_id', myId)
        .eq('following_id', userId);
  }
}
