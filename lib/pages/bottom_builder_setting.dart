// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'dart:typed_data';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_cuoiky/models/model_Ui/ui_model.dart';
import 'package:todo_cuoiky/pages/introduction_page.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/service/shared_prefs.dart';

Widget buildBottomSheet(
  BuildContext context,
  ScrollController scrollController,
  double bottomSheetOffset,
) {
  return Scaffold(
      backgroundColor: AppColor.BGAPP,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: .03.sh,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: AppColor.GREY, size: 20.sp)),
                  Text('Acount', style: GoogleFonts.lexend(fontWeight: FontWeight.w500, fontSize: 16.sp)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: .01.sh, left: .05.sw, right: .1.sw),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15.0.w),
                            child: CircleAvatar(
                              radius: 30.sp,
                              backgroundColor: AppColor.WHITE,
                              child: Image.asset(
                                'assets/images/launcher_icon.png',
                                width: 50.h,
                                height: 50.h,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.camera_alt, color: AppColor.BLUE, size: 20.sp),
                            ),
                          ),
                          // Text(
                          //   "Nguyễn Văn Phước",
                          //   style:
                          //       GoogleFonts.lexend(fontWeight: FontWeight.w500, fontSize: 20.sp, color: AppColor.WHITE),
                          // ),
                        ],
                      ),
                      SizedBox(width: 10.sp),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Nguyễn Văn Phước",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lexend(
                                  fontWeight: FontWeight.w400, fontSize: 13.sp, color: AppColor.BLUE),
                            ),
                            Text(
                              "phuoc@gmail.com",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lexend(
                                  fontWeight: FontWeight.w300, fontSize: 11.sp, color: AppColor.BLACK),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Divider(
              color: AppColor.GREY.withOpacity(.2),
            ),
            Expanded(
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = uiModelHomeSetting[index];
                    return InkWell(
                        onTap: () {
                          if (item.title == 'Feedback') {
                            BetterFeedback.of(context).show((UserFeedback feedback) async {
                              // draft an email and send to developer
                              final screenshotFilePath = await writeImageToStorage(feedback.screenshot);

                              final Email email = Email(
                                body: feedback.text,
                                subject: 'ToDo Feedback',
                                recipients: ['dangbichlai21@gmail.com'],
                                attachmentPaths: [screenshotFilePath],
                                isHTML: false,
                              );
                              await FlutterEmailSender.send(email);
                            });

                            return;
                          }
                          if (item.title == 'Đăng xuất') {
                            SharedPrefs.token = '';
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) => const IntroductionPage()), (route) => false);
                          }
                          return;
                        },
                        child: _settingHome(item.icon ?? Icons.abc, item.title ?? ''));
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppColor.GREY.withOpacity(.2),
                    );
                  },
                  itemCount: uiModelHomeSetting.length),
            )
          ],
        ),
      ));
}

Widget _settingHome(IconData icon, String title) {
  return Padding(
    padding: EdgeInsets.only(left: .05.sw, right: .1.sw, top: 5.sp, bottom: 5.sp),
    child: Row(
      children: [
        Icon(icon, color: AppColor.BLACK, size: 20.sp),
        SizedBox(
          width: 20.sp,
        ),
        Text(title, style: GoogleFonts.lexend(fontWeight: FontWeight.w300, fontSize: 14.sp, color: AppColor.BLACK)),
      ],
    ),
  );
}

Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
