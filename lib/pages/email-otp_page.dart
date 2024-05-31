// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_cuoiky/components/button_components.dart';
import 'package:todo_cuoiky/components/text-filed_component.dart';
import 'package:todo_cuoiky/pages/otp_page.dart';
import 'package:todo_cuoiky/resources/alert_app.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/resources/text_controller.dart';
import 'package:todo_cuoiky/service/auth_api.dart';

class EmailOtpPage extends StatefulWidget {
  const EmailOtpPage({super.key});

  @override
  State<EmailOtpPage> createState() => _EmailOtpPageState();
}

class _EmailOtpPageState extends State<EmailOtpPage> {
  bool checkMail() {
    if (EmailValidator.validate(TextController.emailController.text.trim())) {
      return true;
    } else {
      AlertApp.showAlert(title: 'Email is not valid', color: AppColor.red);
      return false;
    }
  }

  void sen_OTP() {
    if (!checkMail()) {
      return;
    }
    EasyLoading.show(status: 'Loading...');
    AuthService().sendOtp(TextController.emailController.text.trim()).then((value) {
      Map<String, dynamic> data = jsonDecode(value.body);
      if (value.statusCode >= 200 && value.statusCode <= 300) {
        EasyLoading.dismiss();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPPage()));
        AlertApp.showAlert(title: 'OTP sent to your email', color: AppColor.GREEN);
      } else {
        EasyLoading.dismiss();
        AlertApp.showAlert(title: data['message'], color: AppColor.red);
      }
    });
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
          'Todo',
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
          'Sing up your account to continue',
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
        SizedBox(height: 10.h),
        SizedBox(
          width: .9.sw,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'By signing up, you agree to our',
                  style: GoogleFonts.lexend(
                    color: AppColor.BLACK,
                    fontSize: 13.sp,
                  ),
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: GoogleFonts.lexend(
                    color: AppColor.BLACK,
                    fontSize: 13.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: ' and ',
                  style: GoogleFonts.lexend(
                    color: AppColor.BLACK,
                    fontSize: 12.sp,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: GoogleFonts.lexend(
                    color: AppColor.BLACK,
                    fontSize: 13.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        ButtonComponents(
          text: 'CONTINUE',
          onPressed: () {
            sen_OTP();
          },
          color: AppColor.BLUE,
          textColor: AppColor.WHITE,
        ),
        SizedBox(height: 20.h),

        TextButton(
          onPressed: () {},
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
