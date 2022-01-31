import 'package:camera/camera.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/database/duckBox.dart';
import 'package:mynewapp/screens/Animations/Animations.dart';
import 'package:mynewapp/screens/bubble/bubble.dart';
import 'package:mynewapp/screens/cameraDemo/cameraDemo.dart';
// import 'package:mynewapp/screens/cameraDemo/emotionDetector.dart';
// import 'package:mynewapp/screens/cameraDemo/stuffDetector.dart';
import 'package:mynewapp/screens/colorPicker/colorPicker.dart';
import 'package:mynewapp/screens/drawerDemo/drawerDemo.dart';
import 'package:mynewapp/screens/favorites/favorites.dart';
import 'package:mynewapp/screens/flashTuto/flashTuto.dart';
import 'package:mynewapp/screens/flutterFire/chat.dart';
import 'package:mynewapp/screens/flutterFire/chatScreen.dart';
import 'package:mynewapp/screens/flutterFire/flutterFire.dart';
import 'package:mynewapp/screens/formBuilderTuto/formBuilderTuto.dart';
import 'package:mynewapp/screens/hive/duckDetails.dart';
import 'package:mynewapp/screens/hive/hive.dart';
import 'package:mynewapp/screens/home/home.dart';
import 'package:mynewapp/screens/location/geolocator.dart';
import 'package:mynewapp/screens/maps/maps.dart';
import 'package:mynewapp/screens/pairWords/pairWords.dart';
import 'package:mynewapp/screens/riverpod/riverpod.dart';
import 'package:mynewapp/screens/sfx/sfx.dart';
import 'package:mynewapp/screens/sharedPreferencesDemo/sharedPreferencesDemo.dart';
import 'package:mynewapp/screens/slidableDemo/slidableDemo.dart';
import 'package:mynewapp/screens/tabDemo/tabDemo.dart';
import 'package:mynewapp/screens/userApiTest/userApiTest.dart';
import 'package:mynewapp/screens/moviesTitle/moviesTitle.dart';
import 'package:mynewapp/screens/moviesTitle/moviesTitleResult.dart';
import 'package:mynewapp/style.dart';

// notification when the app is on background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// If you're going to use other Firebase services in the background, such as Firestore,
// make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
  print('Got a message whilst in the background!');
  print('Handling a background message: ${message.messageId}');
}

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // to try the crash
//   FirebaseCrashlytics.instance.crash();
  await DuckBox.init();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(
    EasyDynamicThemeWidget(
      child: ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      //   theme: FlexColorScheme.light(scheme: FlexScheme.mango).toTheme,
      darkTheme: myDarkTheme,
      //   darkTheme: FlexColorScheme.dark(scheme: FlexScheme.sakura).toTheme,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      initialRoute: Home.routeName,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Home.routeName: // '/'
        return MaterialPageRoute(builder: (context) => Home());
      case PairWords.routeName: // '/pairWords'
        return MaterialPageRoute(builder: (context) => PairWords());
      case Favorites.routeName: // '/fav'
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                Favorites(favs: settings.arguments as Set<WordPair>),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              //   return FadeTransition(
              //     opacity: animation,
              //     child: child,
              //   );
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            });
      case Riverpod.routeName: // '/riverpod'
        return MaterialPageRoute(builder: (context) => Riverpod());
      case ColorPickerTuto.routeName: // '/colorPicker'
        return MaterialPageRoute(builder: (context) => ColorPickerTuto());
      case FlashTuto.routeName: // '/flashTuto'
        return MaterialPageRoute(builder: (context) => FlashTuto());
      case SharedPreferencesDemo.routeName: // '/sharedPref'
        return MaterialPageRoute(builder: (context) => SharedPreferencesDemo());
      case CameraDemo.routeName: // '/cameraDemo'
        return MaterialPageRoute(builder: (context) => CameraDemo());
      //   case EmotionDetector.routeName: // '/emotion'
      //     return MaterialPageRoute(
      //         builder: (context) => EmotionDetector(cameras));
      //   case StuffDetector.routeName: // '/stuff'
      //     return MaterialPageRoute(builder: (context) => StuffDetector(cameras));
      case HiveTuto.routeName: // '/hive'
        return MaterialPageRoute(builder: (context) => HiveTuto());
      case DuckDetails.routeName: // '/duckDetails'
        return MaterialPageRoute(
          builder: (context) => DuckDetails(
            ducksListIndex: settings.arguments as int,
          ),
        );
      case FormBuilderTuto.routeName: // '/formBuilderTuto'
        return MaterialPageRoute(builder: (context) => FormBuilderTuto());
      case GeolocatorDemo.routeName: // '/geolocator'
        return MaterialPageRoute(builder: (context) => GeolocatorDemo());
      case SlidableDemo.routeName: // '/slidable'
        return MaterialPageRoute(builder: (context) => SlidableDemo());
      case TabDemo.routeName: // '/tab'
        return MaterialPageRoute(builder: (context) => TabDemo());
      case DrawerDemo.routeName: // '/drawer'
        return MaterialPageRoute(builder: (context) => DrawerDemo());
      case FlutterFire.routeName: // '/flutterFire'
        return MaterialPageRoute(builder: (context) => FlutterFire());
      case Chat.routeName: // '/chat'
        return MaterialPageRoute(builder: (context) => Chat());
      case ChatScreen.routeName: // '/chatScreen'
        return MaterialPageRoute(
          builder: (context) => ChatScreen(
            peerUid: settings.arguments,
          ),
        );
      case UserApiTest.routeName: // '/userApiTest'
        return MaterialPageRoute(builder: (context) => UserApiTest());
      case MoviesTitle.routeName: // '/moviesTitle'
        return MaterialPageRoute(builder: (context) => MoviesTitle());
      case Animations.routeName: // '/animations'
        return MaterialPageRoute(builder: (context) => Animations());
      case Maps.routeName: // '/maps'
        return MaterialPageRoute(builder: (context) => Maps());
      case Sfx.routeName: // '/sfx'
        return MaterialPageRoute(builder: (context) => Sfx());
      case Bubble.routeName: // '/bubble'
        return MaterialPageRoute(builder: (context) => Bubble());
      case MoviesTitleResult.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                MoviesTitleResult(result: settings.arguments));
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
