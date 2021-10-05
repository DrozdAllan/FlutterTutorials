import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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
          children: [
            Conversation(peerUid),
            BuildInput(
              peerUid: peerUid,
            )
          ],
        ),
      ),
    );
  }
}

class BuildInput extends StatefulWidget {
  final String peerUid;

  const BuildInput({Key? key, required this.peerUid}) : super(key: key);

  @override
  State<BuildInput> createState() => _BuildInputState();
}

class _BuildInputState extends State<BuildInput> {
  final TextEditingController messageController = TextEditingController();

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
                onPressed: getImage,
                color: Colors.blueGrey,
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                onSendMessage(widget.peerUid, messageController.value.text);
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
                onPressed: () =>
                    onSendMessage(widget.peerUid, messageController.value.text),
                color: Colors.blueGrey,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void onSendMessage(String peerUid, String message) {
    ConversationService.sendMessage(peerUid, message);
    messageController.clear();
  }

  Future getImage() async {
    // using ImagePicker library
    final ImagePicker _picker = ImagePicker();
    // different sources available in ImageSource
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      uploadFile(image);
    }
  }

  Future uploadFile(XFile image) async {
    try {
      // creating the directory reference in firebase storage
      Reference storageRef = FirebaseStorage.instance.ref('chatImages');

      // creating a File object with dart:io package and uploading it to Storage, returning the result
      var result = await storageRef.child(image.name).putFile(File(image.path));
      // retrieving an url for the image, to put it in firestore eventually
      String imageUrl = await result.ref.getDownloadURL();
      print('the imageUrl is ' + imageUrl);
      setState(() {
        onSendMessage(widget.peerUid, imageUrl);
      });
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e);
    }
  }
}

class Conversation extends ConsumerWidget {
  final String peerUid;

  Conversation(this.peerUid);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(ConversationService.conversationProvider(peerUid)).when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (value) {
            return ListView.builder(
              reverse: true,
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
                        value.elementAt(index).type == 0
                            ? Container(
                                child: Text(
                                  value.elementAt(index).data,
                                  style: TextStyle(
                                      color:
                                          value.elementAt(index).from == peerUid
                                              ? Colors.black
                                              : Colors.white),
                                ),
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                width: 200.0,
                                decoration: BoxDecoration(
                                    color:
                                        value.elementAt(index).from == peerUid
                                            ? Colors.grey
                                            : Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(8.0)),
                                margin: EdgeInsets.only(
                                    bottom: 10.0, right: 10.0, left: 10.0),
                              )
                            : Container(
                                child: Material(
                                  child: Image.network(
                                    value.elementAt(index).data,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: value.elementAt(index).from ==
                                                  peerUid
                                              ? Colors.grey
                                              : Colors.blueGrey,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                        width: 200.0,
                                        height: 200.0,
                                        child: Center(
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, object, stackTrace) {
                                      return Material(
                                        child: Image.asset(
                                          'images/img_not_available.jpeg',
                                          width: 200.0,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                      );
                                    },
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  clipBehavior: Clip.hardEdge,
                                ),
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
