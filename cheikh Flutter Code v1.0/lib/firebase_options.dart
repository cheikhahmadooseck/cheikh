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
    apiKey: '******',
    appId: '******',
    messagingSenderId: '******',
    projectId: '******',
    authDomain: '******.firebaseapp.com',
    storageBucket: '******.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '******',
    appId: '1:******:android:e4ae83e8224c662ca2f61f',
    messagingSenderId: '******',
    projectId: '******',
    storageBucket: '******.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '******',
    appId: '1:******:ios:b02c13c557ce4b9ba2f61f',
    messagingSenderId: '******',
    projectId: '******',
    storageBucket: '******.appspot.com',
    androidClientId: '******-1qgdm3pfage9vfpfsuseos412h0rigkd.apps.googleusercontent.com',
    iosClientId: '******-cm5mp7gericq710u1l80i1l9mqnjgm4t.apps.googleusercontent.com',
    iosBundleId: '******',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '******',
    appId: '1:******:ios:b02c13c557ce4b9ba2f61f',
    messagingSenderId: '******',
    projectId: '******',
    storageBucket: '******.appspot.com',
    androidClientId: '******-1qgdm3pfage9vfpfsuseos412h0rigkd.apps.googleusercontent.com',
    iosClientId: '******-cm5mp7gericq710u1l80i1l9mqnjgm4t.apps.googleusercontent.com',
    iosBundleId: '******',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: '******',
    appId: '1:******:web:9efc51079004cc12a2f61f',
    messagingSenderId: '******',
    projectId: '******',
    authDomain: '******.firebaseapp.com',
    storageBucket: '******.appspot.com',
  );
}
