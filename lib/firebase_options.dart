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
    apiKey: 'AIzaSyCsme_ZDWBgHQE-3taB8xJwSkTM1IJnsT4',
    appId: '1:1078097581875:web:7b6e88f130d3197dee9046',
    messagingSenderId: '1078097581875',
    projectId: 'projectkp-82f19',
    authDomain: 'projectkp-82f19.firebaseapp.com',
    databaseURL: 'https://projectkp-82f19-default-rtdb.firebaseio.com',
    storageBucket: 'projectkp-82f19.appspot.com',
    measurementId: 'G-TP93X1E6XZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqYjL4YcTTsG5GjXi1qYx7V1MFkkagy7o',
    appId: '1:1078097581875:android:b711bd0bcbe32d6fee9046',
    messagingSenderId: '1078097581875',
    projectId: 'projectkp-82f19',
    databaseURL: 'https://projectkp-82f19-default-rtdb.firebaseio.com',
    storageBucket: 'projectkp-82f19.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANwHkYQyMHDvs_68UrXx-XCp3JFQ0M5rQ',
    appId: '1:1078097581875:ios:e276d0987c34b0f5ee9046',
    messagingSenderId: '1078097581875',
    projectId: 'projectkp-82f19',
    databaseURL: 'https://projectkp-82f19-default-rtdb.firebaseio.com',
    storageBucket: 'projectkp-82f19.appspot.com',
    iosBundleId: 'com.example.kpManajemenBengkel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANwHkYQyMHDvs_68UrXx-XCp3JFQ0M5rQ',
    appId: '1:1078097581875:ios:82d101b4f6e5518eee9046',
    messagingSenderId: '1078097581875',
    projectId: 'projectkp-82f19',
    databaseURL: 'https://projectkp-82f19-default-rtdb.firebaseio.com',
    storageBucket: 'projectkp-82f19.appspot.com',
    iosBundleId: 'com.example.kpManajemenBengkel.RunnerTests',
  );
}
