import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/api/apis.dart';
import 'package:chatapp/helper/my_date.dart';
import 'package:chatapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

// Sender message samne wale ka message hai
  Widget _blueMessage() {
    // Update last read message
    if (widget.message.read.isEmpty) {
      APIs.updateMessageTick(widget.message);
    }
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
            child: widget.message.type == Type.text
                // show text message if type is text
                ? Text(
                    widget.message
                        .msg, // message content check karna hai ki if image then image else text
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                // Else show image if type is image
                : ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child: Image.network(widget.message.msg, fit: BoxFit.cover),
                    // CachedNetworkImage(
                    //   imageUrl: widget.message.msg,
                    //   placeholder: (context, url) => const Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: CircularProgressIndicator(
                    //       color: Colors.green,
                    //     ),
                    //   ),
                    //   errorWidget: (context, url, error) =>
                    //       Icon(Icons.image, size: 70),
                    // ),
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: mq.width * 0.04),
          child: Text(
              MyDateHelper.getFormattedDate(
                  context: context, time: widget.message.sent),
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
            if (widget.message.read.isNotEmpty)
              const Icon(Icons.done_all,
                  size: 20, color: Color.fromARGB(255, 23, 146, 227)),

            //for some space between double tick and time
            SizedBox(width: mq.width * 0.02),
            // send time
            Text(
                MyDateHelper.getFormattedDate(
                    context: context, time: widget.message.sent),
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
            child: widget.message.type == Type.text
                // show text message if type is text
                ? Text(
                    widget.message
                        .msg, // message content check karna hai ki if image then image else text
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                // Else show image if type is image
                : ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child:
                        // Image.network(widget.message.msg, fit: BoxFit.cover),
                        CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
