import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/signup_start.dart';
import '../services/api_services.dart';

class Profile extends StatefulWidget {
  const Profile({Key key, this.token, this.userId}) : super(key: key);
  final String token;
  final String userId;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _profileImage;
  var isLoading = false;
  var updateImage = false;

  void clearData() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
  }

  Future<Map<String, dynamic>> getData() async {
    dynamic useRes;

    useRes = await ApiServices().getUserData(widget.token, widget.userId);
    print('user Response: $useRes');
    return useRes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              updateData();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const Timeline()));
            },
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
          title: Transform.translate(
            offset: const Offset(90, 0),
            child: const Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (ctx, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
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
              return ListView(
                children: [
                  //SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(children: [
                      // CircleAvatar(
                      //   backgroundColor: const Color.fromRGBO(206, 160, 170, 1),
                      //   radius: 70,
                      //   child: ClipOval(
                      //       child: Image.network(
                      //     'https://jobstarterapp.com/' +
                      //         snapshot.data['data']['profile_image'],
                      //     fit: BoxFit.fill,
                      //   )),
                      // ),
                      InkWell(
                        onTap: () => _showProfileImagePicker(context),
                        child: snapshot.data['data']['profile_image'] != null
                            ? CircleAvatar(
                                backgroundColor:
                                    const Color.fromRGBO(206, 160, 170, 1),
                                radius: 70,
                                child: _profileImage == null
                                    ? CircleAvatar(
                                        radius: 70,
                                        backgroundImage: NetworkImage(
                                          'https://jobstarterapp.com/' +
                                              snapshot.data['data']
                                                  ['profile_image'],
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 70,
                                        backgroundImage:
                                            FileImage(_profileImage)),
                              )
                            : const CircularProgressIndicator(),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Choose Profile \nPicture',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          updateImage = true;
                        });
                        ApiServices()
                            .updateImage(
                                widget.userId, _profileImage, widget.token)
                            .whenComplete(() {
                          setState(() {
                            updateImage = false;
                          });
                        });
                      },
                      child: updateImage
                          ? const CircularProgressIndicator()
                          : const Text('Save Image')),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        // counter: Container(),
                        counterText: '',
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                        hintText: snapshot.data['data']['name'],
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        // counter: Container(),
                        counterText: '',
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                        hintText: snapshot.data['data']['email'],
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
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
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        // counter: Container(),
                        counterText: '',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                        hintText: 'Password',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
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
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        // counter: Container(),
                        counterText: '',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                        hintText: 'Confirm Password',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
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
                  const SizedBox(height: 45),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 50,
                    margin: const EdgeInsets.only(left: 120, right: 120),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });

                          ApiServices()
                              .logOut(widget.userId, widget.token)
                              .then((value) {
                            clearData();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpStart()),
                                (route) => false);
                          });
                          setState(() {
                            isLoading = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(10, 102, 196, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100))),
                        child: isLoading == true
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Logout',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                  )
                ],
              );
            } else {
              debugPrint('snapshot: ${snapshot.error}');
            }
            return const SizedBox();
          },
        ));
  }

  _showProfileImagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  _imgFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1800,
      maxWidth: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });

      debugPrint('image url: $_profileImage');
    }
  }

  Future<void> updateData() async {
    if (_profileImage != null) {
      ApiServices()
          .updateImage(widget.userId, _profileImage, widget.token)
          .then((value) => print('updated successfully'));
    }
  }
}
