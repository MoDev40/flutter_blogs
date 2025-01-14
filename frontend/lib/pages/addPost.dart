import 'dart:convert';

import 'package:frontend/controllers/authController.dart';
import 'package:frontend/controllers/postController.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  AuthController auth = Get.find<AuthController>();
  PostController post = Get.find<PostController>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController tags = TextEditingController();

  Future<void> addPost() async {
    try {
      var url = Uri.parse("http://localhost:8000/api/posts/create");
      var res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${auth.getToken}'
        },
        body: jsonEncode(
            {'title': title.text, 'content': content.text, 'tags': tags.text}),
      );
      if (res.statusCode == 201) {
        post.fetchPosts(auth.getToken);
        Get.snackbar("Post", "added successfully");
        Navigator.pop(context);
      }
    } catch (e) {
      Get.snackbar("Error", "Error adding Post");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: addPost,
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
