import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString token = "".obs;

  String get getToken => token.value;

  void setToken(String value) {
    token.value = value;
  }
}
