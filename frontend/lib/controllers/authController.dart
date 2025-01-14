import 'package:frontend/models/User.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString token = "".obs;

  Rx<User?> userData = Rx<User?>(null);

  void setUser(User user) {
    userData.value = user;
  }

  User? get user => userData.value;

  String get getToken => token.value;

  void setToken(String value) {
    token.value = value;
  }
}
