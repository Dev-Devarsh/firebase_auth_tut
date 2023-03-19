// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth_tut/cloud_fireStore/create_profile.dart';
import 'package:firebase_auth_tut/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_tut/Auth_with_phone/phone.dart';
import 'package:firebase_auth_tut/Auth_with_phone/verify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Amination_tut/staggered_animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Method',
      // You can use the library anywhere in the app even in theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1),
      ),
      onGenerateRoute: AppRouter().onRouteGenerate,
    );
  }
}
