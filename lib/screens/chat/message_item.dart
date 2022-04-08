import 'package:flutter/material.dart';
import 'package:projetchatapp/models/message.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final String userId;
  final bool isLastMessage;

  const MessageItem(
      {Key? key, required this.message, required this.userId, required this.isLastMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          userId == message.idFrom ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              userId == message.idFrom ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [messageContainer()],
        ),
        isLastMessage
            ? Container(
                child: Text(
                  DateFormat('dd MMM kk:mm')
                      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(message.timestamp))),
                  style:
                      const TextStyle(color: Colors.white, fontSize: 12.0, fontStyle: FontStyle.italic),
                ),
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              )
            : Container()
      ],
    );
  }

  Widget messageContainer() {
    return Container(
      child: Text(
        message.content,
        style: TextStyle(color: userId == message.idFrom ? Colors.black : Colors.white),
      ),
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      width: 200.0,
      decoration: BoxDecoration(
          color: userId == message.idFrom ? Colors.white : Color(0xfffd8323c),
          borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
    );
  }

}
