import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_search_with_apis/screens/person_details.dart';
import 'package:job_search_with_apis/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/notification.dart';
import '../screens/signup_start.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
    this.token,
    this.userId,
  }) : super(key: key);
  final String userId;

  final String token;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var _isInit = true;
  String catName;
  IconData _iconData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkCatData();
  }

  IconData getIconData(String categoryName) {
    if (categoryName == 'Tech') {
      return Icons.biotech_rounded;
    } else if (categoryName == 'Finance') {
      return Icons.money_rounded;
    } else if (categoryName == 'Design') {
      return Icons.design_services_rounded;
    } else if (categoryName == 'Film') {
      return Icons.drive_file_move_outline;
    } else if (categoryName == 'Music') {
      return Icons.music_note_rounded;
    } else {
      return Icons.bookmark;
    }
  }

  void checkCatData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    catName = preferences.getString('icon_value');

    print(catName);
  }

  void clearData() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove('user_id');
    _preferences.remove('shared_token');
    _preferences.remove('id');
    print(catName);
  }

  static const String imageUrl = 'https://jobstarterapp.com/';
  String imgUrl;
  var isLoading = false;
  Future<Map<String, dynamic>> getData() async {
    dynamic useRes;

    useRes = await ApiServices().getUserData(widget.token, widget.userId);

    return useRes;
  }

  @override
  void didChangeDependencies() {
    // Future.delayed(Duration.zero).then((value) => getData());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) {
      Future.delayed(Duration.zero)
          .then((value) => getData())
          .then((value) => setState(() {}));
    }
    return Scaffold(
      backgroundColor: const Color(0xff8B8883),
      drawer: Container(
        margin: const EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width / 2,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(45), bottomRight: Radius.circular(45)),
          child: Drawer(
            elevation: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Transform.translate(
                  offset: const Offset(10, 0),
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: const Color.fromRGBO(10, 102, 196, 1),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        imgUrl ?? 'images/dp.jpg',
                      ),
                      radius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.6,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        ApiServices()
                            .logOut(widget.userId, widget.token)
                            .then((value) {
                          clearData();
                          print(value);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const SignUpStart()),
                              (route) => false);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(10, 102, 196, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: isLoading == true
                          ? const CircularProgressIndicator()
                          : Row(
                              //    mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Icons.logout,
                                  color: Color.fromRGBO(18, 15, 46, 1),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            )),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
        // leading: IconButton(onPressed: () {  }, icon: Icon(Icons.menu_rounded,size: 30,color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationPage(
                            userid: widget.userId,
                            token: widget.token,
                          ))).then((value) {
                setState(() {});
              });
            },
            icon:
                const Icon(Icons.notifications, size: 30, color: Colors.black),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: getData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              String name = snapshot.data['data']['name'];
              String email = snapshot.data['data']['email'];
              String profileImg =
                  imageUrl + snapshot.data['data']['profile_image'];
              String address = snapshot.data['data']['address'];
              String school = snapshot.data['data']['school'];
              String description = snapshot.data['data']['description'];
              String age = snapshot.data['data']['dob'];

              DateTime ageInYears = DateFormat('yyyy-MM-dd').parse(age);
              DateTime today = DateTime.now();

              int yearDiff = today.year - ageInYears.year;
              int monthDiff = today.month - ageInYears.month;
              int dayDiff = today.day - ageInYears.day;

              print('object: $yearDiff, $monthDiff, $dayDiff');

              imgUrl = profileImg;

              return Container(
                width: double.infinity,
                height: 280,
                margin: const EdgeInsets.only(left: 8.0, right: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              imgUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            )),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          ListTile(
                            leading: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PersonDetails(
                                              token: widget.token,
                                              id: widget.userId,
                                              name: name,
                                              email: email,
                                              address: address,
                                              description: description,
                                              image: profileImg,
                                              school: school,
                                              dob: age,
                                            )));
                              },
                              icon: const Icon(
                                Icons.edit_rounded,
                                color: Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: null,
                              icon: Icon(
                                getIconData(catName),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4, right: 4),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: name ?? 'Your name',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: '\n$address' ?? '\nAddress\nAdress',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\n\n$description' ??
                                        '\n\n"We want a software engineer, who is smart, hard-worker and willing to give his best for the company... "',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.only(left: 2, right: 2),
                            child: Align(
                              alignment: const Alignment(0, -1),
                              child: Text(
                                '$yearDiff Years | $school\n$email' ??
                                    '24 Years | Melbourne Tech Institute\nJamesanderson@gmail.com',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5,
                                  color: Colors.green,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              debugPrint('error : ${snapshot.error}');
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
