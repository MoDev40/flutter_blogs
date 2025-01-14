import 'package:frontend/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/postController.dart';
import 'package:frontend/layout.dart';
import 'package:get/get.dart';

void main() async {
  Get.put(AuthController());
  Get.put(PostController());
  runApp(
    const GetMaterialApp(
      home: Layout(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
