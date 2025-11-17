import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:xyz/features/community/tabs/posts/data/post_models.dart';
import 'package:xyz/features/community/tabs/posts/presentation/widgets/post_card.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final post = Get.arguments as PostModel;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          PostCard(post: post, onLike: () {}),
          Text('Comments'),
          Divider(),
        ],
      ),
    );
  }
}
