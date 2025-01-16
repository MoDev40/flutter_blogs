import 'package:flutter/material.dart';
import 'package:frontend/controllers/authController.dart';
import 'package:frontend/controllers/postController.dart';
import 'package:frontend/pages/addPost.dart';
import 'package:frontend/pages/deletePost.dart';
import 'package:frontend/pages/post.dart';
import 'package:get/get.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  AuthController auth = Get.find<AuthController>();
  final PostController posts = Get.find<PostController>();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() async {
    posts.fetchPosts(auth.getToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.white,
        title: const Text("Blogs"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 25,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) {
            var post = posts.posts[index];
            return ListTile(
              title: Text(
                post.title,
                style: const TextStyle(fontSize: 16),
              ),
              subtitle: Text(post.createdAt.split("T")[0]),
              trailing: post.user == auth.user?.id
                  ? DeletePost(id: post.id)
                  : const Text(""),
              onTap: () {
                Get.to(
                  PostDetails(post: post),
                );
              },
            );
          },
          itemCount: posts.posts.length,
          padding: const EdgeInsets.all(0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
        onPressed: () {
          Get.to(const AddPost());
        },
        child: const Text("+"),
      ),
    );
  }
}
