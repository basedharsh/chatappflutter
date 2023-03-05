import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/chat_user.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

// for accessing firestore cloud database
// we are creating this so that we can access firestore from anywhere in our app using APIs.firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

// for accessing firestore cloud database images storage
  static FirebaseStorage storage = FirebaseStorage.instance;

// for storinng self user information
  static late ChatUser me;

// for accessing current user
  static User get user => auth.currentUser!;

  //for checking if user exists or not
  static Future<bool> UserExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // For getting current user information from firestore
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        log('My Data:${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
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

// for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // For updating User information
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // For updating User image
  static Future<void> UpdateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    log('extension:$ext');
    // Storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');
    // upload file to firebase storage
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Uploaded: ${p0.bytesTransferred / 1000} KB');
    });
    // upload file to firebase storage
    me.image = await ref.getDownloadURL();
     await firestore.collection('users').doc(user.uid).update({
      'image': me.image,
    });
  }
}
