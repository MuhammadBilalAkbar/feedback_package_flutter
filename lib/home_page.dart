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
  Widget build(BuildContext context) =>
  Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Hello from Flutter Developer',
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                BetterFeedback.of(context).show((feedback) {
                  debugPrint(feedback.text);
                });
              },
              child: const Text('Give Feedback'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Provide feedback'),
              onPressed: () {
                BetterFeedback.of(context).show(
                  (feedback) async {
                    // upload to server, share whatever
                    // for example purposes just show it to the user
                    alertFeedbackFunction(
                      context,
                      feedback,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('Provide E-Mail feedback'),
              onPressed: () {
                BetterFeedback.of(context).show((feedback) async {
                  // draft an email and send to developer
                  final screenshotFilePath =
                      await writeImageToStorage(feedback.screenshot);

                  final Email email = Email(
                    body: feedback.text,
                    subject: 'App Feedback',
                    recipients: ['john.doe@flutter.dev'],
                    attachmentPaths: [screenshotFilePath],
                    isHTML: false,
                  );
                  await FlutterEmailSender.send(email);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final outputDirectory = await getTemporaryDirectory();
    final screenshotFilePath = '${outputDirectory.path}/feedback.png';
    final screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }
