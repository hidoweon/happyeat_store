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
    apiKey: 'AIzaSyDjTzDAgcP_zVyzNIYuCaN31bTU99BqWTo',
    appId: '1:843665882214:web:ee1b299ce0d2adf322c1a7',
    messagingSenderId: '843665882214',
    projectId: 'happyeat-d2f8d',
    authDomain: 'happyeat-d2f8d.firebaseapp.com',
    storageBucket: 'happyeat-d2f8d.appspot.com',
    measurementId: 'G-RKBTCF22T6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkmixZ-GyO9t-8J7z8OE5EMaSV_qzQ8Eg',
    appId: '1:843665882214:android:fd627f41947ab9c422c1a7',
    messagingSenderId: '843665882214',
    projectId: 'happyeat-d2f8d',
    storageBucket: 'happyeat-d2f8d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4--ZU5ZWYM3-1joXz6egjDc5MPfBqU_8',
    appId: '1:843665882214:ios:6001b00f77507ed522c1a7',
    messagingSenderId: '843665882214',
    projectId: 'happyeat-d2f8d',
    storageBucket: 'happyeat-d2f8d.appspot.com',
    iosClientId: '843665882214-lfnnbpa31u3cjpds1csrg86uojc8e6e6.apps.googleusercontent.com',
    iosBundleId: 'com.happyshow.happyeatStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4--ZU5ZWYM3-1joXz6egjDc5MPfBqU_8',
    appId: '1:843665882214:ios:6001b00f77507ed522c1a7',
    messagingSenderId: '843665882214',
    projectId: 'happyeat-d2f8d',
    storageBucket: 'happyeat-d2f8d.appspot.com',
    iosClientId: '843665882214-lfnnbpa31u3cjpds1csrg86uojc8e6e6.apps.googleusercontent.com',
    iosBundleId: 'com.happyshow.happyeatStore',
  );
}
