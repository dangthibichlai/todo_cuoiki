import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_cuoiky/components/button_components.dart';
import 'package:todo_cuoiky/models/model_Ui/introduction_model.dart';
import 'package:todo_cuoiky/pages/email-otp_page.dart';
import 'package:todo_cuoiky/pages/login_page.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/resources/text_controller.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  void signUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailOtpPage()));
  }

  void signIn() {
    TextController.otpController = TextEditingController();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(introductionList.length,
        (index) => itemIntro(introductionList[index].description, introductionList[index].image));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.BLUE,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: .4.sh,
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            SizedBox(height: 20.h),
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: const WormEffect(
                dotHeight: 16,
                dotWidth: 16,
                type: WormType.thinUnderground,
              ),
            ),
            SizedBox(height: 20.h),
            //LOGIN
            ButtonComponents(
              onPressed: () {
                signIn();
              },
            ),
            SizedBox(height: 20.h),
            // SINGUP
            ButtonComponents(
              onPressed: () {
                signUp();
              },
              text: 'Sign Up',
              isBorder: true,
              color: AppColor.BLUE,
              textColor: AppColor.WHITE,
              borderColor: AppColor.WHITE,
            ),
            SizedBox(height: 15.h),
            SizedBox(
              width: .8.sw,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By signing up, you agree to our\n',
                      style: GoogleFonts.lexend(
                        color: AppColor.WHITE,
                        fontSize: 13.sp,
                      ),
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: GoogleFonts.lexend(
                        color: AppColor.WHITE,
                        fontSize: 13.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.BLUE,
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: GoogleFonts.lexend(
                        color: AppColor.WHITE,
                        fontSize: 12.sp,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.lexend(
                        color: AppColor.WHITE,
                        fontSize: 13.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.BLUE,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: .8.sw,
              child: Text(
                'You cannot login or sign up an account',
                style: GoogleFonts.lexend(
                  color: AppColor.WHITE,
                  fontSize: 13.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.BLUE,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemIntro(String title, String image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: .8.sw,
          height: .3.sh,
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: SizedBox(
            width: .8.sw,
            child: Text(
              title,
              style: GoogleFonts.lexend(
                color: AppColor.WHITE,
                fontSize: 12.sp,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
