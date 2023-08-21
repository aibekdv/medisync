import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:medisync/feature/data/models/models.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Initialize notifications plugin for Android
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('notification_icon');

    // Initialize notifications plugin for iOS
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> scheduleMedicationReminders(List<MedicationModel> reminders,
      {required String reminderDesc}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    final String timeZone = await FlutterTimezone.getLocalTimezone();
    final tz.Location location = tz.getLocation(timeZone);

    final now = tz.TZDateTime.now(location);
    final today = tz.TZDateTime(location, now.year, now.month, now.day);

    for (var reminder in reminders) {
      for (var time in reminder.times) {
        for (var selectedDay in reminder.selectedDays) {
          final scheduledDate = tz.TZDateTime(
            location,
            today.year,
            today.month,
            today.day,
            time.hour,
            time.minute,
          ).add(Duration(days: selectedDay - today.weekday));

          if (scheduledDate.isBefore(now)) {
            continue;
          }

          await flutterLocalNotificationsPlugin.zonedSchedule(
            reminders.indexOf(reminder) * reminder.times.length * 7 +
                time.hour * 60 +
                time.minute +
                selectedDay -
                today.weekday,
            reminder.name,
            reminderDesc,
            scheduledDate,
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.wallClockTime,
          );
        }
      }
    }
  }
}
