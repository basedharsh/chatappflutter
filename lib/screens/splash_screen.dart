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
  bool _isAnimated = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
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
      appBar: AppBar(
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
            child: const Text('Manan ki mommy😊👌',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    letterSpacing: .9,
                    fontWeight: FontWeight.normal,
                    fontSize: 19)),
          ),
        ],
      ),
    );
  }
}
