import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        child: Conversation(peerUid),
      ),
    );
  }
}

class Conversation extends ConsumerWidget {
  final peerUid;

  Conversation(this.peerUid);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var conversation = ref.watch(DatabaseService.conversationProvider(peerUid));
    print(conversation);
    return conversation.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (value) {
        print(value);
        // return Text(value.created);
        throw Error();
      },
    );
  }
}
