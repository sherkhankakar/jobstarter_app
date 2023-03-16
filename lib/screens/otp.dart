import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class Otp extends StatefulWidget {
  const Otp({Key key, this.token, this.usertype, this.email}) : super(key: key);
  final String token;
  final String usertype;
  final String email;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final otpController = OtpFieldController();
  EmailAuth emailAuth;
  @override
  void initState() {
    super.initState();

    emailAuth = EmailAuth(sessionName: "Sample session");
    //emailAuth.config();
  }

  @override
  Widget build(BuildContext context) {
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
          child: OTPTextField(
              controller: otpController,
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
              otpFieldStyle: OtpFieldStyle(
                borderColor: Colors.black,
              )),
        ),
        const SizedBox(height: 20),
        TweenAnimationBuilder<Duration>(
            duration: const Duration(minutes: 0),
            tween: Tween(begin: const Duration(minutes: 0), end: Duration.zero),
            onEnd: () {
              print('Timer ended');
            },
            builder: (BuildContext context, Duration value, Widget child) {
              final minutes = value.inMinutes;
              final seconds = value.inSeconds % 60;
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('Resend in $minutes:$seconds',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 14)));
            }),
        const SizedBox(height: 130),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 50,
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: ElevatedButton(
              onPressed: () {
                // ApiServices().verify_otp().then((value) => Navigator.of(context)
                //     .pushAndRemoveUntil(
                //         MaterialPageRoute(
                //             builder: (ctx) => const PersonDetails()),
                //         (route) => false));
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(10, 102, 196, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
              child: const Text(
                'Done',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
        )
      ]),
    );
  }
}
