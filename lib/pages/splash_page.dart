import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_cuoiky/pages/home_page.dart';
import 'package:todo_cuoiky/pages/introduction_page.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/service/shared_prefs.dart';

class SplashPageToDo extends StatefulWidget {
  const SplashPageToDo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageToDoState createState() => _SplashPageToDoState();
}

class _SplashPageToDoState extends State<SplashPageToDo> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animationController.forward().then((_) {
      _checkToken();
    });
  }

  void _checkToken() {
    Timer(const Duration(milliseconds: 2600), () {
      if (SharedPrefs.isLogin) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const IntroductionPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BGAPP,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/launcher_icon.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      width: 300,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _animationController.value,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColor.BLUE),
                            backgroundColor: const Color.fromARGB(255, 108, 105, 105),
                            minHeight: 8,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
