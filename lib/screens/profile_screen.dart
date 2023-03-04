import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/api/apis.dart';
import 'package:chatapp/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Home icon

        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('My Profile',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 19)),

        backgroundColor: Colors.white,
      ),

      // floating button for chat
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.greenAccent.shade400,
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          icon: Icon(Icons.logout),
          label: Text('Logout'), //Message icon (chat bubble)
        ),
      ),

      // body:
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
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
          Text(widget.user.email,
              style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  fontSize: 16)),

          // for adding space
          SizedBox(
            height: mq.height * .05,
          ),
          // for user name
          TextFormField(
            initialValue: widget.user.name,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person, color: Colors.greenAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
          // for adding space
          SizedBox(
            height: mq.height * .05,
          ),
          // for user about
          TextFormField(
            initialValue: widget.user.about,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.info_outline, color: Colors.greenAccent),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'Tell us about yourself',
              labelText: 'About',
            ),
          ),
          // for adding space
          SizedBox(
            height: mq.height * .05,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                minimumSize: Size(mq.width * .5, mq.height * .06),
                primary: Colors.greenAccent.shade400,
              ),
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 28,
              ),
              label: Text('Update', style: TextStyle(fontSize: 19))),
        ]),
      ),
    );
  }
}
