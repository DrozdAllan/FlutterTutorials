import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviesTitle extends StatefulWidget {
  const MoviesTitle({Key? key}) : super(key: key);

  static const routeName = '/moviesTitle';

  @override
  State<MoviesTitle> createState() => _MoviesTitleState();
}

class _MoviesTitleState extends State<MoviesTitle> {
  final cityController = TextEditingController();
  static const _url =
      'https://mysterious-woodland-51583.herokuapp.com/api/docs';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // buildMap(),
          // buildBottomNavigationBar(),
          buildFloatingSearchBar(context, _url),
        ],
      ),
    );
  }
}

Widget buildFloatingSearchBar(context, _url) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  return FloatingSearchBar(
    hint: 'Search for a movie',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    width: isPortrait ? 600 : 500,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () async {
            await canLaunch(_url)
                ? await launch(_url)
                : throw 'Could not launch $_url';
          },
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );
    },
  );
}
