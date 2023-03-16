import 'package:flutter/material.dart';
import 'package:job_search_with_apis/screens/subsrction_screen.dart';
import 'package:job_search_with_apis/screens/timeline.dart';
import 'package:job_search_with_apis/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'opt_company.dart';

String sharedUserId;
String sharedTokenForLogin;

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  ApiServices _apiServices;
  final _formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    _apiServices = ApiServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Transform.translate(
              offset: const Offset(-110, 0),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 150),
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
              child: TextFormField(
                controller: emailCtr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                cursorColor: const Color.fromRGBO(10, 102, 196, 1),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: Colors.black,
                  ),
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
              child: TextFormField(
                controller: passCtr,
                cursorColor: const Color.fromRGBO(10, 102, 196, 1),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your valid password';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
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
            const SizedBox(height: 200),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                  onPressed: loginUser,
                  // onPressed: () async {
                  //   if (_formKey.currentState.validate()) {
                  //     setState(() {
                  //       isLoading = true;
                  //     });
                  //     await _apiServices.loginUser(
                  //       password: passCtr.text,
                  //       email: emailCtr.text,
                  //       ctx: context,
                  //     );
                  //   }

                  //   // Navigator.push(
                  //   //     context,
                  //   //     MaterialPageRoute(
                  //   //         builder: (context) => const Timeline()));
                  // },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(10, 102, 196, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing...'),
        backgroundColor: Colors.green.shade300,
      ));

      var res = await _apiServices.loginApi(emailCtr.text, passCtr.text);
      print('res: $res');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      print(res['message']);

      if (res['message'] == 'Invalid Credentials' || res['data'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res['message']),
          backgroundColor: Colors.green.shade300,
        ));
      } else if (res['message'] == 'Successfully Loged In' &&
          res['data']['email'] == emailCtr.text) {
        print(res['token']);

        String accessToken = res['token'];
        SharedPreferences _shared = await SharedPreferences.getInstance();

        _shared.setString('user_id', res['data']['role']);
        _shared.setString('shared_token', res['token']);
        _shared.setInt('id', res['data']['id']);
        _shared.setString('verified', res['data']['verified']);
        _shared.setString('email', res['data']['email']);
        _shared.setString('image', res['data']['profile_image']);
        _shared.setString('subscription', res['data']['trial_avail']);

        if (res['data']['verified'] == '0') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Please verify your account by enter the otp sent to ${res['data']['email']}'),
            ),
          );

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (ctx) => OtpCompany(
                        userId: res['data']['id'],
                        usertype: res['data']['role'],
                        email: res['data']['email'],
                        token: accessToken,
                      )),
              (route) => false);
        } else if (res['data']['role'] == 'graduate') {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (ctx) => HomePage(
                      token: res['token'],
                      userId: res['data']['id'].toString(),
                      // profilePhoto: res['data']['profile_image'],
                    )),
            (route) => false,
          );
        } else {
          print(res['data']['trial_avail'].runtimeType);
          if (res['data']['trial_avail'] == '0') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => SubscriptionScreen(
                      token: res['token'],
                      userId: res['data']['id'].toString(),
                    )));
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (ctx) => Timeline(
                          token: res['token'],
                          userId: res['data']['id'].toString(),
                          image: 'https://jobstarterapp.com/' +
                              res['data']['profile_image'],
                        )),
                (route) => false);
          }
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: ${res['message']}')));
      }
    }
  }
}
