// ignore_for_file: sort_child_properties_last

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

class FeedBackPage extends StatelessWidget {
  const FeedBackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: BetterFeedback(
            child: const Center(child: Text('Tap me!')),
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
            localizationsDelegates: [
              // GlobalMaterialLocalizations.delegate,
              // GlobalCupertinoLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate,
              GlobalFeedbackLocalizationsDelegate(),
            ],
            localeOverride: const Locale('en'),
          ),
        ),
      ],
    ));
  }
}
