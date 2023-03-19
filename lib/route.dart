import 'package:firebase_auth_tut/Amination_tut/staggered_animation.dart';
import 'package:firebase_auth_tut/Auth_with_phone/phone.dart';
import 'package:firebase_auth_tut/Auth_with_phone/success.dart';
import 'package:firebase_auth_tut/new_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onRouteGenerate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(settings: settings, builder: (_) => const Screen1());
        case '/anime':
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const StaggeredAnimation());
        case '/phone':
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MyPhone());
        case '/screen':
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SuccessScreen());
      default:
        return MaterialPageRoute(settings: settings, builder: (_) => const Screen1());
    }
  }

  static Future goToNextPage(BuildContext context, String s, {Map? arguments}) async {
    return await Navigator.pushNamed(context, s, arguments: arguments);
  }

  static pushAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  static pushReplacement(BuildContext context, String routeName, {Map? arguments}) {
    // Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static pop(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }

  static popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(
      context,
      (route) {
        return route.settings.name == routeName;
      },
    );
  }
}
