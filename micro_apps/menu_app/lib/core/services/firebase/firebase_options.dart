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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAd1AIJkDOZYK_XaOKfTCLhMMaaOoeOgMs',
    appId: '1:400364342771:android:01eb47a7aba43d82135686',
    messagingSenderId: '400364342771',
    projectId: 'ultrasonic-clinic',
    storageBucket: 'ultrasonic-clinic.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDg7abaiHghYTHyV9ElCcdkRj-0DKdA68Y',
    appId: '1:400364342771:ios:e84af7a557d9b4bf135686',
    messagingSenderId: '400364342771',
    projectId: 'ultrasonic-clinic',
    storageBucket: 'ultrasonic-clinic.appspot.com',
    androidClientId: '400364342771-3m908fk37243b36jf3n7angchjqr66uv.apps.googleusercontent.com',
    iosClientId: '400364342771-6rg55gric61667evj56eurkmdl5glst9.apps.googleusercontent.com',
    iosBundleId: 'com.lms.menu.app',
  );

}