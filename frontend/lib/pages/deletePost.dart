import 'package:flutter/material.dart';
import 'package:frontend/controllers/authController.dart';
import 'package:frontend/controllers/postController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeletePost extends StatefulWidget {
  final String id;

  const DeletePost({super.key, required this.id});

  @override
  State<DeletePost> createState() => _DeletePostState();
}

class _DeletePostState extends State<DeletePost> {
  final PostController post = Get.find<PostController>();
  final AuthController auth = Get.find<AuthController>();

  void deletePost(String id) async {
    String token = auth.getToken;

    final url = Uri.parse("http://localhost:8000/api/posts/delete/$id");
    final res = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    if (res.statusCode == 200) {
      post.fetchPosts(token);
      Get.back();
    }
  }

  void deletePostDialog() async {
    await showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete"),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue[100]),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red[500]),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            onPressed: () {
              deletePost(widget.id);
            },
            child: const Text("Delete"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: deletePostDialog,
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
