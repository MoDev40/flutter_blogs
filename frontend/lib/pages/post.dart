import 'package:flutter/material.dart';
import 'package:frontend/controllers/authController.dart';
import 'package:frontend/models/Post.dart';
import 'package:frontend/pages/editPost.dart';
import 'package:get/get.dart';

class PostDetails extends StatelessWidget {
  Post post;
  PostDetails({super.key, required this.post});

  AuthController auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text(post.title),
            subtitle: Text(
              post.tags,
              style: TextStyle(color: Colors.blue[100]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: SelectableText(post.content),
          ),
          post.user == auth.user?.id
              ? ElevatedButton(
                  onPressed: () {
                    Get.to(
                      EditPost(post: post),
                    );
                  },
                  child: const Text("Edit"),
                )
              : Text("Published at ${post.createdAt.split("T")[0]}")
        ],
      ),
    );
  }
}
