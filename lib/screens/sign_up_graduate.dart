import 'package:flutter/material.dart';
import 'package:job_search_with_apis/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/signup.dart';
import 'opt_company.dart';

class SignUpGraduate extends StatefulWidget {
  const SignUpGraduate({Key key, this.userType}) : super(key: key);

  final String userType;

  @override
  _SignUpGraduateState createState() => _SignUpGraduateState();
}

class _SignUpGraduateState extends State<SignUpGraduate> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  final Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
    'type': ''
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userType);
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 25),
            Transform.translate(
                offset: const Offset(40, 0),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                )),
            Transform.translate(
                offset: const Offset(40, 0),
                child: Text(
                  widget.userType == 'graduate' ? 'As Graduate' : 'As Company',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                )),
            const SizedBox(height: 60),
            buildTextField(
              authValue: _authData['name'],
              textCtr: nameCtr,
              icon: widget.userType == 'graduate' ? Icons.person : null,
              hintText:
                  widget.userType == 'graduate' ? 'User name' : 'Company title',
              action: TextInputAction.next,
              textInputType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            buildTextField(
              authValue: _authData['email'],
              icon: Icons.email_rounded,
              hintText: 'Email',
              textCtr: emailCtr,
              textInputType: TextInputType.emailAddress,
              action: TextInputAction.next,
            ),
            const SizedBox(
              height: 20,
            ),
            buildTextField(
              authValue: _authData['password'],
              textCtr: passwordCtr,
              icon: Icons.lock,
              hintText: 'Password',
              textInputType: TextInputType.visiblePassword,
              action: TextInputAction.done,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 150),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                  onPressed: registerUser,
                  // () {
                  // ApiServices()
                  //     .authenticate(
                  //       name: nameCtr.text,
                  //       email: emailCtr.text,
                  //       password: passwordCtr.text,
                  //       type: widget.userType,
                  //     )
                  //     .then(
                  //       (userId) => Navigator.pushAndRemoveUntil(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (ctx) => Otp(
                  //                   userId: userId,
                  //                   userEmail: emailCtr.text,
                  //                 )),
                  //         (route) => false,
                  //       ),
                  //     );
                  // },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(10, 102, 196, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    try {
      if (_formKey.currentState.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Processing Data'),
          backgroundColor: Colors.green.shade300,
        ));

        final res = await ApiServices()
            .authenticate(
              email: emailCtr.text,
              name: nameCtr.text,
              type: widget.userType,
              password: passwordCtr.text,
            )
            .catchError((onError) => print(StackTrace.current));

        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        SharedPreferences prefs = await SharedPreferences.getInstance();


        if (res['status'] == true) {
          
          prefs.setString('user_id', res['data']['role']);
        prefs.setString('shared_token', res['token']);
        prefs.setInt('id', res['data']['id']);
        prefs.setString('verified', res['data']['verified']);
        prefs.setString('email', res['data']['email']);
       prefs.setString('image', res['data']['profile_image']);
        
          
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => OtpCompany(
                  email: res['data']['email'],
                  userId: res['data']['id'],
                  usertype: res['data']['role'],
                  token: res['token'],
                ),
              ),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${res['message']}'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }  catch (e) {
      print(e);
      print(StackTrace.current);
    }
  }

  buildTextField(
      {String hintText,
      IconData icon,
      TextInputAction action,
      TextInputType textInputType,
      TextEditingController textCtr,
      String authValue}) {
    return Container(
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
      child: TextFormField(
        controller: textCtr,
        cursorColor: const Color.fromRGBO(10, 102, 196, 1),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          fillColor: const Color.fromRGBO(214, 213, 211, 1),
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          // counter: Container(),
          counterText: '',
          hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(214, 213, 211, 1),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(214, 213, 211, 1),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        onSaved: (value) => _authData[authValue] = value,
        keyboardType: TextInputType.visiblePassword,
        obscureText: hintText == 'Password' ? true : false,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
