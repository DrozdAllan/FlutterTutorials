import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mynewapp/models/firestoreUser.dart';

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
    //         requestSoundPermission: false,
    // requestBadgePermission: false,
    // requestAlertPermission: false,
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    // config with MacOs : todo later same as iOs
    // final MacOSInitializationSettings initializationSettingsMacOS =
    //     MacOSInitializationSettings();

//     void onDidReceiveLocalNotification(
//     int id, String title, String body, String payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title),
//       content: Text(body),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: Text('Ok'),
//           onPressed: () async {
//             Navigator.of(context, rootNavigator: true).pop();
//             await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SecondScreen(payload),
//               ),
//             );
//           },
//         ),
//       ],
//     ),
//   );})

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
      //   macOS: osef,
    );

    // We initialize and add a function that fire when a notification is tapped
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

    // Get the notifs permissions for iOs
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions(
    //       alert: true,
    //       badge: true,
    //       sound: true,
    //     );

    // Here we set this custom channel for android
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

    // Actions to do when the user tap a System notification
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

    // System Notification when the app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // System Notification when the app is on background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Notification when the app is on foreground : you have to create a custom notification channel
    // with maximum importance to display a notification when an android app is on foreground, otherwise nothing happens
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // if it's only a notification
      RemoteNotification? notification = message.notification;
      // if there is also data to the FCM
      Map<String, dynamic> data = message.data;

      debugPrint('Got a message whilst in the foreground!');
      //   print('Message data : $data');

      final fullSenderObjectData = jsonDecode(data['fullSenderObjectData']);
      print('fullSenderObjectData : $fullSenderObjectData');

      // this way you get the type-safe FirestoreUser model, but theres all
      // the user's info, it's too much, you should only send what you need with
      // the cloud Functions in index.js
      FirestoreUser firestoreUserSenderData =
          FirestoreUser.fromMap(jsonDecode(data['fullSenderObjectData']));

      inspect(firestoreUserSenderData);

      if (notification != null) {
        print('Message also contained a notification: $notification');

        // In this project we only create headsup notifications for android, so line below:
        if (notification.android != null) {
          print('The notification is displayed to an android device');
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                // check https://pub.dev/documentation/flutter_local_notifications/latest/flutter_local_notifications/AndroidNotificationDetails-class.html
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  //   icon: notification.android?.smallIcon,
                  // lots of other properties...
                ),
                iOS: IOSNotificationDetails(
                    //  presentAlert: bool?, Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                    // presentBadge: bool?,  Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                    // presentSound: bool?, Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
                    // sound: String?, Specifics the file path to play (only from iOS 10 onwards)
                    // badgeNumber: int?, The application's icon badge number
                    // attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
                    // subtitle: String?, Secondary description  (only from iOS 10 onwards)
                    // threadIdentifier: String? (only from iOS 10 onwards)
                    ),
              ),
              // the payload is the data contained in the Heads-up notification
              payload: firestoreUserSenderData.uid);
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
