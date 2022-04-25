import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppUtil {
  static Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  static String formattedDateTimeIntoString(DateTime date) {
    return date.toIso8601String().split('T')[0].trim();
  }

  static DateTime getDateIntoDateTimeFormat(String date) {
    return DateTime.parse(date);
  }

  static String getUid() {
    Random rnd = Random();
    const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const allowedChars = '0123456789' + letters;
    const numberOfCodePoints = allowedChars.length;
    const codeSize = 11;
    String uid;
    int charIndex = (rnd.nextInt(10) / 10 * letters.length).round();
    uid = letters.substring(charIndex, charIndex + 1);
    for (int i = 1; i < codeSize; ++i) {
      charIndex = (rnd.nextInt(10) / 10 * numberOfCodePoints).round();
      uid += allowedChars.substring(charIndex, charIndex + 1);
    }
    return uid;
  }
  
  static String formattedTimeOfDayIntoString(TimeOfDay timeOfDay) {
    String hour =
        timeOfDay.hour > 9 ? '${timeOfDay.hour}' : '0${timeOfDay.hour}';
    String minute =
        timeOfDay.minute > 9 ? '${timeOfDay.minute}' : '0${timeOfDay.minute}';
    return '$hour:$minute';
  }

  static TimeOfDay getTimeIntoDTimeOfDayFormat(String time) {
    List<String> timeArray = time.split(":");
    int hour = TimeOfDay.now().hour;
    int minute = TimeOfDay.now().minute;
    if (timeArray.length > 1) {
      try {
        hour = int.parse(timeArray[0]);
        minute = int.parse(timeArray[1]);
      } catch (e) {
        //
      }
    }
    return TimeOfDay(hour: hour, minute: minute);
  }
}
