// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAKpsPPajbqm4kX9jbvXSuCnfveF2brUfs',
    appId: '1:1054468564020:web:e92e3622e55bf939bed661',
    messagingSenderId: '1054468564020',
    projectId: 'puzzle-ae3ef',
    authDomain: 'puzzle-ae3ef.firebaseapp.com',
    storageBucket: 'puzzle-ae3ef.appspot.com',
    measurementId: 'G-K0CE9NZ2WC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4ER2pDzA1Q8FVN7HK2PXx8rE49VV9GcU',
    appId: '1:1054468564020:android:d491ed7b9cd3dc66bed661',
    messagingSenderId: '1054468564020',
    projectId: 'puzzle-ae3ef',
    storageBucket: 'puzzle-ae3ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlzp88rxBH5FFLk7fK4OS-CzHg53Tn1wQ',
    appId: '1:1054468564020:ios:a3a7213a2e792b78bed661',
    messagingSenderId: '1054468564020',
    projectId: 'puzzle-ae3ef',
    storageBucket: 'puzzle-ae3ef.appspot.com',
    iosBundleId: 'com.example.puzzleApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlzp88rxBH5FFLk7fK4OS-CzHg53Tn1wQ',
    appId: '1:1054468564020:ios:a3a7213a2e792b78bed661',
    messagingSenderId: '1054468564020',
    projectId: 'puzzle-ae3ef',
    storageBucket: 'puzzle-ae3ef.appspot.com',
    iosBundleId: 'com.example.puzzleApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAKpsPPajbqm4kX9jbvXSuCnfveF2brUfs',
    appId: '1:1054468564020:web:8bbc1a1b63f0e1a6bed661',
    messagingSenderId: '1054468564020',
    projectId: 'puzzle-ae3ef',
    authDomain: 'puzzle-ae3ef.firebaseapp.com',
    storageBucket: 'puzzle-ae3ef.appspot.com',
    measurementId: 'G-SSFCSC5Q0R',
  );
}