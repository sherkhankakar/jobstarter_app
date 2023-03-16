import 'package:flutter/material.dart';
import 'package:job_search_with_apis/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './timeline.dart';

class SubscriptionDetailsScreen extends StatefulWidget {
  const SubscriptionDetailsScreen(
      {Key key, this.title, this.amount, this.userId, this.token})
      : super(key: key);
  final String title;
  final String amount;

  final String userId;

  final String token;

  @override
  State<SubscriptionDetailsScreen> createState() =>
      _SubscriptionDetailsScreenState();
}

class _SubscriptionDetailsScreenState extends State<SubscriptionDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final cvcCtr = TextEditingController();
  final creditCardCtr = TextEditingController();
  final controller = TextEditingController();
  var isLoading = false;
  String image;

  @override
  void initState() {
    getImage();
    super.initState();
  }

  Future<void> getImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      image = preferences.getString('image');
    });
    print(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.title)),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            buildFields(
              icon: Icons.credit_card,
              maxlength: 16,
              companyName: false,
              amount: 'Enter Your 16-digits credit card number',
              ctr: creditCardCtr,
            ),
            buildFields(
                icon: Icons.credit_score,
                maxlength: 3,
                amount: 'Enter 3 digit CVC number',
                companyName: false,
                ctr: cvcCtr),
            buildFields(
                amount: widget.amount,
                companyName: true,
                maxlength: 1,
                icon: Icons.money),
            buildFields(
              companyName: true,
              amount: widget.userId,
              maxlength: 1,
              icon: Icons.house,
            ),
            monthAndYearDropDown(
                list: months, dropdownValue: dropdownValueMonth),
            monthAndYearDropDown(list: year, dropdownValue: dropdownValueYear),
            monthAndYearDropDown(
              list: currency,
              dropdownValue: dropdwonValueCurrency,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  widget.title == 'free trial'
                      ? freeSubscription().whenComplete(() {
                          message == 'Payment successfully completed'
                              ? Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => Timeline(
                                      token: widget.token,
                                      userId: widget.userId,
                                      image: image,
                                    ),
                                  ),
                                  (route) => false,
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)));
                          isLoading = false;
                        })
                      : subscription().whenComplete(() {
                          message == 'Payment successfully completed'
                              ? Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => Timeline(
                                      token: widget.token,
                                      userId: widget.userId,
                                      image: image,
                                    ),
                                  ),
                                  (route) => false,
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMsg)));
                          isLoading = false;
                        });
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.orange,
                        backgroundColor: Colors.white,
                      )
                    : const Text('Subscribe'),
              ),
            )
          ],
        ),
      ),
    );
  }

  String dropdownValueMonth = 'Select Expiry Month';
  String dropdownValueYear = 'Select Expiry Year';
  String dropdwonValueCurrency = 'Choose Currency';
  String expiryMonth;
  String expiryYear;
  String currentCurrency;
  List<String> currency = [
    'Choose Currency',
    'USD',
  ];
  List<String> months = [
    'Select Expiry Month',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];
  List<String> year = [
    'Select Expiry Year',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032',
    '2033',
    '2034',
    '2035',
  ];
  monthAndYearDropDown({List<String> list, String dropdownValue}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        menuMaxHeight: 200.0,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            if (list.contains('2025')) {
              expiryYear = newValue;
            } else if (list.contains('01')) {
              expiryMonth = newValue;
            } else {
              currentCurrency = newValue;
            }

            print(expiryMonth);
            print(expiryYear);
          });
        },
        items: list.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  buildFields(
      {int maxlength,
      bool companyName,
      String amount,
      IconData icon,
      var ctr}) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: ctr ?? controller,
        readOnly: companyName,
        cursorColor: const Color.fromRGBO(10, 102, 196, 1),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your valid password';
          }
          return null;
        },
        maxLength: maxlength,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
          hintText: amount,
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
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  String message;
  String errorMsg;

  Future<void> freeSubscription() async {
    final result = await ApiServices().freeTrial(widget.token, widget.userId);
    setState(() {
      message = result['message'];
    });
  }

  Future<void> subscription() async {
    Map<String, dynamic> data = {
      'card_number': creditCardCtr.text,
      'exp_month': expiryMonth,
      'exp_year': expiryYear,
      'cvc': cvcCtr.text,
      'amount': widget.amount,
      'currency': 'USD',
      'company': widget.userId,
      'subscription': '1',
    };
    print(data);
    print(widget.token);

    final result =
        await ApiServices().subscriptions(token: widget.token, data: data);

    print('result $result');
    print('status: ${result['status'].runtimeType}');

    setState(() {
      message = result['message'];
      errorMsg = result['error'];
    });
  }
}
