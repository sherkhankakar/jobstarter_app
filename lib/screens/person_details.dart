import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_search_with_apis/models/cat_model.dart';
import 'package:job_search_with_apis/screens/home_page.dart';
import 'package:job_search_with_apis/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails(
      {Key key,
      this.token,
      this.id,
      this.name,
      this.email,
      this.dob,
      this.address,
      this.school,
      this.description,
      this.image})
      : super(key: key);
  final String token;
  final String id;
  final String name;
  final String email;
  final String dob;
  final String address;
  final String school;
  final String description;
  final String image;
  @override
  _PersonDetailsState createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  final _formKey = GlobalKey<FormState>();

  SharedPreferences _preferences;

  TextEditingController nameCtr;
  TextEditingController emailCtr;
  TextEditingController addressCtr;
  TextEditingController descriptionCtr;
  TextEditingController dobCtr;
  TextEditingController schoolCtr;

  File _profileImage;
  final formater = DateFormat('yyyy-dd-MM');
  String age;
  var isLoading = false;

  List<CatModel> catModel = [];

  List<String> catText = ['Tech', 'Finance', 'Design', 'Film', 'Music'];
  bool isSelected = false;
  int selectedIndex = -1;
  String path;
  List<IconData> catIcon = [
    Icons.biotech_rounded,
    Icons.money_rounded,
    Icons.design_services_rounded,
    Icons.drive_file_move_outline,
    Icons.music_note_rounded,
  ];

  @override
  void initState() {
    nameCtr = TextEditingController(text: widget.name);
    emailCtr = TextEditingController(text: widget.email);
    addressCtr = TextEditingController(text: widget.address);
    descriptionCtr = TextEditingController(text: widget.description);
    dobCtr = TextEditingController(text: widget.dob);
    schoolCtr = TextEditingController(text: widget.school);
    age = dobCtr.text;

    catModel = List.generate(
        catIcon.length,
        (index) => CatModel(
              text: catText[index],
              iconData: catIcon[index],
            ));
    print(catModel.length);
    super.initState();
    Future.delayed(Duration.zero).then(
        (value) async => _preferences = await SharedPreferences.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(56, 55, 51, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(56, 55, 51, 1),
          title: const Center(
            child: Text(
              'Edit Your Profile',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          // margin: EdgeInsets.only(left: 15,right: 15),
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Choose Category',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: catModel.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int index) {
                        return buildCategories(
                          catModel[index].text,
                          catModel[index].iconData,
                          index,
                        );
                      }),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(231, 231, 231, 1)),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            height: 25,
                            width: 90,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(43, 42, 38, 1)),
                            child: TextFormField(
                              controller: nameCtr,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,

                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 5),
                                // counter: Container(),
                                counterText: '',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 8),
                                hintText: 'Enter your name here',
                              ),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Age',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(231, 231, 231, 1)),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            height: 25,
                            width: 90,
                            alignment: Alignment.topCenter,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(43, 42, 38, 1)),
                            child: DateTimePicker(
                              controller: dobCtr,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.top,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              dateLabelText: '',
                              onChanged: (val) {
                                setState(() {
                                  age = formater
                                      .format(DateTime.parse(dobCtr.text));

                                  print(age);
                                });
                              },
                              validator: (val) {
                                print(val);
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'School',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(231, 231, 231, 1)),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            height: 25,
                            width: 90,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(43, 42, 38, 1)),
                            child: TextFormField(
                              controller: schoolCtr,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 5),
                                // counter: Container(),
                                counterText: '',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 8),
                                hintText: 'Enter your school here',
                              ),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Stack(children: [
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(20),
                            //   child: Image.asset(
                            //     'images/dp.jpg',
                            //     height: 160,
                            //   ),
                            // ),
                            InkWell(
                              onTap: () => _showProfileImagePicker(context),
                              child: widget.image != null
                                  ? Container(
                                      width: 100,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: FittedBox(
                                        child: _profileImage == null
                                            ? Image.network(
                                                widget.image,
                                                // width: 100.0,
                                                // height: 160.0,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(_profileImage),
                                      ),
                                    )
                                  : Container(
                                      width: 100.0,
                                      height: 160.0,
                                      decoration: BoxDecoration(

                                          //color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Text('No Image uplaoded'),
                                    ),
                            ),
                          ])
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 310,
                        width: MediaQuery.of(context).size.width / 1.8,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(43, 42, 38, 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Transform.translate(
                                offset: const Offset(-30, 0),
                                child: const Text(
                                  'Short Description',
                                  style: TextStyle(color: Colors.white),
                                )),
                            Container(
                              height: 250,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(47, 46, 42, 1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                controller: descriptionCtr,
                                expands: true,
                                maxLines: null,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,

                                  filled: true,
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 5, top: 15),
                                  // counter: Container(),
                                  counterText: '',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                  hintText: 'Enter text here...',
                                ),
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.next,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Transform.translate(
                  offset: const Offset(5, 0),
                  child: const Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(47, 46, 42, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: emailCtr,
                    expands: true,
                    maxLines: null,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,

                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 15, top: 10),
                      // counter: Container(),
                      counterText: '',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      hintText: 'Enter Your Email Here',
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 5),
                Transform.translate(
                  offset: const Offset(5, 0),
                  child: const Text(
                    'Address',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(47, 46, 42, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: addressCtr,
                    expands: true,
                    maxLines: null,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,

                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.only(left: 15, top: 5),
                      // counter: Container(),
                      counterText: '',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      hintText: 'Enter Your Address Here',
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(left: 100, right: 100),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        updateProfile().whenComplete(() {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(10, 102, 196, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'DONE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                )
              ],
            ),
          ),
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
        path = pickedFile.path;
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
        path = pickedFile.path;
      });

      debugPrint('image url: $_profileImage');
    }
  }

  Future<void> updateProfile() async {
    Map<String, dynamic> data = {
      'user_id': widget.id,
      'name': nameCtr.text,
      'email': emailCtr.text,
      'school': schoolCtr.text,
      'description': descriptionCtr.text,
      'dob': age,
      'address': addressCtr.text,
      'image': widget.image,
    };

    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing...'),
        backgroundColor: Colors.green.shade300,
      ));

      if (_profileImage != null) {
        await ApiServices()
            .updateImage(widget.id, _profileImage, widget.token)
            .catchError((e) {
          print('error in api: $e');
        });

        print('image: ${_profileImage.path}');
      }

      dynamic res = await ApiServices().updataUserProfile(widget.token, data);
      print('update response: $res');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res['message'] == "Profile Updated Successfully!") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (ctx) => HomePage(
                      userId: widget.id,
                      token: widget.token,
                    )),
            (route) => false);
      }
    }
  }

  buildCategories(String text, IconData iconData, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: selectedIndex == index
                ? Colors.orange
                : const Color.fromRGBO(216, 216, 216, 1),
            child: IconButton(
              icon: Icon(iconData,
                  size: 25, color: const Color.fromRGBO(116, 114, 115, 1)),
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                  _preferences.setString('icon_value', catModel[index].text);
                });
              },
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(color: Color.fromRGBO(231, 231, 231, 1)),
          )
        ],
      ),
    );
  }
}
