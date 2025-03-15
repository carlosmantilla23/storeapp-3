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
    apiKey: 'AIzaSyAfLnQcagi1LBAYsbUMIJqjqRJ7oOewXYA',
    appId: '1:41378631922:web:644170604848332398406b',
    messagingSenderId: '41378631922',
    projectId: 'storeapp-3e889',
    authDomain: 'storeapp-3e889.firebaseapp.com',
    storageBucket: 'storeapp-3e889.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNbFhjvI4Z7UqcdcuoLIcPGMr2wsuOy_M',
    appId: '1:41378631922:android:07afe64d06ded60c98406b',
    messagingSenderId: '41378631922',
    projectId: 'storeapp-3e889',
    storageBucket: 'storeapp-3e889.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFiKSyd1noHkbS7EX6fl2AvLayyrl168A',
    appId: '1:41378631922:ios:0a98193adcb42d5e98406b',
    messagingSenderId: '41378631922',
    projectId: 'storeapp-3e889',
    storageBucket: 'storeapp-3e889.firebasestorage.app',
    iosBundleId: 'co.edu.unab.damo.carlosmantilla.storeapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFiKSyd1noHkbS7EX6fl2AvLayyrl168A',
    appId: '1:41378631922:ios:0a98193adcb42d5e98406b',
    messagingSenderId: '41378631922',
    projectId: 'storeapp-3e889',
    storageBucket: 'storeapp-3e889.firebasestorage.app',
    iosBundleId: 'co.edu.unab.damo.carlosmantilla.storeapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAfLnQcagi1LBAYsbUMIJqjqRJ7oOewXYA',
    appId: '1:41378631922:web:c39a0a82beb34a2198406b',
    messagingSenderId: '41378631922',
    projectId: 'storeapp-3e889',
    authDomain: 'storeapp-3e889.firebaseapp.com',
    storageBucket: 'storeapp-3e889.firebasestorage.app',
  );

}