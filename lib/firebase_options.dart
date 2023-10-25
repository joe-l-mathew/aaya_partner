// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAapeqDQivb4Rvl3kaBRd4H54t8If50U28',
    appId: '1:54570656770:web:229475c2e55fda0f4a731b',
    messagingSenderId: '54570656770',
    projectId: 'aaya-partner',
    authDomain: 'aaya-partner.firebaseapp.com',
    storageBucket: 'aaya-partner.appspot.com',
    measurementId: 'G-6ZJKC0GQMB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARZG_91mptucsPsts6T6zYDUymOBlLRjQ',
    appId: '1:54570656770:android:0cdf2c4754d055754a731b',
    messagingSenderId: '54570656770',
    projectId: 'aaya-partner',
    storageBucket: 'aaya-partner.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCd4RzaS73R2xRz9YLjhHOTViezvY1GlU0',
    appId: '1:54570656770:ios:0d2c8fab17ac65444a731b',
    messagingSenderId: '54570656770',
    projectId: 'aaya-partner',
    storageBucket: 'aaya-partner.appspot.com',
    iosBundleId: 'com.aaya.aayaPartner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCd4RzaS73R2xRz9YLjhHOTViezvY1GlU0',
    appId: '1:54570656770:ios:02e30ac0b49f558a4a731b',
    messagingSenderId: '54570656770',
    projectId: 'aaya-partner',
    storageBucket: 'aaya-partner.appspot.com',
    iosBundleId: 'com.aaya.aayaPartner.RunnerTests',
  );
}