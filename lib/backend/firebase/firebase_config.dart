import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBQEg0la_cpM1YcYhiODn9pnGiExOU2GfA",
            authDomain: "equibriu-med-system-wn4ocl.firebaseapp.com",
            projectId: "equibriu-med-system-wn4ocl",
            storageBucket: "equibriu-med-system-wn4ocl.appspot.com",
            messagingSenderId: "990848927910",
            appId: "1:990848927910:web:6ca90ea9253d75bf8acc67"));
  } else {
    await Firebase.initializeApp();
  }
}
