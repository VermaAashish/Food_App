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
    apiKey: 'AIzaSyBSZiFYr27jGxVWufs6aVMwj99WIMgKhX0',
    appId: '1:202717112553:web:27934c77ee1c50dcdc2878',
    messagingSenderId: '202717112553',
    projectId: 'yamzi-food-app',
    authDomain: 'yamzi-food-app.firebaseapp.com',
    storageBucket: 'yamzi-food-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWgaENcBV_-IxbrBsFCPDZ831eUNc7BuM',
    appId: '1:202717112553:android:402bf063daa68853dc2878',
    messagingSenderId: '202717112553',
    projectId: 'yamzi-food-app',
    storageBucket: 'yamzi-food-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqe6uUo857RNG0__vwYrNsiCqxJ58OXxc',
    appId: '1:202717112553:ios:b04f97344f184602dc2878',
    messagingSenderId: '202717112553',
    projectId: 'yamzi-food-app',
    storageBucket: 'yamzi-food-app.firebasestorage.app',
    iosBundleId: 'com.example.yamzi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqe6uUo857RNG0__vwYrNsiCqxJ58OXxc',
    appId: '1:202717112553:ios:b04f97344f184602dc2878',
    messagingSenderId: '202717112553',
    projectId: 'yamzi-food-app',
    storageBucket: 'yamzi-food-app.firebasestorage.app',
    iosBundleId: 'com.example.yamzi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBSZiFYr27jGxVWufs6aVMwj99WIMgKhX0',
    appId: '1:202717112553:web:cea0bdcf473da9a2dc2878',
    messagingSenderId: '202717112553',
    projectId: 'yamzi-food-app',
    authDomain: 'yamzi-food-app.firebaseapp.com',
    storageBucket: 'yamzi-food-app.firebasestorage.app',
  );
}
