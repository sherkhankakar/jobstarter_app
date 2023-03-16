import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key, this.userid, this.token}) : super(key: key);
  final String userid;
  final String token;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";

// FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: [
          CircleAvatar(
              backgroundColor: const Color.fromRGBO(206, 160, 170, 1),
              radius: 70,
              child: Image.asset(
                'images/profile-modified.png',
                height: 140,
                fit: BoxFit.cover,
              )),
          const SizedBox(height: 50),
          Container(
            height: 100,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(232, 228, 227, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const ListTile(
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.notification_important_rounded,
                    size: 40,
                  ),
                  title: Text(
                      'Congratulations your profile has been approved by admin'),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [Text('12/12/2022'), Text('11:20 AM')],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 100,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(232, 228, 227, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const ListTile(
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.notification_important_rounded,
                    size: 40,
                  ),
                  title: Text(
                      'Congratulations you have been shortlisted by Google'),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [Text('12/12/2022'), Text('11:20 AM')],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
