import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => BetterFeedback(
        theme: FeedbackThemeData(
          background: Colors.pinkAccent,
          feedbackSheetColor: Colors.white,
          feedbackSheetHeight: 0.25,
          activeFeedbackModeColor: Colors.lightBlueAccent,
          sheetIsDraggable: true,
          bottomSheetDescriptionStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        child: MaterialApp(
          title: 'Feedback Package Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 30),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontSize: 24
                fontWeight: FontWeight.bold,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 24),
                minimumSize: const Size(200, 50),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 24),
                minimumSize: const Size(200, 50),
              ),
            ),
          ),
          home: const HomePage(title: 'Feedback Package Demo'),
        ),
      );
}
