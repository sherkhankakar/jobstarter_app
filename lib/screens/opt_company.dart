import 'dart:async';

import 'package:flutter/material.dart';
import 'package:job_search_with_apis/screens/person_details.dart';
import 'package:job_search_with_apis/screens/subsrction_screen.dart';
import 'package:job_search_with_apis/services/api_services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCompany extends StatefulWidget {
  const OtpCompany(
      {Key key, this.userId, this.usertype, this.email, this.token})
      : super(key: key);
  final int userId;
  final String usertype;
  final String email;
  final String token;
  @override
  _OtpCompanyState createState() => _OtpCompanyState();
}

class _OtpCompanyState extends State<OtpCompany> {
  StreamController<ErrorAnimationType> errorController;
  final otpCtr = TextEditingController();
  String currentText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    print(widget.userId);
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      setState(() {});
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: ListView(children: [
        const SizedBox(height: 100),
        const Icon(
          Icons.phone_iphone_rounded,
          color: Colors.blue,
          size: 70,
        ),
        const SizedBox(height: 40),
        const Center(
          child: Text(
            "Enter verification Code",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: Text(
            "Code was sent to ${widget.email}",
          ),
        ),
        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: PinCodeTextField(
            length: 4,
            obscureText: false,
            animationType: AnimationType.fade,
            animationDuration: const Duration(milliseconds: 300),
            errorAnimationController: errorController, // Pass it here
            controller: otpCtr,
            onChanged: (value) {
              setState(() {
                currentText = value;
              });
            },
            appContext: context,
          ),
          // child: OTPTextField(
          //     length: 4,
          //     width: MediaQuery.of(context).size.width,
          //     fieldWidth: 50,
          //     style: TextStyle(fontSize: 17),
          //     textFieldAlignment: MainAxisAlignment.spaceAround,
          //     onCompleted: (pin) {
          //       print("Completed: " + pin);
          //     },
          //     otpFieldStyle: OtpFieldStyle(
          //       borderColor: Colors.black,
          //     )),
        ),
        const SizedBox(height: 180),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 50,
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: ElevatedButton(
              onPressed: verifyOtp,
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(10, 102, 196, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
              child: ConnectionState.waiting == true
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Done',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
        )
      ]),
    );
  }

  Future<void> verifyOtp() async {
    print(widget.email);
    if (widget.email != null &&
        otpCtr.text != null &&
        otpCtr.text.length == 4) {
      final res = await ApiServices()
          .verifyOtp(
        otpCtr.text,
        widget.userId.toString(),
        widget.token,
      )
          .catchError((onError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(onError.toString())));
      });
      print(res);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (await res == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('api has no response'),
          backgroundColor: Colors.red.shade300,
        ));
      } else if (res['message'] == 'Account Successfully Verified!') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Verifying user...'),
          backgroundColor: Colors.green.shade300,
        ));
        if (widget.usertype == 'graduate' || widget.usertype == '1') {
          print(res['data']['profile_image']);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (ctx) => PersonDetails(
                        token: widget.token,
                        id: res['data']['id'].toString(),
                        email: res['data']['email'],
                        school: res['data']['school'],
                        name: res['data']['name'],
                        description: res['data']['description'],
                        address: res['data']['address'],
                        image: 'https://jobstarterapp.com/' +
                            res['data']['profile_image'],
                        dob: res['data']['dob'],
                      )),
              (route) => false);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        } else {
          print('res iamge : ${res['data']['profile_image']}');
          print('response company: $res');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => SubscriptionScreen(
                  token: widget.token,
                  userId: res['data']['id'].toString(),
                ),
              ),
              (route) => false);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['message']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }
}
