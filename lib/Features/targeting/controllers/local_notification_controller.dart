import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hamrah_salamat/Features/targeting/classes/target.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleWeeklyNotifications({
    required String fullname,
    required int day,
    required List<Time> times,
  }) async {
    for (int i = 0; i < times.length; i++) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        'یادآور هدف',
        '$fullname عزیز اهداف خود را فراموش نکنید!',
        _nextInstanceOfSaturdayNinePM(
          day: day,
          time: times[i],
        ),
        const NotificationDetails(
          android: AndroidNotificationDetails('hamrah_salamt_1', 'Reminder Alerts Hamrah Salamat'),
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfSaturdayNinePM({
    required int day,
    required Time time,
  }) {
    tz.TZDateTime scheduledDate = _nextInstanceOfWeekdayTime(day, time.hour!, time.minute!);
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, int hour, int minute) {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }
}
