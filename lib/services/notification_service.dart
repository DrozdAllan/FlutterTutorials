import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static void initialize(context) async {
// FIRST we create a new instance of the plugin class and
// initialise it with the settings to use for each platform
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// Easy config with android : just provide an icon in android/app/src/main/res/drawable
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_ac_unit');

    // Shitty config with iOs : todo later with https://pub.dev/packages/flutter_local_notifications#initialisation
    // NTM APPLE
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    // config with MacOs : todo later same as iOs
    // final MacOSInitializationSettings initializationSettingsMacOS =
    //     MacOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS,
    );

    // We initialize and add a function that fire when a notification is tapped
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      // the payload here is useless but it's for testing purpose
      if (payload != null) {
        debugPrint('notification payload: $payload');
        inspect(payload);
      }
      await Navigator.pushNamed(
        context, '/chat',
        // arguments: ChatArguments(payload);
      );
    });

    // SECOND we configure a custom notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description:
          'This channel is used for important notifications.', // description
      // importance max is the only way to make a notification appears as heads-up
      importance: Importance.max,
      //   enableLights: true,
      // enableVibration: false, etc...
    );

    // Here we set this custom channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Settings firebase cloud messaging for iOS and web
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    // Actions to do when the user tap the notification
    // If the message contains a data property with a "type" key and "chat" value, navigate to the chat screen
    void _handleMessage(RemoteMessage message) {
      if (message.data['type'] == 'chat') {
        Navigator.pushNamed(
          context, '/chat',
          // arguments: ChatArguments(message),
        );
      }
    }

    // Notification when the app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Notification when the app is on background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Notification when the app is on foreground : you have to create a custom notification channel
    // with maximum importance to display a notification when an android app is on foreground, otherwise nothing happens
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (notification != null) {
        print('Message also contained a notification: $notification');

        // IF THE NOTIFICATION FROM FIREBASE CLOUD MESSAGING IS FOR ANDROID USERS,
        // WE USE THE FLUTTER_LOCAL_NOTIFICATIONS WE SET ABOVE
        if (notification.android != null) {
          print('The notification is displayed to an android device');
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  //   icon: notification.android?.smallIcon,
                  // other properties...
                ),
              ),
              // the payload here is useless but its for testing purpose
              payload: 'item x');
        }
      }
    });
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
    // If you also use the web
    // return FirebaseMessaging.instance.getToken(
    //     vapidKey:
    //         "TO GET IT FIREBASE PROJET / PROJECT SETTINGS / CLOUD MESSAGING / WEB PUSH CERTIFICATES / GENERATE KEY PAIR");
  }
}
