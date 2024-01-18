import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:spectrum_speak/modules/CenterNotification.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/Message.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class Utils {
  static String baseUrl = "http://192.168.1.12:3000";
  // static String baseUrl="http://localhost:3000";
  static List<RemoteMessage> messageNotifications = [];
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage firestorage = FirebaseStorage.instance;
  static FirebaseMessaging firebasemessaging = FirebaseMessaging.instance;
  static late ChatUser u = AuthManager.u;
  static late String pushT = '';
  static List<String> firstList = [];
  static List<ChatUser> secondList = [];
  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken(String id) async {
    await firebasemessaging.requestPermission();

    await firebasemessaging.getToken().then((t) {
      if (t != null) {
        pushT = t;
        AuthManager.u.pushToken = t;
        u.pushToken = t;
        print('Push Token: $t');
        print('Utils u token ${u.pushToken}');
      } else {
        print('Nopushtoken');
      }
    });
    await firestore.collection('users').doc(id).update({
      'pushToken': pushT,
    });
    // for handling foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        messageNotifications.add(message);
      }
    });
  }

  //get my users ids
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersIDs() {
    return firestore
        .collection('users')
        .doc(u.UserID.toString())
        .collection('my_users')
        .snapshots();
  }

  static Future<void> getMyUsersIDsTopBar() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('users')
        .doc(u.UserID.toString())
        .collection('my_users')
        .get();
    firstList = snapshot.docs.map((doc) => doc.id).toList();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserss(
      List<String> userIDs) {
    List<int> intList = userIDs.map((str) => int.parse(str)).toList();

    return firestore
        .collection('users')
        .where('UserID', whereIn: intList.isEmpty ? [''] : intList)
        .snapshots();
  }

  static Future<void> getAllUserssTopBar(List<String> userIDs) async {
    List<int> intList = userIDs.map((str) => int.parse(str)).toList();
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('users')
        .where('UserID', whereIn: intList.isEmpty ? [''] : intList)
        .get();
    secondList =
        snapshot.docs.map((doc) => ChatUser.fromJson(doc.data())).toList();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('Email', isNotEqualTo: u.Email)
        .snapshots();
  }

  static Future<List<ChatUser>> getAllUsersSearch() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('users')
        .where('UserID', isNotEqualTo: u.UserID)
        .get();
    return snapshot.docs.map((doc) => ChatUser.fromJson(doc.data())).toList();
  }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.UserID)
        .snapshots();
  }

  static Future<String?> getProfilePictureUrl(String ID) async {
    try {
      final ListResult result =
          await firestorage.ref().child('profile_pictures').listAll();

      final List<Reference> files = result.items
          .where(
            (element) => element.name.startsWith('${ID}'),
          )
          .toList();

      if (files.isNotEmpty) {
        // Return the download URL of the first file found
        final file = files.first;
        return await file.getDownloadURL();
      } else {
        // File not found
        return null;
      }
    } catch (e) {
      print('Error getting profile picture: $e');
      return null;
    }
  }

  static Future<void> uploadPicture(File file) async {
    //upload image to fire storage
    final ext = file.path.split('.').last;
    final ref = firestorage.ref().child('profile_pictures/${u.UserID}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then(
        (p0) => print('Data transferred ${p0.bytesTransferred / 1000} kb'));

    // get image url
    u.image = await ref.getDownloadURL();

    // update image url in firestore
    await firestore
        .collection('users')
        .doc('${u.UserID}')
        .update({'image': u.image});
  }

  static String getConversationID(int id) => u.UserID.hashCode <= id.hashCode
      ? '${u.UserID}_$id'
      : '${id}_${u.UserID}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.UserID)}/messages/')
        .snapshots();
  }

  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toID: chatUser.UserID,
        message: msg,
        read: '',
        type: type.toString(),
        fromID: u.UserID,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.UserID)}/messages/');
    if (!msg.contains('Video Call Started'))
      await ref.doc(time).set(message.toJson()).then((value) =>
          sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
  }

  //API to send push notification
  static Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": AuthManager.u.Name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        "data": {"some data": "User ID: ${u.UserID}"},
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAA1SJlLnQ:APA91bGxvTRCyjf96MMJkgQt3tFG47TSKw1GcGguaypHlqsaKWl0to4M7dDvDi-ELsoFrBG0qF-FJbm9uGg5IjDIosFwRCzEcOIJVgwxOElXRXIcRAHhg15grhyyGytub_Hr69SRWH52'
          },
          body: jsonEncode(body));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  static Future<void> sendPushCallNotification(ChatUser chatUser) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": AuthManager.u.Name, //our name should be send
          "body": "Incoming Call",
          "android_channel_id": "call_channel"
        },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAA1SJlLnQ:APA91bGxvTRCyjf96MMJkgQt3tFG47TSKw1GcGguaypHlqsaKWl0to4M7dDvDi-ELsoFrBG0qF-FJbm9uGg5IjDIosFwRCzEcOIJVgwxOElXRXIcRAHhg15grhyyGytub_Hr69SRWH52'
          },
          body: jsonEncode(body));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  static Future<void> updateMessgaeReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromID)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().microsecondsSinceEpoch.toString()});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.UserID)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send image in chat
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = firestorage.ref().child(
        'images/${getConversationID(chatUser.UserID)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

  //update active status
  static Future<void> updateActiveStatus(String id, bool isOnline) async {
    await firestore.collection('users').doc(id).update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch.toString(),
    });
    print('Push token is $pushT');
  }

  //delete message
  static Future<void> deleteMessage(Message message) async {
    await firestore
        .collection('chats/${getConversationID(message.toID)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == Type.image.toString()) {
      await firestorage.refFromURL(message.message).delete();
    }
  }

  //update message
  static Future<void> updateMessage(Message message, String updatedMsg) async {
    await firestore
        .collection('chats/${getConversationID(message.toID)}/messages/')
        .doc(message.sent)
        .update({'message': updatedMsg});
  }

  //add chat user
  static Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('Email', isEqualTo: email)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != u.UserID) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      firestore
          .collection('users')
          .doc(u.UserID.toString())
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      return false;
    }
  }

  static Future<void> addChatUser2(int id, String email) async {
    print('I am here');
    final data = await firestore
        .collection('users')
        .where('Email', isEqualTo: email)
        .get();

    firestore
        .collection('users')
        .doc(id.toString())
        .collection('my_users')
        .doc(data.docs.first.id)
        .set({});
  }

  static Future<void> createFireBaseUser(
      String email, String name, int id) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        Email: email,
        Name: name,
        UserID: id,
        createdAt: time,
        lastActive: time);
    await firestore
        .collection('users')
        .doc(id.toString())
        .set(chatUser.toJson(), SetOptions(merge: true));
  }

  static Future<void> storeCenterNotification(CenterNotification cn) async {
    await firestore
        .collection('center_notifications')
        .doc('${cn.fromID}_${cn.toID}')
        .set(cn.toJson());
  }

  static Future<bool> checkIfRequestHasBeenMade(
      String toID, String fromID) async {
    DocumentReference ref = await firestore
        .collection('center_notifications')
        .doc('${fromID}_${toID}');
    DocumentSnapshot snapshot = await ref.get();
    return snapshot.exists;
  }

  static Future<int> getUnreadConversations(bool b) async {
    int count = 0;
    QuerySnapshot<Map<String, dynamic>> snapshot1 = await firestore
        .collection('users')
        .doc(u.UserID.toString())
        .collection('my_users')
        .get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents1 =
        snapshot1.docs;
    List<String> list = documents1.map((e) => e.id).toList();
    List<int> intList = list.map((str) => int.parse(str)).toList();

    QuerySnapshot<Map<String, dynamic>> snapshot2 = await firestore
        .collection('users')
        .where('UserID', whereIn: intList.isEmpty ? [''] : intList)
        .get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents2 =
        snapshot2.docs;

    List<ChatUser> secondList =
        documents2.map((e) => ChatUser.fromJson(e.data())).toList();
    popUpMenuList = secondList;
    for (int i = 0; i < secondList.length; i++) {
      QuerySnapshot<Map<String, dynamic>> snapshot3 = await firestore
          .collection(
              'chats/${getConversationID(secondList[i].UserID)}/messages/')
          .orderBy('sent', descending: true)
          .limit(1)
          .get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents3 =
          snapshot3.docs;
      List<Message> msgs =
          documents3.map((e) => Message.fromJson(e.data())).toList();
      if (msgs[msgs.length - 1].read.isEmpty) count++;
    }
    return count;
  }
}
