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
    apiKey: 'AIzaSyC3NjAh4RY-tU2vjTN4xJfQAeW0gNMgHUg',
    appId: '1:607284358630:web:e2ac55514e6873bb227a27',
    messagingSenderId: '607284358630',
    projectId: 'weatherapp-e2a35',
    authDomain: 'weatherapp-e2a35.firebaseapp.com',
    storageBucket: 'weatherapp-e2a35.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEIkY46dlIlIssWf2v9Epl4GNChyEfaIM',
    appId: '1:607284358630:android:a88b2a752a15bd4b227a27',
    messagingSenderId: '607284358630',
    projectId: 'weatherapp-e2a35',
    storageBucket: 'weatherapp-e2a35.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDknHQpGfKc4p9jabsoJdiA-CXgP6l5dUU',
    appId: '1:607284358630:ios:8350e4c2690211d3227a27',
    messagingSenderId: '607284358630',
    projectId: 'weatherapp-e2a35',
    storageBucket: 'weatherapp-e2a35.firebasestorage.app',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDknHQpGfKc4p9jabsoJdiA-CXgP6l5dUU',
    appId: '1:607284358630:ios:8350e4c2690211d3227a27',
    messagingSenderId: '607284358630',
    projectId: 'weatherapp-e2a35',
    storageBucket: 'weatherapp-e2a35.firebasestorage.app',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC3NjAh4RY-tU2vjTN4xJfQAeW0gNMgHUg',
    appId: '1:607284358630:web:0c68bd9a484096fb227a27',
    messagingSenderId: '607284358630',
    projectId: 'weatherapp-e2a35',
    authDomain: 'weatherapp-e2a35.firebaseapp.com',
    storageBucket: 'weatherapp-e2a35.firebasestorage.app',
  );
}
