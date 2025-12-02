import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Minimal Firebase configuration used during [Firebase.initializeApp].
class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'Firebase is only configured for Android and Web right now. Add the missing platform '
          'configs via "flutterfire configure" to target additional platforms.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC_I2tSAS4LgVb41PQACQlthd9OzNO1VpA',
    appId: '1:350201261802:web:9807c445701a85a09ff193',
    messagingSenderId: '350201261802',
    projectId: 'fir-authapp-374ee',
    storageBucket: 'fir-authapp-374ee.firebasestorage.app',
    authDomain: 'fir-authapp-374ee.firebaseapp.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_I2tSAS4LgVb41PQACQlthd9OzNO1VpA',
    appId: '1:350201261802:android:9807c445701a85a09ff193',
    messagingSenderId: '350201261802',
    projectId: 'fir-authapp-374ee',
    storageBucket: 'fir-authapp-374ee.firebasestorage.app',
  );
}
