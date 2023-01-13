// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth_tut/cloud_fireStore/create_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_tut/Auth_with_phone/phone.dart';
import 'package:firebase_auth_tut/Auth_with_phone/verify.dart';
import 'Amination_tut/staggered_animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StaggeredAnimation());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'phone',
      debugShowCheckedModeBanner: false,
      routes: {
        'phone': (context) => MyPhone(),
        'verify': (context) => MyVerify()
      },
    );
  }
}
