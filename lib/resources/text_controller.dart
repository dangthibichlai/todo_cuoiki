import 'package:flutter/material.dart';

class TextController {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController otpController = TextEditingController();
  static TextEditingController passwordConfirm = TextEditingController();

  TextController.resestTextController() {
    emailController.clear();
    passwordController.clear();
  }

  TextController.resestEmailController() {
    emailController.clear();
  }

  TextController.resestPasswordController() {
    passwordController.clear();
  }

  TextController.resestOTPController() {
    otpController.clear();
  }
}
