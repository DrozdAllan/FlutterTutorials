import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SlidableDemo extends StatelessWidget {
  const SlidableDemo({Key? key}) : super(key: key);

  static const routeName = "/slidable";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slidable Demo'),
      ),
      body: Column(
        children: [
          Slidable(
            actionPane: SlidableScrollActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Zinzin',
                color: Colors.blue,
                icon: Icons.archive,
                onTap: () => print('Zinzin'),
              ),
            ],
            actionExtentRatio: 1 / 5,
            child: ListTile(
              title: Text('slide me'),
            ),
          ),
          Container(
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Image.asset(
                    'assets/loremTitle.png',
                    width: 150,
                  ),
                ),
                Expanded(
                  child: AnimatedTextKit(animatedTexts: [
                    TyperAnimatedText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    ),
                  ]),
                  //   Text(
                  //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  //     textAlign: TextAlign.left,
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 12,
                  //   ),
                ),
              ],
            ),
          ),
          FlutterLogo(
            size: 100.0,
            style: FlutterLogoStyle.markOnly,
            curve: Curves.bounceInOut,
            duration: Duration(seconds: 5),
          ),
          Container(child: ExpansionPanelDemo()),
          SizedBox(height: 150, width: 400, child: FlowWidget()),
        ],
      ),
    );
  }
}

class FlowWidget extends StatefulWidget {
  const FlowWidget({Key? key}) : super(key: key);

  @override
  _FlowWidgetState createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: MyFlowDelegate(animation: _controller),
      children: [
        IconButton(
            onPressed: () {
              _controller.reverse();
            },
            icon: Icon(Icons.add)),
        IconButton(
            onPressed: () {
              _controller.forward();
            },
            icon: Icon(Icons.subscript)),
      ],
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  MyFlowDelegate({required this.animation}) : super(repaint: animation);
  final Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    // context.paintChild(0, transform: Matrix4.identity());
    // context.paintChild(1, transform: Matrix4.translationValues(0, 50, 0));
    for (int i = 0; i < context.childCount; i++) {
      final offset = i * animation.value * 50;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(offset, offset, 0),
      );
    }
  }

  @override
  bool shouldRepaint(MyFlowDelegate oldDelegate) =>
      animation != oldDelegate.animation;
}

class ExpansionPanelDemo extends StatefulWidget {
  const ExpansionPanelDemo({Key? key}) : super(key: key);

  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  List<bool> _isExpanded = [
    true,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      children: [
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Text("Zinzin");
            },
            body: Text("Now Open!"),
            isExpanded: _isExpanded[0],
            canTapOnHeader: true),
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Text("Zouzou");
            },
            body: Text("Now Open!"),
            isExpanded: _isExpanded[1],
            canTapOnHeader: false),
      ],
      expansionCallback: (i, isOpen) {
        setState(() {
          _isExpanded[i] = !isOpen;
        });
      },
      animationDuration: Duration(seconds: 2),
      dividerColor: Colors.orange,
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(8),
    );
  }
}
