import 'dart:ffi';

import 'package:chatapp/api/apis.dart';
import 'package:chatapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

// Sender message
  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * 0.04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * 0.04, vertical: mq.height * 0.01),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 217, 243, 255),
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Text(widget.message.msg,
                style: const TextStyle(fontSize: 15, color: Colors.black87)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: mq.width * 0.04),
          child: Text(widget.message.sent,
              style: const TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 55, 57, 53))),
        ),
      ],
    );
  }

// My message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Message content of sender

        Row(
          children: [
            SizedBox(width: mq.width * 0.04),
            //Double tick to check message is read or not
            const Icon(Icons.done_all,
                size: 20, color: Color.fromARGB(255, 23, 146, 227)),

            //for some space between double tick and time
            SizedBox(width: mq.width * 0.02),
            // read time
            Text('${widget.message.read}12:00 AM',
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 55, 57, 53))),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * 0.04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * 0.04, vertical: mq.height * 0.01),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 135, 253, 196),
                border: Border.all(color: Color.fromARGB(255, 134, 198, 61)),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Text(widget.message.msg,
                style: const TextStyle(fontSize: 15, color: Colors.black87)),
          ),
        ),
      ],
    );
  }
}
