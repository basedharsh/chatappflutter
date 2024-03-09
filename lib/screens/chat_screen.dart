import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/helper/my_date.dart';
import 'package:chatapp/models/chat_user.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/screens/ViewProfile.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../api/apis.dart';
import '../main.dart';
import '../widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // for storing all messages
  List<Message> _list = [];

// for handling text field messages and sending them
  final _textController = TextEditingController();

// for storing value of emoji button
  bool _showEmoji = false,

      // _isuploading is for showing progress indicator when image is uploading

      _isUploading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: SafeArea(
        // ignore: deprecated_member_use
        child: WillPopScope(
          // if user press back button then hide emoji picker and don't exit app to main screen
          onWillPop: () {
            if (_showEmoji) {
              setState(() {
                _showEmoji = !_showEmoji;
              }); // Harsh ne likha hai lavde(only if you read my code text me at (www.instagram.com/basedharsh))
              return Future.value(
                  false); // Futuure.value is false then we will not exit the app
            } else {
              return Future.value(true); // if true then we will exit the app
            }
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: _appBar(),
              backgroundColor: Colors.white,
            ),
            backgroundColor: const Color.fromARGB(255, 146, 254, 254),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: APIs.getAllmessages(widget
                          .user), //users collection from firestore database in firebase
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          //if data is not loaded yet then waiting or none
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();

                          //if data is loaded then active or done then show data
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;

                            _list = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                  reverse:
                                      true, // for showing latest message at bottom of the list view
                                  itemCount: _list.length,
                                  padding:
                                      EdgeInsets.only(top: mq.height * .01),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: ((context, index) {
                                    return MessageCard(
                                      message: _list[index],
                                    );
                                  }));
                            } else {
                              return const Center(
                                  child: Text('Say hii😯😯!',
                                      style: TextStyle(fontSize: 20)));
                            }
                        }
                      }),
                ),
                // for showing progress indicator when image is uploading to firebase storage
                if (_isUploading)
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))),
                // for showing the input field and send button
                _chatInput(),
                if (_showEmoji)
                  SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: _textController,
                      config: Config(
                        bgColor: const Color.fromARGB(255, 146, 254, 254),
                        columns: 9,
                        initCategory: Category.RECENT,
                        emojiSizeMax: 32 *
                            (Platform.isIOS
                                ? 1.30
                                : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ViewSenderProfile(user: widget.user)));
        },
        child: StreamBuilder(
            stream: APIs.getUserInfo(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              return Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black87,
                      )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child: CachedNetworkImage(
                      width: mq.height * .05,
                      height: mq.height * .05,
                      imageUrl:
                          list.isNotEmpty ? list[0].image : widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // for printing the name of the user
                      Text(
                        list.isNotEmpty ? list[0].name : widget.user.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // for printing the last seen of the user
                      Text(
                        list.isNotEmpty
                            ? list[0].isOnline
                                ? 'Yeh vyakti online hei'
                                : MyDateHelper.getLastActiveTime(
                                    context: context,
                                    lastActive: list[0].lastActive)
                            : MyDateHelper.getLastActiveTime(
                                context: context,
                                lastActive: widget.user.lastActive),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              );
            }));
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          // Input field and buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context)
                          .unfocus(); // to hide keyboard when emoji button is pressed
                      setState(() => _showEmoji =
                          !_showEmoji); // to show emoji picker when emoji button is pressed
                    },
                    icon: Icon(
                      Icons.emoji_emotions,
                      color: Colors.greenAccent.shade700,
                      size: 28,
                    ),
                  ),

                  // text send box
                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      // to hide emoji picker when text field is tapped
                      if (_showEmoji) {
                        setState(() => _showEmoji =
                            !_showEmoji); // to hide emoji picker when text field is tapped
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: TextStyle(
                        color: Colors.greenAccent.shade700,
                      ),
                      border: InputBorder.none,
                    ),
                  )),

                  // Pick image from gallery button
                  IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick bohot saare images at once
                      final List<XFile> images =
                          await picker.pickMultiImage(imageQuality: 50);

                      // upload aur send karna hai images ko one by one
                      for (var i in images) {
                        log("Image path: ${i.path} ");
                        setState(() => _isUploading =
                            true); // to show progress indicator when image is uploading to firebase storage
                        await APIs.sendInChatImage(widget.user, File(i.path));
                        setState(() => _isUploading =
                            false); // to hide progress indicator when image is uploaded to firebase storage
                      }
                    },
                    icon: Icon(
                      Icons.image_sharp,
                      color: Colors.greenAccent.shade700,
                      size: 28,
                    ),
                  ),

                  // pick image from camera
                  IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick an image
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 50);
                      if (image != null) {
                        log("Image path: ${image.path} ");
                        setState(() => _isUploading =
                            true); // to show progress indicator when image is uploading to firebase storage

                        await APIs.sendInChatImage(
                            widget.user, File(image.path));
                        setState(() => _isUploading =
                            false); // to hide progress indicator when image is uploaded to firebase storage
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.greenAccent.shade700,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Send message button
          MaterialButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  //on first message add user to my frens list
                  if (_list.isNotEmpty) {
                    APIs.SendFirstMessage(
                        widget.user, _textController.text, Type.text);
                  } else {
                    //send simple msg
                    APIs.sendMessage(
                        widget.user, _textController.text, Type.text);
                  }
                  _textController.text = '';
                }
              },
              minWidth: 0,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 20, right: 20),
              shape: const CircleBorder(),
              color: const Color.fromARGB(255, 5, 189, 240),
              child: const Icon(Icons.send,
                  color: Color.fromARGB(255, 227, 228, 228), size: 30)),
        ],
      ),
    );
  }
}
// // error in docs due to null safety in flutter to solve this error we have to add ? after docs
