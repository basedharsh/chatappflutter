// ignore: file_names

// ignore_for_file: file_names, duplicate_ignore

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/helper/my_date.dart';
import 'package:chatapp/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ViewSenderProfile extends StatefulWidget {
  final ChatUser user;

  const ViewSenderProfile({super.key, required this.user});

  @override
  State<ViewSenderProfile> createState() => _ViewSenderProfileState();
}

class _ViewSenderProfileState extends State<ViewSenderProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), // for removing keyboard when user taps anywhere on screen
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          //Home icon

          centerTitle: true,
          elevation: 1,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(widget.user.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 19)),

          backgroundColor: Colors.black,
        ),

        // floating button for Join date
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Member since: ",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text(
                MyDateHelper.getLastReadMessageTime(
                    context: context, time: widget.user.createdAt),
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.normal,
                    fontSize: 17)),
          ],
        ),

        // body:
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: SingleChildScrollView(
            child: Column(children: [
              // for adding space
              SizedBox(
                width: mq.width,
                height: mq.height * .03,
              ),
              // User image
              ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .1),
                child: CachedNetworkImage(
                  width: mq.height * .2,
                  height: mq.height * .2,
                  fit: BoxFit.cover,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) => const CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
                ),
              ),
              // for adding space
              SizedBox(
                height: mq.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Email: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  Text(widget.user.email,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                ],
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Name: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  Text(widget.user.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                ],
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("About: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  Text(widget.user.about,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
