import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/api/apis.dart';
import 'package:chatapp/helper/my_date.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/chat_user.dart';
import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
// Last message if null then no message about user is displayed
  Message? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .02, vertical: 4),
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
          onTap: () {
            // Navigate to chat screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
            stream: APIs.getLastmessage(widget.user),
            builder: ((context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                _message = list[0];
              }
              return ListTile(
                // User image

                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .03),
                  child: CachedNetworkImage(
                    width: mq.height * .055,
                    height: mq.height * .055,
                    imageUrl: widget.user.image,
                    errorWidget: (context, url, error) => const CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    ),
                  ),
                ),
                // User name
                title: Text(widget.user.name),

                // Last message
                subtitle: Text(
                    _message != null ? _message!.msg : widget.user.about,
                    maxLines: 1),

                // Time of last message
                // trailing: Text('12:00', style: TextStyle(color: Colors.black54)),
                trailing: _message == null
                    ? null // show nothing if no message
                    : _message!.read.isEmpty &&
                            _message!.fromId !=
                                APIs.user
                                    .uid // If message is not read and message is not sent by current user

                        ? Container(
                            // Show green dot for unread message
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent.shade400,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        : Text(
                            MyDateHelper.getLastReadMessageTime(
                                context: context, time: _message!.sent),
                            style: const TextStyle(color: Colors.black54)),
              );
            }),
          )),
    );
  }
}
