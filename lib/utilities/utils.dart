import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatTimeShort(int time) {
    if (time == null && time > 0) return '';

    Duration duration = Duration(seconds: time.round());

    String timeDisplay = "${duration.inSeconds.remainder(60)}s";

    if (time >= 60) {
      var minutes = duration.inMinutes > 0 ? '${duration.inMinutes}m' : '';
      var seconds = duration.inSeconds.remainder(60) > 0
          ? ':${duration.inSeconds.remainder(60)}s'
          : '';
      timeDisplay = "$minutes$seconds";
    }

    // more than 1 hour
    if (time >= 60 * 60) {
      timeDisplay = "${duration.inHours}h:${duration.inMinutes.remainder(60)}m";
    }

    // more than 1 day
    if (time >= 60 * 60 * 24) {
      timeDisplay = "${duration.inDays}d:${duration.inHours}h";
    }

    return timeDisplay;
  }

  static String getLoadingScreenText() {
    String result;

    List<String> loadingScreenTexts = [
      'Make it count!',
      'Until the last rep!',
      'Hard work pays off',
      'Warming up...',
      'Executing the last 2 reps'
    ];
    final _random = new Random();
    result = loadingScreenTexts[_random.nextInt(loadingScreenTexts.length)];

    return result;
  }

  static double buttonWidth(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var containerWidth = screenWidth - screenWidth * 0.6;

    return containerWidth;
  }

  static String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  static String formatTimeSeconds(int secs) {
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');

    var hoursString = hours != '00' ? '$hours:' : '';

    return "$hoursString$minutes:$seconds";
  }

  static String formatDate(DateTime dateTime) {
    var formatter = DateFormat('dd MMM, yyyy').add_jm();
    var formattedDate = formatter.format(dateTime).toUpperCase();

    return formattedDate;
  }
}
