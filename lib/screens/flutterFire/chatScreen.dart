import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mynewapp/services/database_service.dart';

class ChatScreen extends StatelessWidget {
  final peerUid;
  const ChatScreen({Key? key, required this.peerUid}) : super(key: key);

  static const routeName = '/chatScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $peerUid'),
      ),
      body: Container(
        child: Column(
          children: [Conversation(peerUid), BuildInput()],
        ),
      ),
    );
  }

  buildInput() {}
}

class BuildInput extends StatefulWidget {
  @override
  State<BuildInput> createState() => _BuildInputState();
}

class _BuildInputState extends State<BuildInput> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: [
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: () {},
// getImage
                color: Colors.blueGrey,
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                sendMessage(messageController.text);
              },
              style: TextStyle(color: Colors.blueGrey, fontSize: 15.0),
              controller: messageController,
              decoration: InputDecoration.collapsed(
                hintText: 'Your message...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => sendMessage(messageController.value.text),
                color: Colors.blueGrey,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

sendMessage(String text) {
  // TODO: split database_service into user_service and conversation_service and add sendMessage function to conversation_service
//   conversationService.sendMessage(
//       chatParams.getChatGroupId(),
//       Message(
//           idFrom: chatParams.userUid,
//           idTo: chatParams.peer.uid,
//           timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
//           content: content,
//           type: type));
}

class Conversation extends ConsumerWidget {
  final String peerUid;

  Conversation(this.peerUid);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(DatabaseService.conversationProvider(peerUid)).when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (value) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                print(value.elementAt(index).from);
                print(peerUid);
                return Column(
                  crossAxisAlignment: value.elementAt(index).from == peerUid
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: value.elementAt(index).from == peerUid
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            value.elementAt(index).data,
                            style: TextStyle(
                                color: value.elementAt(index).from == peerUid
                                    ? Colors.black
                                    : Colors.white),
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          width: 200.0,
                          decoration: BoxDecoration(
                              color: value.elementAt(index).from == peerUid
                                  ? Colors.grey
                                  : Colors.blueGrey,
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.only(
                              bottom: 10.0, right: 10.0, left: 10.0),
                        ),
                      ],
                    ),
                    index == value.length
                        ? Container(
                            child: Text(
                              DateFormat('dd MMM kk:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(int.parse(
                                      value.elementAt(index).timestamp))),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.italic),
                            ),
                            margin:
                                EdgeInsets.only(left: 15, right: 15, bottom: 5),
                          )
                        : Container()
                  ],
                );
              },
            );
          },
        );
  }
}
