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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBaxcbhylAcT2Ehr9RIhUKyuoQh3ThoNy8',
    appId: '1:78771136521:web:0565b532debaca5c6170d8',
    messagingSenderId: '78771136521',
    projectId: 'wave-app-51dc8',
    authDomain: 'wave-app-51dc8.firebaseapp.com',
    storageBucket: 'wave-app-51dc8.firebasestorage.app',
    measurementId: 'G-KZNPQW0PX2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAf2RNPmeVghzIqCk_xuMHX6gP6pBgniU4',
    appId: '1:78771136521:android:eef7f1c350efac7e6170d8',
    messagingSenderId: '78771136521',
    projectId: 'wave-app-51dc8',
    storageBucket: 'wave-app-51dc8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCs0F4yKrC2h5_zZ0owLkcvRV_2qZppfE8',
    appId: '1:78771136521:ios:44bbf5bcdc3e61d36170d8',
    messagingSenderId: '78771136521',
    projectId: 'wave-app-51dc8',
    storageBucket: 'wave-app-51dc8.firebasestorage.app',
    iosBundleId: 'com.example.googleMaps',
  );
}
