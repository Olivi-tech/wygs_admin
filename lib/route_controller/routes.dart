import 'package:flutter/material.dart';
import 'package:guitar_songs/screens/home_screen.dart';
import 'package:guitar_songs/screens/sign_in_screen.dart';
import 'package:guitar_songs/utlis/app_routes.dart';

Route onGenerateRoute(RouteSettings setting) {
  if (setting.name == AppRoutes.signin) {
    return MaterialPageRoute(builder: (context) => const SignInScreen());
  } else {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
