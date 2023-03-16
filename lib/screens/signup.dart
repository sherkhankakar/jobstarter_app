import 'package:flutter/material.dart';
import '../screens/sign_up_graduate.dart';
import '../screens/signup_start.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpStart()));
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 90),
          Transform.translate(
            offset: const Offset(60, 0),
            child: const Text(
              'Sign Up As',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(56, 55, 51, 1)),
            ),
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   SignUpGraduate.routeName,
                      // );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpGraduate(
                                    userType: 'graduate',
                                  )));
                    },
                    child: CircleAvatar(
                        backgroundColor: const Color.fromRGBO(11, 102, 195, 1),
                        radius: 50,
                        child: ClipOval(
                            child: Image.asset(
                          'images/graduate.png',
                          height: 70,
                          fit: BoxFit.cover,
                        ))),
                  ),
                  const SizedBox(height: 10),
                  const Text('Graduates', style: TextStyle(fontSize: 16))
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpGraduate(
                                    userType: 'company',
                                  )));
                    },
                    child: CircleAvatar(
                        backgroundColor: const Color.fromRGBO(11, 102, 195, 1),
                        radius: 50,
                        child: ClipOval(
                            child: Image.asset(
                          'images/company.png',
                          height: 70,
                          fit: BoxFit.cover,
                        ))),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Companies',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
