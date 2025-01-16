import 'package:flutter/material.dart';
import 'package:frontend/models/Post.dart';

class PostDetails extends StatelessWidget {
  Post post;
  PostDetails({super.key, required this.post});

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
            trailing: Text("Published at ${post.createdAt.split("T")[0]}"),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: SelectableText(post.content),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Edit"),
          )
        ],
      ),
    );
  }
}
