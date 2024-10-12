// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: '...',
    appId: '1:663566814460:web:34f436458739f6f71b1b79',
    messagingSenderId: '663566814460',
    projectId: 'chat-e4e86',
    authDomain: 'chat-e4e86.firebaseapp.com',
    storageBucket: 'chat-e4e86.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '...',
    appId: '1:663566814460:android:51c86127788f23bf1b1b79',
    messagingSenderId: '663566814460',
    projectId: 'chat-e4e86',
    storageBucket: 'chat-e4e86.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '...',
    appId: '1:663566814460:ios:3a977034da6d0a391b1b79',
    messagingSenderId: '663566814460',
    projectId: 'chat-e4e86',
    storageBucket: 'chat-e4e86.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPFbT73No7jtq21Bf2Q79IVpMm8FRxqfk',
    appId: '1:663566814460:ios:3a977034da6d0a391b1b79',
    messagingSenderId: '663566814460',
    projectId: 'chat-e4e86',
    storageBucket: 'chat-e4e86.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAKii4FvX0kB9hY8GOq5gTfMqhOcst9r7k',
    appId: '1:663566814460:web:1d3a53f7a97449391b1b79',
    messagingSenderId: '663566814460',
    projectId: 'chat-e4e86',
    authDomain: 'chat-e4e86.firebaseapp.com',
    storageBucket: 'chat-e4e86.appspot.com',
  );

}