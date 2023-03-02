import 'package:chatapp/main.dart';
import 'package:flutter/material.dart';

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
    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
