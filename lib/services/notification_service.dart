import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static void initialize(context) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // for iOS and web
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // If the message contains a data property with a "type" of "chat", navigate to a chat screen
    void _handleMessage(RemoteMessage message) {
      if (message.data['type'] == 'chat') {
        Navigator.pushNamed(
          context, '/chat',
          // arguments: ChatArguments(message),
        );
      }
    }

//TODO: check the notification channels to try to display a notif when app is in foreground https://firebase.flutter.dev/docs/messaging/notifications/#foreground-notifications

//TODO: the index.js of the firebase functions works perfectly fine with the P8 but doesn't send anything to the P30 nor debug console messages, so it may be a problem with android 10

    // notification when the app is on foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      inspect(message);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Get any messages which caused the application to open from a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // If the user press the notification when the app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
    // If you also use the web
    // return FirebaseMessaging.instance.getToken(
    //     vapidKey:
    //         "TO GET IT FIREBASE PROJET / PROJECT SETTINGS / CLOUD MESSAGING / WEB PUSH CERTIFICATES / GENERATE KEY PAIR");
  }
}
