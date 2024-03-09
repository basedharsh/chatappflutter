import 'package:chatapp/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

import 'firebase_options.dart';

// global object to get the size of the screen
late Size mq;

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  WidgetsFlutterBinding.ensureInitialized();

// for setting the orientation of the app to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => {
        _initializeFirebase(),
        runApp(const MyApp()),
      });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 1,
            titleTextStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 19)),
        colorScheme: const ColorScheme.light(primary: Colors.white),
      ),
      home: const SplashScreen(),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For displaying notification',
    id: 'Chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'CHATS',
  );
  if (kDebugMode) {
    print(result);
  }
}


// This is coded by harsh (my socials -> Instagram: @hsrah_, github: @basedharsh, email: basedharsh@gmail.com)

