import 'package:flutter/material.dart';
import 'package:frontend/controllers/authController.dart';
import 'package:frontend/controllers/postController.dart';
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
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) {
            var post = posts.posts[index];
            return ListTile(
              leading: const Icon(Icons.inventory),
              title: Text(
                post.title,
                style: const TextStyle(fontSize: 16),
              ),
              subtitle: Text(post.createdAt.split("T")[0]),
              trailing: post.user == "id"
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  : const Text(""),
              onTap: () {},
            );
          },
          itemCount: posts.posts.length,
          padding: const EdgeInsets.all(0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text("+"),
      ),
    );
  }
}
