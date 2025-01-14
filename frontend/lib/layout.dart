import 'package:flutter/material.dart';
import 'package:frontend/controllers/authController.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/posts.dart';
import 'package:get/get.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  AuthController auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: auth.token.isEmpty ? const Login() : const Posts(),
      ),
    );
  }
}
