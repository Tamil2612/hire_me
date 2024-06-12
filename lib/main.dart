import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/light_mode.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBuCg3XbVsxGkbZPmzNk4yEmkVbsO-P5C4",
        appId: "1:819399849442:android:aff74f8765e77ae2c135bb",
        messagingSenderId: "819399849442",
        projectId: "hire-me-d9665",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  final prefs = await SharedPreferences.getInstance();
  final showIntro = prefs.getBool('showIntro') ?? true;
  final loginDone = prefs.getBool('loginDone') ?? false;

  runApp(MyApp(
    showIntro: showIntro,
    loginDone: loginDone,
  ));
}

class MyApp extends StatelessWidget {
  final bool showIntro;
  final bool loginDone;

  const MyApp({super.key, required this.showIntro, required this.loginDone});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      routerConfig: router(showIntro, loginDone),
    );
  }
}
