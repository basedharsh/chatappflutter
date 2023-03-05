import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_user.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

// for accessing firestore cloud database
// we are creating this so that we can access firestore from anywhere in our app using APIs.firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

// for accessing current user
  static User get user => auth.currentUser!;

  //for checking if user exists or not
  static Future<bool> UserExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  //for creating user in firestore
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatuser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: 'Sometimes i feel like God',
        image: user.photoURL.toString(),
        createdAt: time,
        lastActive: time,
        isOnline: false,
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatuser.toJson());
  }
}
