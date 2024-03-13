// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//
// `EntryFormUtil` is a collection of utility functions to facilitate form evaluations and rendering
//
class EntryFormUtil {
  //
  // `isEmailValid` is a helper function that validates emails
  //  @param: email: this is the `String` email to be validated
  // @return: a `bool` value to indicate wether or not the email is valid
  //
  static bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  //
  // `isPhoneNumberValid` is a helper function that validates phoneNumbers
  //  @param: phoneNumber: this is the `String` phoneNumber to be validated
  // @return: a `bool` value to indicate wether or not the phoneNumber is valid
  //
  static isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.isEmpty
        ? true
        : RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$').hasMatch(phoneNumber);
  }

  //
  // `getCurrentLocation` is a helper function for getting the current geographic location
  // @return: the method returns `Position` that is of current for the device
  //
  static Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  //
  // `formattedDateTimeIntoString` is a helper function converting `DateTime` to string format
  //  @param: date: this is a `DateTime` object to be formatted.
  //  @return: the method return a `String` representation of the input date.
  //
  static String formattedDateTimeIntoString(DateTime date) {
    return date.toIso8601String().split('T')[0].trim();
  }

  //
  // `getDateIntoDateTimeFormat` is a helper function converting `String` date into `DateTime` object
  //  @param: date: this is a `String` object to be formatted.
  //  @return: the method return a `DateTime` representation of the input date.
  //
  static DateTime getDateIntoDateTimeFormat(String date) {
    return DateTime.parse(date);
  }

  //
  // `formattedTimeOfDayIntoString` is a helper function that converts `TimeOfDay` into a `String` representation
  // @param: timeOfDay: this is a `TimeOfDay` to be converted
  // @return: the method return a `String` representation of the input time.
  //
  static String formattedTimeOfDayIntoString(TimeOfDay timeOfDay) {
    String hour =
        timeOfDay.hour > 9 ? '${timeOfDay.hour}' : '0${timeOfDay.hour}';
    String minute =
        timeOfDay.minute > 9 ? '${timeOfDay.minute}' : '0${timeOfDay.minute}';
    return '$hour:$minute';
  }

  //
  // `getTimeIntoDTimeOfDayFormat` is a helper function that converts `String` into a `TimeOfDay` object
  // @param: timeOfDay: this is a `String`  time to be converted
  // @return: the method return a `TimeOfDay` representation of the input time.
  //
  static TimeOfDay getTimeIntoDTimeOfDayFormat(String time) {
    List<String> timeArray = time.split(':');
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
