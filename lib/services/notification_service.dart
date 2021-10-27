import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mynewapp/models/firestoreUser.dart';

class NotificationService {
  static void initialize(context) async {
// there are 2 big packages settings here

    //                                 FLUTTER_LOCAL_NOTIFICATIONS SETTINGS

    // FIRST we create a new instance of the plugin class and
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // Easy config with android : just provide an icon in android/app/src/main/res/drawable
    const AndroidInitializationSettings initializationSettingsAndroid =
        // you shouldn't use the mipmap, reports of bugs
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Handle heads-up notifications for iOS older than 10+ (Sept 2016)
    void onDidReceiveLocalNotification(
        int id, String? title, String? body, String? payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title!),
          content: Text(body!),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, '/chatScreen',
                    arguments: ('caca'));
              },
            ),
          ],
        ),
      );
    }

    // Config with iOs by default it asks for all request like so
    // if you want to request permissions at a later point in the iOS app, set all false
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);

    // Then we initialise the plugin with the settings to use for each platform
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );

    // Then we add a function that fire when a notification is tapped on Android and iOS 10+
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('the id of the user you get the msg from is : $payload');
        await Navigator.pushNamed(
          context,
          '/chatScreen',
          arguments: payload,
        );
      }
    });

    final Int64List vibrationPattern = new Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // name
            channelDescription:
                'This channel is used for important notifications.', // description
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            sound: RawResourceAndroidNotificationSound(
                'slow_spring_board_notif_sound_10db'),
            enableVibration: true,
            vibrationPattern: vibrationPattern,
            ticker: 'ticker');

    final IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(
      presentAlert:
          true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge:
          true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound:
          true, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      sound:
          '/pathtoIosSound', // Specifics the file path to play (only from iOS 10 onwards)
      badgeNumber: 1, // The application's icon badge number
      // attachments: List<IOSNotificationAttachment>?, // (only from iOS 10 onwards)
      subtitle: 'Secondary description', // (only from iOS 10 onwards)
      // threadIdentifier: String? // (only from iOS 10 onwards)
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetails,
    );

    //                                 FIREBASE CLOUD MESSAGING SETTINGS

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

    // Actions to do when the user tap a tray notification
    // If the message contains a data property with a "type" key and "chat" value, navigate to the chat screen
    void _handleMessage(RemoteMessage message) {
      if (message.data['type'] == 'chat') {
        print('the notification you tapped has the type value : chat');
        Navigator.pushNamed(
          context, '/chat',
          // arguments: ChatArguments(message),
        );
      }
    }

    // Tray notification when the app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Tray notification when the app is on background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Notifications when the app is on foreground : you have to create a custom notification channel
    // with maximum importance to display a notification when an android app is on foreground, otherwise nothing happens
    // Here you can perform a task when you receive a message but no notifications will be shown without flutter_local_notifications setup
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // if it's only a notification
      RemoteNotification? notification = message.notification;
      // if there is also data to the FCM
      Map<String, dynamic> data = message.data;

      debugPrint('Got a message whilst in the foreground!');
      //   print('Message data : $data');

      if (data['fullSenderObjectData'] != null) {
        final fullSenderObjectData = jsonDecode(data['fullSenderObjectData']);
        print('fullSenderObjectData : $fullSenderObjectData');

        // this way you get the type-safe FirestoreUser model, but theres all
        // the user's info, it's too much, you should only send what you need with
        // the cloud Functions in index.js
        FirestoreUser firestoreUserSenderData =
            FirestoreUser.fromMap(jsonDecode(data['fullSenderObjectData']));
      }

      if (notification != null) {
        print('Message also contained a notification: $notification');

        // In this project we only create headsup notifications for android because firebase_messaging isnt setup for ios, so line below:
        if (notification.android != null) {
          print('The notification is displayed to an android device');
          flutterLocalNotificationsPlugin.show(notification.hashCode,
              notification.title, notification.body, platformChannelSpecifics,
              // the payload is the data contained in the Heads-up notification
              // payload: firestoreUserSenderData.uid);
              payload: "TuY9gtznoDgb6eYE9i1Se8DHrND3");
        }
      }
    });
  }
}
