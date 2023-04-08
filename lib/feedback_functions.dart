import 'package:flutter/material.dart';

// Prints the given feedback to the console.
// This is useful for debugging purposes.
void consoleFeedbackFunction(feedback) {
  debugPrint('Feedback text: ${feedback.text}');
  debugPrint('\nSize of image: ${feedback.screenshot.length}');
  if (feedback.extra != null) {
    debugPrint('Extras: ${feedback.extra!.toString()}');
  }
}

// Shows an [AlertDialog] with the given feedback.
// This is useful for debugging purposes.
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
