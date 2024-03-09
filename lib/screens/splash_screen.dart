import 'dart:developer';

import 'package:chatapp/api/apis.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_sreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  //  implement initState
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark));

      // Check if user is logged in or not and navigate accordingly
      if (APIs.auth.currentUser != null) {
        log('User: ${APIs.auth.currentUser}');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        //Home icon
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Welcome to Chat App',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 19)),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              width: mq.width * .5,
              right: mq.width * .25,
              child: Image.asset('images/chatlogo.png')),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message_outlined,
                  color: Colors.black87,
                  size: 24,
                ),
                Text('Insta: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.867),
                        letterSpacing: .9,
                        fontWeight: FontWeight.normal,
                        fontSize: 24)),
                Text('basedharsh 😊👌',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 251, 172, 172),
                        letterSpacing: .9,
                        fontWeight: FontWeight.normal,
                        fontSize: 24)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
