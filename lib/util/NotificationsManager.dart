import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationModel {
  // for Android
  String channelId, channelTitle, channelBody, ticker;
  int id;
  String title, body, payload;
}

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings andInitSettings;
  IOSInitializationSettings iosInitSettings;
  InitializationSettings initSettings;

  void onNotificationOpen(payload) {
    print(payload);
  }

  void init() async {
    andInitSettings = AndroidInitializationSettings('app_icon');
    iosInitSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {
      /*return CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
              child: Text('Ok'),
              isDefaultAction: true,
              onPressed: () {
                print(payload);
              }),
        ],
      );*/
    });
    initSettings =
        InitializationSettings(android: andInitSettings, iOS: iosInitSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (String payload) {
      onNotificationOpen(payload);
      return;
    });
  }

  Future<void> notification(NotificationModel notification) async {
    AndroidNotificationDetails andNotificationDetails =
        AndroidNotificationDetails(notification.channelId,
            notification.channelTitle, notification.channelBody,
            priority: Priority.high,
            importance: Importance.max,
            ticker: notification.ticker);
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: andNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(notification.id,
        notification.title, notification.body, notificationDetails,
        payload: notification.payload);
  }
}
