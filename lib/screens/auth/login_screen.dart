import 'package:chatapp/main.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;

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
                primary: Colors.greenAccent.shade700,
                onPrimary: Colors.white,
                shape: StadiumBorder(),
                elevation: 1,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
              icon: Image.asset('images/google.png', height: mq.height * .04),
              label: RichText(
                  text: const TextSpan(
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 19,
                ),
                children: [
                  TextSpan(text: 'Sign In with  '),
                  TextSpan(
                      text: 'Google',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
