import 'dart:convert';
import 'package:frontend/models/Post.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;

  Future<void> fetchPosts(String token) async {
    try {
      final res = await http.get(
        Uri.parse("http://localhost:8000/api/posts"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        posts.value = data.length > 0
            ? data.map<Post>((data) => Post.fromJson(data)).toList()
            : [];
      } else {
        Get.snackbar("Error", "Failed to fetch Posts");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching tasks");
    }
  }

  Future<void> deletePost(String token, String id) async {
    try {
      var url = Uri.parse("http://localhost:8000/api/posts/delete/$id");
      var res = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (res.statusCode == 200) {
        Get.snackbar("Post", "deleted successfully");
        fetchPosts(token);
      }
    } catch (e) {
      Get.snackbar("Error", "Error deleting Post");
    }
  }
}
