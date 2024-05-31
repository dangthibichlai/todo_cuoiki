// ignore_for_file: non_constant_identifier_names, unused_field

import 'dart:async';
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:todo_cuoiky/components/button_components.dart';
import 'package:todo_cuoiky/pages/sign-up_page.dart';
import 'package:todo_cuoiky/resources/alert_app.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/resources/text_controller.dart';
import 'package:todo_cuoiky/service/auth_api.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late Timer _countDownOTP;
  ValueNotifier<int> timeCountDownOTP = ValueNotifier<int>(90);
  ValueNotifier<String> countString = ValueNotifier<String>('1:30');
  int? seconds;

  @override
  void initState() {
    super.initState();
    TextController.otpController = TextEditingController();
    _countDownTimeOTP();
  }

  @override
  void dispose() {
    TextController.otpController.dispose();
    _countDownOTP.cancel();
    super.dispose();
  }

  void onClickOtpSendAgain() {
    timeCountDownOTP.value = 90;
    _countDownTimeOTP();
    sen_OTP();
  }

  void _countDownTimeOTP() {
    _countDownOTP = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (timeCountDownOTP.value <= 0) {
          timer.cancel();
          countString.value = '1:30';
        } else {
          timeCountDownOTP.value--;
          seconds = timeCountDownOTP.value % 60;
          if (timeCountDownOTP.value > 60) {
            if (seconds! >= 10) {
              countString.value = '1:$seconds';
            } else {
              countString.value = '1:0$seconds';
            }
          } else if (timeCountDownOTP.value == 60) {
            countString.value = '60';
          } else {
            if (seconds! >= 10) {
              countString.value = '$seconds';
            } else {
              countString.value = '0$seconds';
            }
          }
          setState(() {});
        }
      },
    );
  }

  void verify_OTP() {
    EasyLoading.show(status: 'Loading...');
    AuthService()
        .verifyOtp(TextController.emailController.text.trim(), TextController.otpController.text.trim())
        .then((value) {
      Map<String, dynamic> data = jsonDecode(value.body);
      if (value.statusCode >= 200 && value.statusCode <= 300) {
        EasyLoading.dismiss();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
        AlertApp.showAlert(title: 'OTP sent to your email', color: AppColor.GREEN);
      } else {
        EasyLoading.dismiss();
        AlertApp.showAlert(title: data['message'], color: AppColor.red);
      }
    });
  }

  bool checkMail() {
    if (EmailValidator.validate(TextController.emailController.text.trim())) {
      return true;
    } else {
      AlertApp.showAlert(title: 'Email is not valid', color: AppColor.red);
      return false;
    }
  }

  void sen_OTP() {
    TextController.otpController.clear();
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
      backgroundColor: AppColor.BGAPP,
      resizeToAvoidBottomInset: false, // true thif
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    TextController.otpController = TextEditingController();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ],
          ),
          Expanded(child: bodyOtp(context)),
        ],
      )),
    );
  }

  Widget bodyOtp(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(left: .1.sw, right: .1.sw, top: .03.sh, bottom: .03.sh),
      child: Column(
        children: <Widget>[
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
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: .8.sw,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'We have sent you a code to verify your email',
                style: GoogleFonts.lexend(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.BLACK,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: .8.sw,
            margin: EdgeInsets.only(top: .02.sh),
            child: Text(
              'To complete the account setup process, enter the code we sent to:',
              style: GoogleFonts.lexend(
                fontSize: 12.sp,
                color: AppColor.BLACK,
              ),
            ),
          ),
          Container(
            width: .8.sw,
            margin: EdgeInsets.only(top: .02.sh),
            child: Text(
              TextController.emailController.text,
              style: GoogleFonts.lexend(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.BLACK,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          OtpInputWidget(context),
          _titleTimeSendOTP(context),
          SizedBox(height: 10.h),

          // Center(
          //     child: TextButton(
          //   onPressed: () {
          //     sen_OTP();
          //   },
          //   child: Text(
          //     'Resend OTP',
          //     style: GoogleFonts.lexend(
          //       fontSize: 12.sp,
          //       color: AppColor.BLUE,
          //       decoration: TextDecoration.underline,
          //       decorationColor: AppColor.BLUE,
          //     ),
          //   ),
          // )),
          ButtonComponents(
            text: 'Verify',
            onPressed: () {
              verify_OTP();
            },
            color: AppColor.BLUE,
            textColor: AppColor.WHITE,
          ),
        ],
      ),
    ));
  }

  Widget OtpInputWidget(BuildContext context) {
    return SizedBox(
      width: .8.sw,
      child: PinCodeTextField(
        autoFocus: true,
        controller: TextController.otpController,
        keyboardType: TextInputType.number,
        appContext: context,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        animationDuration: const Duration(milliseconds: 300),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          fieldHeight: 50.0,
          fieldWidth: 40.0,
          activeFillColor: AppColor.WHITE,
          inactiveColor: AppColor.GREY,
          activeColor: AppColor.BLUE,
          selectedColor: AppColor.BLUE,
        ),
        enableActiveFill: false,
        onCompleted: (v) {},
        onChanged: (value) {},
      ),
    );
  }

  Widget _titleTimeSendOTP(BuildContext context) {
    return timeCountDownOTP.value <= 0
        ? Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Did not receive a code? ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.BLACK,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: InkWell(
                    onTap: () {
                      onClickOtpSendAgain();
                    },
                    child: Text('Resend',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.BLUE,
                        )),
                  ),
                )
              ],
            ),
          )
        : Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'Resend code after ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.BLACK,
                    )),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Text(countString.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.BLUE,
                      )),
                ),
                TextSpan(
                    text: ' seconds',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.BLACK,
                    )),
              ],
            ),
            textAlign: TextAlign.center,
          );
  }
}
