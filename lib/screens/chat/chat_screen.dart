import 'package:flutter/material.dart';
import 'package:projetchatapp/models/chat_params.dart';

import 'chat.dart';

class ChatScreen extends StatelessWidget {
  final ChatParams chatParams;

  const ChatScreen({Key? key, required this.chatParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          title: Text(chatParams.peer.nom +' '+ chatParams.peer.prenom)
      ),
      body: Chat(chatParams: chatParams),
    );
  }
}
