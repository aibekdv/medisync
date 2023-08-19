import 'package:flutter/material.dart';

List<TimeOfDay> parseTimesFromString(String timesString) {
  List<String> timeStrings = timesString.split(',');
  List<TimeOfDay> times = [];

  for (String timeString in timeStrings) {
    List<String> components = timeString.split(':');
    int hour = int.parse(components[0]);
    int minute = int.parse(components[1]);
    TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
    times.add(time);
  }

  return times;
}

List<int> parseSelectedDaysFromString(String selectedDaysString) {
  List<String> dayStrings = selectedDaysString.split(',');
  List<int> selectedDays = [];

  for (String dayString in dayStrings) {
    selectedDays.add(int.parse(dayString));
  }

  return selectedDays;
}
