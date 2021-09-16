import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynewapp/screens/favorites/favorites.dart';
import 'package:mynewapp/screens/home/home.dart';
import 'package:mynewapp/screens/pairWords/pairWords.dart';
import 'package:mynewapp/screens/riverpodHive/riverpodHive.dart';
import 'package:mynewapp/screens/userApiTest/userApiTest.dart';
import 'package:mynewapp/screens/moviesTitle/moviesTitle.dart';
import 'package:mynewapp/screens/moviesTitle/moviesTitleResult.dart';

void main() => runApp(
      // For widgets to be able to read providers, we need to wrap the entire
      // application in a "ProviderScope" widget.
      // This is where the state of our providers will be stored.
      ProviderScope(child: MyApp()),
    );

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
      case RiverpodHive.routeName: // '/research'
        return MaterialPageRoute(builder: (context) => RiverpodHive());
      case UserApiTest.routeName:
        return MaterialPageRoute(builder: (context) => UserApiTest());
      case MoviesTitle.routeName:
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
