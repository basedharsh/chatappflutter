// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:developer';
import 'dart:io';

import 'package:chatapp/api/apis.dart';
import 'package:chatapp/helper/dialouges.dart';
import 'package:chatapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home_sreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimated = false;
  @override
  void initState() {
    //  implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  _handleGoogleSignin() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async => {
          Navigator.pop(context), //close progress bar if any error
          if (user != null)
            {
              log('User: ${user.user}'),
              log('\nUserAdditionalInfo: ${user.additionalUserInfo}'),
              if ((await APIs.UserExists()))
                {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()))
                }
              else
                {
                  await APIs.createUser().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }),
                }
            }
        });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup(
          'google.com'); // check internet connection is available or not
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackBar(context, 'Some lafda happened(check internet)');
      return null;
    }
  }

  //sign out function
  // _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn().signOut();
  // }

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //Home icon
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Welcome to Chat App',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 19)),
        backgroundColor: const Color.fromARGB(255, 22, 21, 21),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(seconds: 2),
              top: mq.height * .15,
              width: mq.width * .5,
              right: _isAnimated ? mq.width * .25 : -mq.width * .5,
              child: Image.asset('images/chatlogo.png')),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.greenAccent.shade700,
                shape: const StadiumBorder(),
                elevation: 1,
              ),
              onPressed: () {
                _handleGoogleSignin();
              },
              icon: Image.asset('images/google.png', height: mq.height * .04),
              label: RichText(
                  text: const TextSpan(
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 19,
                ),
                children: [
                  TextSpan(
                    text: 'Sign In with  ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                      text: 'Google',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )),
            ),
          ),
          //Basedharsh.com
          Positioned(
            bottom: 40, // Adjust the value as per your design requirement.
            left: 0,
            right: 0,
            child: Text(
              'basedharsh.com ❤️',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 251, 172, 172),
                letterSpacing: .9,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
