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
    apiKey: 'AIzaSyD7mF2MGSFnc3BDNF4HQxsD8pwSywG81YU',
    appId: '1:211715356640:web:b9c4f3dd703a2556bd9d85',
    messagingSenderId: '211715356640',
    projectId: 'notes-29ed2',
    authDomain: 'notes-29ed2.firebaseapp.com',
    storageBucket: 'notes-29ed2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmFgWelhSC7FkQUV2vKPoKSP0quSoklFM',
    appId: '1:211715356640:android:98e2c2a5a204f528bd9d85',
    messagingSenderId: '211715356640',
    projectId: 'notes-29ed2',
    storageBucket: 'notes-29ed2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5LWdW6l3gvKpTiqztL--FKG4GUjbUNiM',
    appId: '1:211715356640:ios:423a87ca659228bcbd9d85',
    messagingSenderId: '211715356640',
    projectId: 'notes-29ed2',
    storageBucket: 'notes-29ed2.appspot.com',
    androidClientId: '211715356640-06pu96ftjn1dgkmctfvgiqhemblqp4ge.apps.googleusercontent.com',
    iosClientId: '211715356640-219u6hlmargo3j0jigmb7gd6abv97qas.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseAuthCleanArch',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5LWdW6l3gvKpTiqztL--FKG4GUjbUNiM',
    appId: '1:211715356640:ios:423a87ca659228bcbd9d85',
    messagingSenderId: '211715356640',
    projectId: 'notes-29ed2',
    storageBucket: 'notes-29ed2.appspot.com',
    androidClientId: '211715356640-06pu96ftjn1dgkmctfvgiqhemblqp4ge.apps.googleusercontent.com',
    iosClientId: '211715356640-219u6hlmargo3j0jigmb7gd6abv97qas.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseAuthCleanArch',
  );
}
