import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/api/apis.dart';
import 'package:chatapp/helper/dialouges.dart';
import 'package:chatapp/models/chat_user.dart';
import 'package:chatapp/screens/auth/login_screen.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), // for removing keyboard when user taps anywhere on screen
      child: Scaffold(
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
              // For showing progress bar
              Dialogs.showProgressBar(context);
              // For signing out
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  // For hiding progress bar
                  Navigator.pop(context);
                  // for moving to home screen
                  Navigator.pop(context);
                  // Basially yeha hum back jaarahe home screen pe fir logout ke liye Navigator pushReplacement use karahe hai
                  // replacing the home screen with login screen
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              });
            },
            icon: Icon(Icons.logout),
            label: Text('Logout'), //Message icon (chat bubble)
          ),
        ),

        // body:
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(children: [
                // for adding space
                SizedBox(
                  width: mq.width,
                  height: mq.height * .03,
                ),
                // User image
                Stack(
                  children: [
                    // Profile picture
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: CachedNetworkImage(
                        width: mq.height * .2,
                        height: mq.height * .2,
                        fit: BoxFit.cover,
                        imageUrl: widget.user.image,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          child: Icon(CupertinoIcons.person),
                        ),
                      ),
                    ),
                    // Edit profile picture button
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: MaterialButton(
                        elevation: 1,
                        onPressed: () {
                          _showBottomSheet();
                        },
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: Icon(Icons.edit, color: Colors.greenAccent),
                      ),
                    )
                  ],
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
                  onSaved: (val) => APIs.me.name = val ?? '',
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Name cannot be empty',
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
                  onSaved: (val) => APIs.me.about = val ?? '',
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'About cannot be empty',
                  decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.info_outline, color: Colors.greenAccent),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackBar(
                              context, 'Profile updated successfully');
                        });
                      }
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 28,
                    ),
                    label: Text('Update', style: TextStyle(fontSize: 19))),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: mq.height * .03,
              bottom: mq.height * .06,
            ),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Pick profile picture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: mq.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // for picking image from gallery
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: Size(mq.width * .3, mq.height * .15),
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {},
                      child: Image.asset('images/add_image.png')),

                  // For picking image from camera
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: Size(mq.width * .3, mq.height * .15),
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {},
                      child: Image.asset('images/camera.png')),
                ],
              )
            ],
          );
        });
  }
}
