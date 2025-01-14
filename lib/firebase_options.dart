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
    apiKey: 'AIzaSyAjYhEXKrYOOCPQQJ-GVZDlkJfbzOe6tCw',
    appId: '1:940089395614:web:5fb14af127e2585b31ae8f',
    messagingSenderId: '940089395614',
    projectId: 'chating-49019',
    authDomain: 'chating-49019.firebaseapp.com',
    storageBucket: 'chating-49019.appspot.com',
    measurementId: 'G-MRGRK245NJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFW3bhVI6xHBCDQSJqzPBwPtytaod2ZNU',
    appId: '1:940089395614:android:96a58426b57dddc131ae8f',
    messagingSenderId: '940089395614',
    projectId: 'chating-49019',
    storageBucket: 'chating-49019.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB66lu3KhnPtcKGGiT2JdcyT5_eY45uNAY',
    appId: '1:940089395614:ios:6ca0b6fbaa08e6bc31ae8f',
    messagingSenderId: '940089395614',
    projectId: 'chating-49019',
    storageBucket: 'chating-49019.appspot.com',
    iosBundleId: 'com.example.untitled6',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB66lu3KhnPtcKGGiT2JdcyT5_eY45uNAY',
    appId: '1:940089395614:ios:6ca0b6fbaa08e6bc31ae8f',
    messagingSenderId: '940089395614',
    projectId: 'chating-49019',
    storageBucket: 'chating-49019.appspot.com',
    iosBundleId: 'com.example.untitled6',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAjYhEXKrYOOCPQQJ-GVZDlkJfbzOe6tCw',
    appId: '1:940089395614:web:0768b3a06e3d07ec31ae8f',
    messagingSenderId: '940089395614',
    projectId: 'chating-49019',
    authDomain: 'chating-49019.firebaseapp.com',
    storageBucket: 'chating-49019.appspot.com',
    measurementId: 'G-81LT6505BB',
  );
}
