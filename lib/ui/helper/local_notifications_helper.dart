import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prayertimes/generated/locale_keys.g.dart';
import 'package:prayertimes/models/received_notification.dart';
import 'package:prayertimes/ui/widgets/bottomBarWidgets/notification_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/subjects.dart';

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var initializationSettingsAndroid = AndroidInitializationSettings('logo');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async {
      didReceiveLocalNotificationSubject.add(ReceivedNotification(
          id: id, title: title, body: body, payload: payload));
    },
  );
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String payload) async {
      if (payload != "5") {
        debugPrint('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    },
  );
}

void requestIOSPermissions(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

void configureDidReceiveLocalNotificationSubject(BuildContext context) {
  didReceiveLocalNotificationSubject.stream.listen(
    (ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                if (receivedNotification.payload == "5") {
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NotificationDailog(payload: receivedNotification.payload);
                    },
                  );
                }
              },
            )
          ],
        ),
      );
    },
  );
}

void configureSelectNotificationSubject(BuildContext context) {
  selectNotificationSubject.stream.listen(
    (String payload) async {
      if (payload == "5") {
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return NotificationDailog(payload: payload);
          },
        );
      }
    },
  );
}

Future<void> showNotificationData(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int id,
    String title,
    String body,
    [String payload]) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '2', 'On/Off', 'On/Off Notifications',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(id, title, body, platformChannelSpecifics, payload: payload);
}

Future<void> _schedulePrayerNotificationWithSound(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int id,
    String title,
    String body,
    DateTime scheduledDate,
    [String payload]) async {
  var time =
      Time(scheduledDate.hour, scheduledDate.minute, scheduledDate.second);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '0', 'Prayer times and ezan', 'Prayer Times And Ezan Notification',
      importance: Importance.Max,
      priority: Priority.Max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('ezan'),
      enableVibration: true,
      channelShowBadge: true,
      enableLights: true,
      visibility: NotificationVisibility.Public,
      category: "Reminder");
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(sound: 'ezan.aiff');
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      id, title, body, time, platformChannelSpecifics,
      payload: payload);
}

Future<void> schedulePrayerNotificationsWithSound(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    List<DateTime> prayerTimes) async {
  _schedulePrayerNotificationWithSound(
      flutterLocalNotificationsPlugin,
      0,
      LocaleKeys.imsak.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.imsak.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[0],
      '0');
  _schedulePrayerNotificationWithSound(
      flutterLocalNotificationsPlugin,
      1,
      LocaleKeys.sun.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.sun.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[1],
      '1');
  _schedulePrayerNotificationWithSound(
      flutterLocalNotificationsPlugin,
      2,
      LocaleKeys.noon.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.noon.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[2],
      '2');
  _schedulePrayerNotificationWithSound(
      flutterLocalNotificationsPlugin,
      3,
      LocaleKeys.afternoon.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.afternoon.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[3],
      '3');
  _schedulePrayerNotificationWithSound(
      flutterLocalNotificationsPlugin,
      4,
      LocaleKeys.evening.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.evening.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[4],
      '4');
  _schedulePrayerNotificationWithSound(
      flutterLocalNotificationsPlugin,
      5,
      LocaleKeys.moon.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.moon.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[5],
      '5');
}

Future<void> _schedulePrayerNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int id,
    String title,
    String body,
    DateTime scheduledDate,
    [String payload]) async {
  var time =
      Time(scheduledDate.hour, scheduledDate.minute, scheduledDate.second);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '0', 'Prayer times', 'Prayer Times Notification',
      importance: Importance.Max,
      priority: Priority.Max,
      playSound: true,
      enableVibration: true,
      channelShowBadge: true,
      enableLights: true,
      visibility: NotificationVisibility.Public,
      category: "Reminder");
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      id, title, body, time, platformChannelSpecifics,
      payload: payload);
}

Future<void> schedulePrayerNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    List<DateTime> prayerTimes) async {
  _schedulePrayerNotification(
      flutterLocalNotificationsPlugin,
      0,
      LocaleKeys.imsak.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.imsak.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[0],
      '0');
  _schedulePrayerNotification(
      flutterLocalNotificationsPlugin,
      1,
      LocaleKeys.noon.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.noon.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[2],
      '1');
  _schedulePrayerNotification(
      flutterLocalNotificationsPlugin,
      2,
      LocaleKeys.afternoon.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.afternoon.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[3],
      '2');
  _schedulePrayerNotification(
      flutterLocalNotificationsPlugin,
      3,
      LocaleKeys.evening.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.evening.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[4],
      '3');
  _schedulePrayerNotification(
      flutterLocalNotificationsPlugin,
      4,
      LocaleKeys.moon.tr() + ' ' + LocaleKeys.reminder.tr(),
      LocaleKeys.moon.tr() + ' ' + LocaleKeys.reminder.tr(),
      prayerTimes[5],
      '4');
}

Future<void> checkPendingNotificationRequests(BuildContext context,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.80,
          child: ListView.builder(
              itemCount: pendingNotificationRequests.length,
              itemBuilder: (BuildContext context, int i) {
                return Text(pendingNotificationRequests[i].id.toString() +
                    ' ' +
                    pendingNotificationRequests[i].title);
              }),
        ),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> turnOffNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  await flutterLocalNotificationsPlugin.cancelAll();
}
