import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mynewapp/screens/bubble/navbar.dart';

class Bubble extends StatefulWidget {
  const Bubble({Key? key}) : super(key: key);

  static const routeName = '/bubble';

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  late List<NavBarItemData> _navBarItems;
  int _selectedNavIndex = 0;

  late List<Widget> _viewsByIndex;

  @override
  void initState() {
    super.initState();
    _navBarItems = [
      NavBarItemData("Home", Icons.hail, 110, Color(0xff01b87d)),
      NavBarItemData("Gallery", Icons.image, 110, Color(0xff594ccf)),
      NavBarItemData("Camera", Icons.camera, 115, Color(0xff09a8d9)),
      NavBarItemData("Likes", Icons.favorite, 100, Color(0xffcf4c7a)),
      NavBarItemData("Saved", Icons.save, 105, Color(0xfff2873f)),
    ];
    _viewsByIndex = <Widget>[
      HomePage(),
      GalleryPage(),
      CameraPage(),
      LikesPage(),
      SavePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var accentColor = _navBarItems[_selectedNavIndex].selectedColor;

    //Create custom navBar, pass in a list of buttons, and listen for tap event
    var navBar = NavBar(
      items: _navBarItems,
      itemTapped: _handleNavBtnTapped,
      currentIndex: _selectedNavIndex,
    );
    //Display the correct child view for the current index
    var contentView =
        _viewsByIndex[min(_selectedNavIndex, _viewsByIndex.length - 1)];
    //Wrap our custom navbar + contentView with the app Scaffold
    return Scaffold(
      backgroundColor: Color(0xffE6E6E6),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          //Wrap the current page in an AnimatedSwitcher for an easy cross-fade effect
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            //Pass the current accent color down as a theme, so our overscroll indicator matches the btn color
            child: Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.fromSwatch()
                      .copyWith(secondary: accentColor)),
              child: contentView,
            ),
          ),
        ),
      ),
      bottomNavigationBar: navBar, //Pass our custom navBar into the scaffold
    );
  }

  void _handleNavBtnTapped(int index) {
    //Save the new index and trigger a rebuild
    setState(() {
      //This will be passed into the NavBar and change it's selected state, also controls the active content page
      _selectedNavIndex = index;
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LikesPage extends StatelessWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SavePage extends StatelessWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
