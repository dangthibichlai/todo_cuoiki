import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_cuoiky/pages/otp_page.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.WHITE,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: AppColor.BLACK,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _head(),
                      _emailField(emailController),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: _imageAndConfirm(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageAndConfirm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPPage()));
          },
          child: Padding(
            padding: EdgeInsets.all(25.sp),
            child: Container(
              height: 44.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: AppColor.BLUE, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: AppColor.WHITE,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emailField(TextEditingController emailController) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: AppColor.BLACK,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                color: AppColor.GREY,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.only(left: 20.w, right: 20.w),
              filled: true,
              fillColor: AppColor.WHITE,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColor.BLUE,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColor.WHITE,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Image.asset(
              'assets/images/img_forgot_password.png',
              width: 250.w,
              height: 230.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _head() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
          child: Text('Please enter your email address. We will send you a \nverification code to reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.BLACK,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              )),
        ),
        SizedBox(
          height: 70.h,
        ),
      ],
    );
  }
}
