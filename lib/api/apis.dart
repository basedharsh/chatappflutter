import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

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

  //For accessing firebase Messaging (push notification)
  static FirebaseMessaging cloudmessaging = FirebaseMessaging.instance;

  //For getting Firebase message token
  static Future<String?> getFirebaseMessagingToken() async {
    await cloudmessaging.requestPermission();
    await cloudmessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        log('Push Token: $t');
      }
    });
    return null;

    //This was for foreground notification

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log('Got a message whilst in the foreground!');
    //   log('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     log('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  //For Sending Push Notification Using Rest Api
  static Future<void> SendPushNotif(ChatUser user, String msg) async {
    try {
      final body = {
        "to": user.pushToken,
        "notification": {
          "title": me.name,
          "body": msg,
          "android_channel_id": "chats"
        },
        "data": {
          "some_data": "User Info: ${me.id}",
        },
      };

      var response = await post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'key=AAAAh8ronEc:APA91bEsaZVgzVcX2OJJKjNLJwpt40Pu6HFE4dMSNPzw_sJzxMrElXCCvlemIq9xLbvs5fbu3DK4tWO69g08-9WmczLUFHcKJd28sYEcPoEuNZ6loevzU3zzewiocivH1oyFLd6pToVv'
        },
        body: jsonEncode(body),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (e) {
      log('Error Push Notification: $e');
    }
  }

  //for checking if user exists or not
  static Future<bool> UserExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  //for Adding User
  static Future<bool> AddChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    log('data: ${data.docs.first.id}');

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      //user exists
      log('User Exists: ${data.docs.first.id}');
      firestore
          .collection('users')
          .doc(user.uid)
          .collection('MyFrens')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      return false;
    }
  }

  // For getting current user information from firestore
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        getFirebaseMessagingToken();
        // to update last active status via firebase and system channel
        // This is to set user status to online when user open app
        APIs.updateLastActive(true);
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('UserIds: $userIds');
    return firestore
        .collection('users')
        .where('id', whereIn: userIds)
        // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for getting ids of my frens only
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyFrensId() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('MyFrens')
        .snapshots();
  }

  //For sendfirst msg if user  adds new fren

  static Future<void> SendFirstMessage(
    ChatUser chatUser,
    String msg,
    Type type,
  ) async {
    await firestore
        .collection('users')
        .doc(chatUser.id)
        .collection('MyFrens')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
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
    // get file extension of image
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

// Getting specific user information
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

// For updating User last active time
  static Future<void> updateLastActive(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  /// ************ * Chat screen wale*******************/
  ///
  /// // chats(collection) -> chat_id(document) -> messages(collection) -> message_id(document)

  //useful for getting conversation id between two users
  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // for getting all messages of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllmessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(
    ChatUser chatUser,
    String msg,
    Type type,
  ) async {
    // message sending time also used as message id in firestore database
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // message data
    final Message message = Message(
        msg: msg,
        fromId: user.uid,
        read: '',
        toId: chatUser.id,
        type: type,
        sent: time);
    final ref = firestore
        .collection('chats/${getConversationId(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then(
        (value) => SendPushNotif(chatUser, type == Type.text ? msg : 'image'));
  }

  // Blue tick means message is read by the receiver
  static Future<void> updateMessageTick(Message message) async {
    firestore
        .collection('chats/${getConversationId(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  // get only last message of a chat on home screen
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastmessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  // Send image message to firestore database of a specific chat
  static Future<void> sendInChatImage(ChatUser chatUser, File file) async {
    // get file extension of image
    final ext = file.path.split('.').last;
    log('extension:$ext');
    // Storage file ref with path of image which contains chat id and message id(message id is time in this case)
    final ref = storage.ref().child(
        'images/${getConversationId(chatUser.id)}/${DateTime.now().microsecondsSinceEpoch}.$ext');
    // upload file to firebase storage
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Uploaded: ${p0.bytesTransferred / 1000} KB');
    });
    // upload file to firebase storage
    final imagesUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imagesUrl,
        Type.image); // send message to firestore database with image url
  }
}
