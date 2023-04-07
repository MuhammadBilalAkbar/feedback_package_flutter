import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

/// Prints the given feedback to the console.
/// This is useful for debugging purposes.
void consoleFeedbackFunction(
  BuildContext context,
  UserFeedback feedback,
) {
  debugPrint('Feedback text:');
  debugPrint(feedback.text);
  debugPrint('Size of image: ${feedback.screenshot.length}');
  if (feedback.extra != null) {
    debugPrint('Extras: ${feedback.extra!.toString()}');
  }
}

/// Shows an [AlertDialog] with the given feedback.
/// This is useful for debugging purposes.
void alertFeedbackFunction(
  BuildContext outerContext,
  UserFeedback feedback,
) {
  showDialog<void>(
    context: outerContext,
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
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}
