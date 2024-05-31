import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_cuoiky/pages/splash_page.dart';
import 'package:todo_cuoiky/pages/task_complete.dart';
import 'package:todo_cuoiky/pages/task_home_page.dart';
import 'package:todo_cuoiky/service/shared_prefs.dart';

Future<void> main() async {
  Get.lazyPut(() => TaskCompletePageState());
  Get.lazyPut(() => TaskHomePageState());
  Get.lazyPut(() => TaskCompletePageState());
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialise();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,

        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return BetterFeedback(
            theme: FeedbackThemeData(
              background: Colors.grey,
              feedbackSheetColor: Colors.grey[50]!,
              drawColors: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
              ],
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'TO DO APP',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const SplashPageToDo(),
              builder: EasyLoading.init(),
            ),
          );
        });
  }
}
