import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:xyz/features/community/tabs/posts/logic/post_bloc.dart';
import 'package:xyz/features/community/tabs/posts/logic/post_event.dart';
import 'package:xyz/features/community/tabs/posts/logic/post_state.dart';
import 'package:xyz/features/community/tabs/posts/presentation/widgets/post_card.dart';

class PostTab extends StatelessWidget {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.find<PostBloc>();

    if (bloc.state.status == PostStatus.initial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!bloc.isClosed) {
          bloc.add(PostRequested());
        }
      });
    }
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == PostStatus.failure) {
            return Center(child: Text(state.error ?? 'Failure to load feed'));
          }

          final feed = state.feed;

          return RefreshIndicator(
            onRefresh: () async =>
                context.read<PostBloc>().add(PostRequested(forceRefresh: true)),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 120),
              itemCount: feed.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (ctx, i) {
                final post = feed[i];
                return PostCard(
                  post: post,
                  onLike: () =>
                      ctx.read<PostBloc>().add(PostLikeToggled(post.id)),
                  onComments: () async {
                    Get.toNamed('/community/tweet', arguments: post);
                    ctx.read<PostBloc>().add(PostCommentsRequested(post.id));
                    print(bloc.state.commentsByPost);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
