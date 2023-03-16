import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:job_search_with_apis/screens/home_page.dart';
import 'package:job_search_with_apis/screens/opt_company.dart';
import 'package:job_search_with_apis/screens/splash_screen.dart';
import 'package:job_search_with_apis/screens/timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/subsrction_screen.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool newUser;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // clearData();
    checkIfLogin();
  }

  void checkIfLogin() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String role = _preferences.getString('user_id');
    String token = _preferences.getString('shared_token');
    int userId = _preferences.getInt('id');
    String isVerified = _preferences.getString('verified');
    String email = _preferences.getString('email');
    String image = _preferences.getString('image');
    String subscription = _preferences.getString('subscription');
    if (kDebugMode) {
      print('role: $role');
      print('token: $token');
      print('id: $userId');
      print('verification: $isVerified');
      print('subscription: $subscription');
    }

    if (isVerified == '0') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (ctx) => OtpCompany(
                    userId: userId,
                    token: token,
                    email: email,
                    usertype: role,
                  )),
          (route) => false);
    } else if (role != null && token != null) {
      if (role == '1' || role == 'graduate') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userId: userId.toString(),
              token: token,
            ),
          ),
        );
      } else {
        if (subscription == '0') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => SubscriptionScreen(
                    token: token,
                    userId: userId.toString(),
                  )));
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => Timeline(
                token: token,
                userId: userId.toString(),
                image: image,
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SplashScreen());
  }
}
