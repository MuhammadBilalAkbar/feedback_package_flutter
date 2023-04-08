import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => BetterFeedback(
        theme: FeedbackThemeData(
          background: Colors.pinkAccent,
          feedbackSheetColor: Colors.greenAccent,
          feedbackSheetHeight: 0.25,
          activeFeedbackModeColor: Colors.lightBlueAccent,
          sheetIsDraggable: true,
        ),
        child: MaterialApp(
          title: 'Feedback Package Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 30),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 40),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
              ),
            ),
          ),
          home: const HomePage(title: 'Feedback Package Demo'),
        ),
      );
}
