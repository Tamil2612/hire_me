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
    apiKey: 'AIzaSyDqNkcra9Yh9IoIBgXBXpZJQTvd5D6Zu5w',
    appId: '1:819399849442:web:ac1a67aa4cce7ec7c135bb',
    messagingSenderId: '819399849442',
    projectId: 'hire-me-d9665',
    authDomain: 'hire-me-d9665.firebaseapp.com',
    storageBucket: 'hire-me-d9665.appspot.com',
    measurementId: 'G-7YBEVBQ1CQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuCg3XbVsxGkbZPmzNk4yEmkVbsO-P5C4',
    appId: '1:819399849442:android:aff74f8765e77ae2c135bb',
    messagingSenderId: '819399849442',
    projectId: 'hire-me-d9665',
    storageBucket: 'hire-me-d9665.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnzq18k-D_HdmMYgH7e-Y6u_WJuoVWofA',
    appId: '1:819399849442:ios:e8f08afcedd9662cc135bb',
    messagingSenderId: '819399849442',
    projectId: 'hire-me-d9665',
    storageBucket: 'hire-me-d9665.appspot.com',
    iosBundleId: 'com.example.hireMe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnzq18k-D_HdmMYgH7e-Y6u_WJuoVWofA',
    appId: '1:819399849442:ios:e8f08afcedd9662cc135bb',
    messagingSenderId: '819399849442',
    projectId: 'hire-me-d9665',
    storageBucket: 'hire-me-d9665.appspot.com',
    iosBundleId: 'com.example.hireMe',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDqNkcra9Yh9IoIBgXBXpZJQTvd5D6Zu5w',
    appId: '1:819399849442:web:425da52154efe6cec135bb',
    messagingSenderId: '819399849442',
    projectId: 'hire-me-d9665',
    authDomain: 'hire-me-d9665.firebaseapp.com',
    storageBucket: 'hire-me-d9665.appspot.com',
    measurementId: 'G-YSR56P50CQ',
  );

}