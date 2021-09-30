import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/database/duckBox.dart';
import 'package:mynewapp/screens/favorites/favorites.dart';
import 'package:mynewapp/screens/flutterFire/chat.dart';
import 'package:mynewapp/screens/flutterFire/chatScreen.dart';
import 'package:mynewapp/screens/flutterFire/flutterFire.dart';
import 'package:mynewapp/screens/hive/hive.dart';
import 'package:mynewapp/screens/home/home.dart';
import 'package:mynewapp/screens/pairWords/pairWords.dart';
import 'package:mynewapp/screens/riverpod/riverpod.dart';
import 'package:mynewapp/screens/userApiTest/userApiTest.dart';
import 'package:mynewapp/screens/moviesTitle/moviesTitle.dart';
import 'package:mynewapp/screens/moviesTitle/moviesTitleResult.dart';
import 'package:mynewapp/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DuckBox.init();
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      theme: myTheme,
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
              return FadeTransition(
                opacity: animation,
                child: child,
              );
              // var begin = Offset(0.0, 1.0);
              // var end = Offset.zero;
              // var curve = Curves.ease;
              // var tween = Tween(begin: begin, end: end)
              //     .chain(CurveTween(curve: curve));
              // return SlideTransition(
              //   position: animation.drive(tween),
              //   child: child,
              // );
            });
      case Riverpod.routeName: // '/riverpod'
        return MaterialPageRoute(builder: (context) => Riverpod());
      case HiveTuto.routeName: // '/hive'
        return MaterialPageRoute(builder: (context) => HiveTuto());
      case FlutterFire.routeName: // '/flutterFire'
        return MaterialPageRoute(builder: (context) => FlutterFire());
      case Chat.routeName: // '/flutterFire'
        return MaterialPageRoute(builder: (context) => Chat());
      case ChatScreen.routeName: // '/flutterFire'
        return MaterialPageRoute(
            builder: (context) => ChatScreen(
                  peerUid: settings.arguments,
                ));
      case UserApiTest.routeName: // '/userApiTest'
        return MaterialPageRoute(builder: (context) => UserApiTest());
      case MoviesTitle.routeName: // '/moviesTitle'
        return MaterialPageRoute(builder: (context) => MoviesTitle());
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
