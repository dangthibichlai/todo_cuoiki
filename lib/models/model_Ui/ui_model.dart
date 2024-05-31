import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_cuoiky/pages/feedback.dart';
import 'package:todo_cuoiky/pages/introduction_page.dart';
import 'package:todo_cuoiky/service/shared_prefs.dart';

class UIModelHomeSetting {
  final String? title;
  final IconData? icon;
  final Function? onTap;

  UIModelHomeSetting({
    this.title,
    this.icon,
    this.onTap,
  });
}


List<UIModelHomeSetting> uiModelHomeSetting = [
  UIModelHomeSetting(
    title: 'Đổi mật khẩu',
    icon: Icons.key,
    onTap: () {},
  ),
  UIModelHomeSetting(
    title: 'Feedback',
    icon: Icons.feedback,
    onTap: () {
      Navigator.push(Get.context!, MaterialPageRoute(builder: (context) => const FeedBackPage()));
    },
  ),
  UIModelHomeSetting(
    title: 'Đăng xuất',
    icon: Icons.logout,
    onTap: () {
      SharedPrefs.token = '';
      Navigator.pushAndRemoveUntil(
          Get.context!, MaterialPageRoute(builder: (context) => const IntroductionPage()), (route) => false);
    },
  ),
];
