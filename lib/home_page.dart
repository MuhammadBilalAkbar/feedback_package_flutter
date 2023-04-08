import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

import 'feedback_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text('Hello from Flutter Developer'),
              const SizedBox(height: 10),
              ElevatedButton(
                // Feedback from feedback_functions.dart to print in console
                onPressed: () => BetterFeedback.of(context).show(
                  (feedback) => consoleFeedbackFunction(feedback),
                ),
                child: const Text('Print feedback'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                // Feedback from feedback_functions.dart to show alert dialog
                // for example purposes just show it to the user
                onPressed: () => BetterFeedback.of(context).show(
                  (feedback) => alertFeedbackFunction(context, feedback),
                ),
                child: const Text('Show alert dialog'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  BetterFeedback.of(context).show((feedback) async {
                    // save screenshot
                    final screenshotFilePath =
                        await writeImageToStorage(feedback.screenshot);
                    // draft email and send to developer with flutter_email_sender
                    final Email email = Email(
                      body: feedback.text,
                      subject: 'App Feedback Demo',
                      recipients: ['hello@flutter.dev'],
                      attachmentPaths: [screenshotFilePath],
                      isHTML: false,
                    );
                    await FlutterEmailSender.send(email);
                  });
                },
                child: const Text('Provide E-Mail feedback'),
              ),
            ],
          ),
        ),
      );
}

Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  // this method uses path_provider package to save feedback image in files.
  final outputDirectory = await getTemporaryDirectory();
  final screenshotFilePath = '${outputDirectory.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
