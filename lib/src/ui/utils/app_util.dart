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
