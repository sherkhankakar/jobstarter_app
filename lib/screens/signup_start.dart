import 'package:flutter/material.dart';
import '../screens/sign_in.dart';
import '../screens/signup.dart';

class SignUpStart extends StatefulWidget {
  const SignUpStart({Key key}) : super(key: key);

  @override
  _SignUpStartState createState() => _SignUpStartState();
}

class _SignUpStartState extends State<SignUpStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        body: Container(
            margin: const EdgeInsets.only(left: 50, right: 30),
            child: Column(children: [
              const SizedBox(height: 120),
              Image.asset(
                'images/logo.jpg',
                height: 110,
                width: 110,
              ),
              const SizedBox(height: 20),
              const Text(
                'Job Starter',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black),
              ),
              const SizedBox(height: 20),
              const Text(
                'We Connect Job Seekers With Companies',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey),
              ),
              const SizedBox(height: 100),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.4,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(10, 102, 196, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
              ),
              const SizedBox(height: 15),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: const Text(
                    'ALREADY HAVE AN ACCOUNT',
                    style: TextStyle(
                        fontSize: 12, color: Color.fromRGBO(10, 102, 196, 1)),
                  )),
            ])));
  }
}
