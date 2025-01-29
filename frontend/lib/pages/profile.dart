import 'package:flutter/material.dart';
import 'package:frontend/controllers/authController.dart';
import 'package:frontend/pages/login.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  AuthController auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(auth.user!.name.toUpperCase()),
            const SizedBox(height: 10),
            Text(auth.user!.email),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextButton(
                onPressed: () async {
                  auth.logout();
                  Get.offAll(const Login());
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
