import 'package:flutter/material.dart';
import '../screens/opt_company.dart';
import '../screens/signup.dart';

class SignUpCompany extends StatefulWidget {
  const SignUpCompany({Key key}) : super(key: key);

  @override
  _SignUpCompanyState createState() => _SignUpCompanyState();
}

class _SignUpCompanyState extends State<SignUpCompany> {
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
                MaterialPageRoute(builder: (context) => const Signup()));
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
          const SizedBox(height: 25),
          Transform.translate(
              offset: const Offset(40, 0),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 25, color: Colors.black),
              )),
          Transform.translate(
              offset: const Offset(40, 0),
              child: const Text(
                'As Company',
                style: TextStyle(fontSize: 14, color: Colors.black),
              )),
          const SizedBox(height: 60),
          Container(
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const TextField(
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(214, 213, 211, 1),
                filled: true,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                // counter: Container(),
                counterText: '',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                hintText: 'Company name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(214, 213, 211, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(214, 213, 211, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const TextField(
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(214, 213, 211, 1),
                filled: true,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                // counter: Container(),
                counterText: '',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                hintText: 'Email',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(214, 213, 211, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(214, 213, 211, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const TextField(
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(214, 213, 211, 1),
                filled: true,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                // counter: Container(),
                counterText: '',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                hintText: 'Password',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(214, 213, 211, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(214, 213, 211, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const TextField(
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(214, 213, 211, 1),
                filled: true,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                // counter: Container(),
                counterText: '',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                hintText: 'Confirm Password',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(214, 213, 211, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(214, 213, 211, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
          ),
          const SizedBox(height: 150),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 50,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OtpCompany()));
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(10, 102, 196, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                child: const Text(
                  'Next',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
          )
        ],
      ),
    );
  }
}
