import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile(
      {Key key,
      this.name,
      this.description,
      this.age,
      this.email,
      this.address,
      this.school,
      this.image})
      : super(key: key);
  final String name;
  final String description;
  final String age;
  final String email;
  final String address;
  final String school;
  final String image;

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  String catName;

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
      return Icons.question_mark_sharp;
    }
  }

  void checkCatData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    catName = preferences.getString('icon_value');

    print(catName);
  }

  @override
  void initState() {
    super.initState();
    checkCatData();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime birthday = DateFormat('yyyy-MM-dd').parse(widget.age);
    int year = today.year - birthday.year;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(56, 55, 51, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(56, 55, 51, 1),
        title: const Center(
          child: Text(
            'Profile',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        // margin: EdgeInsets.only(left: 15,right: 15),
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Category',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 80,
              child: Column(children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.orange,
                  child: Icon(
                    getIconData(catName),
                  ),
                ),
                Text(
                  catName ?? 'Not Spicified',
                  style:
                      const TextStyle(color: Color.fromRGBO(231, 231, 231, 1)),
                )
              ]),
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
                        child: TextField(
                          readOnly: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 5),
                            // counter: Container(),
                            counterText: '',
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 8),
                            hintText: widget.name,
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
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(43, 42, 38, 1)),
                        child: TextField(
                          readOnly: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 5),
                            // counter: Container(),
                            counterText: '',
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 12),
                            hintText: year.toString(),
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
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
                        child: TextField(
                          readOnly: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(left: 5),
                            // counter: Container(),
                            counterText: '',
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 8),
                            hintText: widget.school,
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 100,
                        height: 160,
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              widget.image,
                              height: 160,
                              width: 100,
                            ),
                          ),
                          Positioned(
                            left: 65,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.upload_outlined,
                                  color: Colors.black,
                                  size: 25,
                                )),
                          )
                        ]),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 310,
                    width: MediaQuery.of(context).size.width / 1.7,
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
                          child: TextField(
                            readOnly: true,
                            expands: true,
                            maxLines: null,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,

                              filled: true,
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.only(left: 5, top: 15),
                              // counter: Container(),
                              counterText: '',
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              hintText: widget.description,
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(47, 46, 42, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                readOnly: true,
                expands: true,
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  filled: true,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 15, top: 10),
                  // counter: Container(),
                  counterText: '',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                  hintText: widget.email,
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(47, 46, 42, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                readOnly: true,
                expands: true,
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  filled: true,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 15, top: 5),
                  // counter: Container(),
                  counterText: '',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
                  hintText: widget.address,
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
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(10, 102, 196, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Back',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
