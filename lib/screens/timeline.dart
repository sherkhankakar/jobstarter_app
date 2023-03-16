import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../screens/company_profile.dart';
import '../screens/profile.dart';
import '../services/api_services.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key key, this.token, this.userId, this.image})
      : super(key: key);
  final String token;
  final String userId;
  final String image;

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Future<List<Data>> userData;
  String msg;

  Future<void> updateSubscription() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('subscription', '1');
    preferences.remove('subscription');
  }

  @override
  void initState() {
    updateSubscription();
    super.initState();
    userData = ApiServices().graduatesList(widget.token);
  }

  // Future<void> loadUsersData() async {
  //   try {
  //     final data = await ApiServices().graduatesList(widget.token);

  //     if (data['status'] == true && data['message'] == 'Graduates List') {
  //       final extractedUsers = jsonDecode(data) as Map<String, dynamic>;
  //       print(extractedUsers['message']);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (!mounted) {
      setState(() {});
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: Container(
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: FutureBuilder<List<Data>>(
            future: userData,
            builder: (ctx, snapshot) {
              if (snapshot.data == null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.blueGrey,
                  child: const Center(
                    child: CircularProgressIndicator(
                      semanticsValue: 'No data found',
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                List data = snapshot.data;

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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      token: widget.token,
                                      userId: widget.userId.toString(),
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      child: CircleAvatar(
                        radius: 20,
                        // child: Image.network(widget.image),
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 12,
                    ),
                    SizedBox(
                        height: 400,
                        child: CarouselSlider.builder(
                            options: CarouselOptions(
                              aspectRatio: 1.0,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              viewportFraction: 0.9,
                            ),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index,
                                int pageViewIndex) {
                              return GestureDetector(
                                onDoubleTap: () {
                                  sendMail(data[index].id.toString()).then(
                                    (value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Email sent to the graduate @${data[index].email}',
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              255, 62, 150, 76),
                                        ),
                                      );
                                    },
                                  );
                                },
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CompanyProfile(
                                                name: data[index].name,
                                                email: data[index].email,
                                                school: data[index].school,
                                                address: data[index].school,
                                                image:
                                                    'https://jobstarterapp.com/' +
                                                        data[index]
                                                            .profileImage,
                                                age: data[index].dob.toString(),
                                                description:
                                                    data[index].description,
                                              )));
                                },
                                child: Container(
                                  // margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color.fromARGB(
                                          255, 209, 205, 205)),
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        'https://jobstarterapp.com/' +
                                            data[index].profileImage,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                      top: 330,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8.0),
                                        color: const Color.fromARGB(
                                            137, 44, 42, 42),
                                        child: Text(
                                          snapshot.data[index].email,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            })),
                    const SizedBox(height: 50),
                    const Text(
                      'Double tap on the image to send email to the graduate',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.hasError}');
              }
              return const SizedBox();
            },
          )),
    );
  }

  Future<void> sendMail(String graduateId) async {
    await ApiServices().sendEmial(
      companyId: widget.userId,
      token: widget.token,
      graduateId: graduateId,
    );

    // final extractedData = jsonDecode(result) as Map<String, dynamic>;
    // final msg = extractedData['message'];
    // if (extractedData['status'] == true) {
    //   setState(() {
    //     this.msg = msg;
    //   });
    // }
  }

  // graduateSlider({var data, var snapshot}) {
  //   ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: data.length,
  //     itemBuilder: ((context, index) {
  //       return GestureDetector(
  //         onDoubleTap: () {
  //           sendMail(data[index].id.toString()).then(
  //             (value) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(
  //                   content: Text(
  //                     'Email sent to the graduate @${data[index].email}',
  //                   ),
  //                   backgroundColor: const Color.fromARGB(255, 62, 150, 76),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //         onTap: () {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => CompanyProfile(
  //                         name: data[index].name,
  //                         email: data[index].email,
  //                         school: data[index].school,
  //                         address: data[index].school,
  //                         image: 'https://jobstarterapp.com/' +
  //                             data[index].profileImage,
  //                         age: data[index].dob.toString(),
  //                         description: data[index].description,
  //                       )));
  //         },
  //         child: Container(
  //           height: 420,
  //           margin: const EdgeInsets.only(right: 10),
  //           padding: const EdgeInsets.only(right: 5),
  //           width: MediaQuery.of(context).size.width / 1.15,
  //           decoration: BoxDecoration(boxShadow: const [
  //             BoxShadow(blurRadius: 4, color: Colors.grey, spreadRadius: 2)
  //           ], borderRadius: BorderRadius.circular(30)),
  //           child: Stack(children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(30),
  //               child: Image.network(
  //                 'https://jobstarterapp.com/' + data[index].profileImage,
  //                 fit: BoxFit.cover,
  //                 height: 410,
  //                 width: MediaQuery.of(context).size.width / 1.15,
  //               ),
  //             ),
  //             Positioned(
  //               top: 330,
  //               left: 40,
  //               right: 40,
  //               child: Text(
  //                 snapshot.data[index].email,
  //                 style: const TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 14),
  //               ),
  //             ),
  //           ]),
  //         ),
  //       );
  //     }),
  //   );
  // }
}
