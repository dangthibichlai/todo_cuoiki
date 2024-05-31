// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:todo_cuoiky/components/button_components.dart';
import 'package:todo_cuoiky/components/text-filed_component.dart';
import 'package:todo_cuoiky/models/auth_model.dart';
import 'package:todo_cuoiky/models/user_model.dart';
import 'package:todo_cuoiky/pages/email-otp_page.dart';
import 'package:todo_cuoiky/pages/forgot_password.dart';
import 'package:todo_cuoiky/pages/home_page.dart';
import 'package:todo_cuoiky/resources/alert_app.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/resources/text_controller.dart';
import 'package:todo_cuoiky/service/auth_api.dart';
import 'package:todo_cuoiky/service/shared_prefs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool checkValidate() {
    if (TextController.emailController.text.isEmpty) {
      AlertApp.showAlert(title: 'Please enter your email');
      return false;
    }
    if (TextController.passwordController.text.isEmpty) {
      AlertApp.showAlert(title: 'Please enter your email');

      return false;
    }
    if (!EmailValidator.validate(TextController.emailController.text)) {
      AlertApp.showAlert(title: 'Email is invalid');
      return false;
    }
    return true;
  }

  Future<void> login() async {
    if (checkValidate()) {
      setState(() {});
      EasyLoading.show(status: 'Loading...');
      await Future.delayed(const Duration(milliseconds: 1200));

      AuthService()
          .login(
        TextController.emailController.text,
        TextController.passwordController.text,
      )
          .then((value) {
        if (value.statusCode >= 200 && value.statusCode <= 300) {
          Map<String, dynamic> data = jsonDecode(value.body);
          AuthModel auth = AuthModel.fromJson(data);
          String accessToken = auth.accessToken ?? '';
          if (auth.user != null) {
            User user = auth.user!;
            SharedPrefs.userId = user.id ?? '';
          }

          if (accessToken != null) {
            SharedPrefs.token = accessToken;
            EasyLoading.dismiss();
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
            TextController.resestTextController();
          }
        } else {
          EasyLoading.dismiss();
          AlertApp.showAlert(title: 'Email or password is incorrect');
        }
      }).catchError((e) {
        EasyLoading.dismiss();
        log(e.toString());
      });
      EasyLoading.dismiss();

      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.BGAPP,
      body: SafeArea(
        child: _bodyLogin(),
      ),
    );
  }

  Widget _bodyLogin() {
    return Column(
      children: [
        SizedBox(height: 20.h), // ignore: prefer_const_constructors
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ],
        ),
        SizedBox(height: 20.h),
        Image.asset(
          'assets/images/launcher_icon.png',
          width: 50.h,
          height: 50.h,
        ),
        Text(
          'ToDo',
          style: GoogleFonts.pacifico(
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.BLUE,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Login your account to continue',
          style: GoogleFonts.lexend(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.BLACK,
          ),
        ),
        TextFiledComponent(
          hintText: 'Enter your email',
          controller: TextController.emailController,
        ),
        TextFiledComponent(
          hintText: 'Enter your password',
          obscureText: true,
          controller: TextController.passwordController,
        ),
        SizedBox(height: 20.h),
        ButtonComponents(
          text: 'LOGIN',
          onPressed: () {
            //LOGIN
            login();
          },
          color: AppColor.BLUE,
          textColor: AppColor.WHITE,
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account?',
              style: GoogleFonts.lexend(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.BLACK,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailOtpPage()));
              },
              child: Text(
                'Sign Up',
                style: GoogleFonts.lexend(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.BLUE,
                ),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
          },
          child: Text(
            'Forgot password?',
            style: GoogleFonts.lexend(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.BLUE,
            ),
          ),
        ),
      ],
    );
  }
}
