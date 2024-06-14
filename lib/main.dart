import 'dart:io';
import 'package:drivers_app/pages/dashboard.dart';
import 'package:drivers_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'authentication/login_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCxevwjA9FGdoBGXE4sm3o2wCj9H3Y-Wbw',
              appId: '1:389684649868:android:1af40847577e6fc13040a9',
              messagingSenderId: '389684649868',
              projectId: 'flutter-uber-clone-with-16ccf',
              storageBucket: "flutter-uber-clone-with-16ccf.appspot.com"))
      : await Firebase.initializeApp();

  await Permission.notification.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.notification.request();
    }
  });
  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.locationWhenInUse.request();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drivers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? LoginScreen()
          : Dashboard(),
    );
  }
}
