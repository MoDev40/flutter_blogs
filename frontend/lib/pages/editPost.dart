import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/authController.dart';
import 'package:frontend/controllers/postController.dart';
import 'package:frontend/layout.dart';
import 'package:frontend/models/Post.dart';
import 'package:frontend/pages/posts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditPost extends StatefulWidget {
  final Post post;

  const EditPost({super.key, required this.post});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  bool isLoading = false;
  AuthController auth = Get.find<AuthController>();
  PostController post = Get.find<PostController>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController tags = TextEditingController();

  Future<void> editPost() async {
    setState(() {
      isLoading = true;
    });
    try {
      var url =
          Uri.parse("http://localhost:8000/api/posts/edit/${widget.post.id}");
      var res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${auth.getToken}'
        },
        body: jsonEncode(
            {'title': title.text, 'content': content.text, 'tags': tags.text}),
      );
      if (res.statusCode == 200) {
        post.fetchPosts(auth.getToken);
        Get.snackbar("Post", "Updated successfully");
        Get.offAll(const Layout());
      }
    } catch (e) {
      Get.snackbar("Error", "Error editing Post");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.post.title);
    tags = TextEditingController(text: widget.post.tags);
    content = TextEditingController(text: widget.post.content);
  }

  @override
  void dispose() {
    title.dispose();
    tags.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  labelText: "title",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tags,
                decoration: const InputDecoration(
                  labelText: "tags",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: content,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                  foregroundColor: Colors.white,
                ),
                onPressed: editPost,
                child: Text(isLoading ? "Loading...." : "Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
