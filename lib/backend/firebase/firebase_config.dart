import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD0IP3To-lylz7sE9SCwnrgfx2hQdRyiPc",
            authDomain: "arunproductions.firebaseapp.com",
            projectId: "arunproductions",
            storageBucket: "arunproductions.appspot.com",
            messagingSenderId: "739749080890",
            appId: "1:739749080890:web:790d0d5f94634541482a03",
            measurementId: "G-ZCKX70L764"));
  } else {
    await Firebase.initializeApp();
  }
}
