import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_cuoiky/components/button_components.dart';
import 'package:todo_cuoiky/pages/login_page.dart';
import 'package:todo_cuoiky/resources/alert_app.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/resources/text_controller.dart';
import 'package:todo_cuoiky/service/auth_api.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool checkSign() {
      if (TextController.nameController.text.isEmpty ||
          TextController.passwordController.text.isEmpty ||
          TextController.passwordConfirm.text.isEmpty) {
        AlertApp.showAlert(title: 'Please enter your information');
        return false;
      }
      if (TextController.passwordController.text != TextController.passwordConfirm.text) {
        AlertApp.showAlert(title: 'Password and confirm password are not the same');
        return false;
      }
      return true;
    }

    void signUp() {
      if (checkSign()) {
        EasyLoading.show(status: 'Loading...');
        AuthService()
            .register(
          TextController.emailController.text,
          TextController.passwordController.text,
          TextController.nameController.text,
        )
            .then((value) {
          EasyLoading.dismiss();
          if (value.statusCode >= 200 && value.statusCode <= 300) {
            AlertApp.showAlert(title: 'Sign up success', color: AppColor.GREEN);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          } else {
            EasyLoading.dismiss();
            AlertApp.showAlert(title: 'Sign up fail', color: AppColor.red);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColor.BGAPP,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: .02.sh,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.close, color: AppColor.GREY, size: 20.sp)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: .1.sh,
                left: .1.sw,
                right: .1.sw,
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'veryfied',
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.BLUE,
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: AppColor.GREEN,
                        size: 16.sp,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue to set up your account',
                        style: GoogleFonts.roboto(
                          height: .5,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColor.BLUE,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  TextField(
                    controller: TextController.nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your full name',
                      label: Text('Full name'),
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.BLUE, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.BLUE, width: 2),
                      ),
                    ),
                  ),

                  ///
                  /// password
                  ///
                  SizedBox(height: 15.h),
                  TextField(
                    obscureText: true,
                    controller: TextController.passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      label: Text('Password'),
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.BLUE, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.BLUE, width: 2),
                      ),
                    ),
                  ),

                  ///
                  /// password confirm
                  ///
                  SizedBox(height: 15.h),
                  TextField(
                    obscureText: true,
                    controller: TextController.passwordConfirm,
                    decoration: const InputDecoration(
                      hintText: 'Enter confirm password',
                      label: Text('Confirm password'),
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.BLUE, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.BLUE, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ButtonComponents(
              text: 'SIGN UP',
              onPressed: () {
                signUp();
              },
              color: AppColor.BLUE,
              textColor: AppColor.WHITE,
            ),
          ],
        ),
      ),
    );
  }
}
