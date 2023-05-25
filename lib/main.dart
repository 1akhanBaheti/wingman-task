import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman/home.dart';
import 'package:wingman/onboarding.dart';
import 'package:wingman/sign_in.dart';
import 'package:wingman/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token') ?? '';
  onboard = prefs.getBool('onboard') ?? false;
  name = prefs.getString('name') ?? '';
  log(onboard.toString());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: token == ''
            ? const SignIn()
            : onboard
                ? const Home()
                : const OnBoarding());
  }
}
