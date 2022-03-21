// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyANfA_tMU8Mk2jYQ8Yf7Lfl35GhUTGTBDU',
    appId: '1:271638823977:web:1b27f413ea3342d3590838',
    messagingSenderId: '271638823977',
    projectId: 'impactcentrechretienlyon',
    authDomain: 'impactcentrechretienlyon.firebaseapp.com',
    databaseURL: 'https://impactcentrechretienlyon-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'impactcentrechretienlyon.appspot.com',
    measurementId: 'G-7N5L2Y9291',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZ5nVnmWB298nnYuKcpdtg5W-nU-Vs9j4',
    appId: '1:271638823977:android:4991fd6806f49df4590838',
    messagingSenderId: '271638823977',
    projectId: 'impactcentrechretienlyon',
    databaseURL: 'https://impactcentrechretienlyon-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'impactcentrechretienlyon.appspot.com',
  );
}