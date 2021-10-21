import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableDemo extends StatelessWidget {
  const SlidableDemo({Key? key}) : super(key: key);

  static const routeName = "/slidable";

  @override
  Widget build(BuildContext context) {
    List<bool> _isOpen = [
      false,
      false,
      false,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Slidable Demo'),
      ),
      body: ListView(
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
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: ExpansionPanelList(
              children: [
                ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Text("Zinzin");
                    },
                    body: Text("Now Open!"),
                    isExpanded: _isOpen[0]),
              ],
              expansionCallback: (i, isOpen) {
                _isOpen[i] = !isOpen;
              },
            ),
          ),
        ],
      ),
    );
  }
}
