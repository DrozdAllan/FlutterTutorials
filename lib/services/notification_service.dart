import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static void initialize() {
    // for iOS and web
    FirebaseMessaging.instance.requestPermission();

    // notification when the app is already opened
    FirebaseMessaging.onMessage.listen((event) {
      print('A new onMessage event was published!');
    });

    // notification to open the app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
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
