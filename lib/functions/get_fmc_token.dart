import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getFCMToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  try {
    String? token = await messaging.getToken();
    return token;
  } catch (e) {
    return null;
  }
}
