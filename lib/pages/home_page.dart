import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => BetterFeedback.of(context).show(
                    (feedback) => consoleFeedbackFunction(feedback),
                  ),
                  child: const Text('Print feedback'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => BetterFeedback.of(context).show(
                    (feedback) => alertFeedbackFunction(context, feedback),
                  ),
                  child: const Text('Show alert dialog'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => showFeedback(context),
                  child: const Text('Provide E-Mail feedback'),
                ),
              ],
            ),
          ),
        ),
      );
}

void showFeedback(BuildContext context) => BetterFeedback.of(context).show(
      (feedback) async {
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
      },
    );

Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
  // this method uses path_provider package to save feedback image in files.
  final outputDirectory = await getTemporaryDirectory();
  final screenshotFilePath = '${outputDirectory.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}

void consoleFeedbackFunction(feedback) {
  debugPrint('Feedback text: ${feedback.text}');
  debugPrint('\nSize of image: ${feedback.screenshot.length}');
  if (feedback.extra != null) {
    debugPrint('Extras: ${feedback.extra!.toString()}');
  }
}

void alertFeedbackFunction(context, feedback) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(feedback.text),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (feedback.extra != null) Text(feedback.extra!.toString()),
                Image.memory(
                  feedback.screenshot,
                  height: 600,
                  width: 500,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
