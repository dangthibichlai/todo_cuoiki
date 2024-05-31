import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_cuoiky/pages/bottom_builder_setting.dart';
import 'package:todo_cuoiky/pages/introduction_page.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/service/shared_prefs.dart';

class HeaderScreenWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? positionAvatar;
  final Function()? resetData;

  const HeaderScreenWidget({super.key, this.title, this.positionAvatar, this.resetData});
  @override
  Size get preferredSize => const Size.fromHeight(67);

  @override
  Widget build(BuildContext context) {
    // Đăng xuất
    void _logout() {
      SharedPrefs.token = '';
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const IntroductionPage()), (route) => false);
    }

    return AppBar(
      toolbarHeight: 67,
      leading: !(positionAvatar ?? false)
          ? Padding(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                  onTap: () {
                    showFlexibleBottomSheet(
                      duration: const Duration(milliseconds: 500),
                      minHeight: 0,
                      initHeight: 1,
                      maxHeight: 1,
                      context: context,
                      builder: buildBottomSheet,
                      isExpand: true,
                    );
                  },
                  child:
                      CircleAvatar(child: Image.asset('assets/images/launcher_icon.png', width: 100.w, height: 100.w))),
            )
          : IconButton(
              onPressed: () {
                resetData!();
              },
              icon: const Icon(Icons.autorenew_sharp, color: AppColor.WHITE),
            ),
      title: Text(
        title ?? 'TO DO',
        style: TextStyle(fontSize: 24.sp, color: AppColor.WHITE, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        positionAvatar ?? false
            ? Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                    onTap: () {
                      showFlexibleBottomSheet(
                        duration: const Duration(milliseconds: 500),
                        minHeight: 0,
                        initHeight: 1,
                        maxHeight: 1,
                        context: context,
                        builder: buildBottomSheet,
                        isExpand: false,
                      );
                    },
                    child: CircleAvatar(
                        child: Image.asset('assets/images/launcher_icon.png', width: 100.w, height: 100.w))),
              )
            : IconButton(
                onPressed: () {
                  resetData!();
                },
                icon: const Icon(Icons.autorenew_sharp, color: AppColor.WHITE),
              ),
      ],
    );
  }
}
