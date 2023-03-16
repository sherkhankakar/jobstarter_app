import 'package:flutter/material.dart';
import 'package:job_search_with_apis/screens/subscription_details_screen.dart';
import 'package:job_search_with_apis/services/api_services.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key key, this.token, this.userId})
      : super(key: key);

  final String token;
  final String userId;

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final textColor = Colors.white;
  final List<Color> colorList = [
    Colors.purple,
    Colors.orange,
    Colors.blueAccent
  ];
  @override
  void initState() {
    ApiServices().getAllSub(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Pricing',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 8),
          child: FutureBuilder<Map<String, dynamic>>(
            future: ApiServices().getAllSub(widget.token),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text('no data found'),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: <Widget>[
                              buildCard(
                                packageName: snapshot.data['data'][index]
                                    ['name'],
                                amount: snapshot.data['data'][index]['amount'],
                                color: colorList[index],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        }));
                  }
              }
            },
          )),
    );
  }

  buildCard({String packageName, String amount, Color color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        child: GridTile(
          footer: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      packageName == 'Free Trail'
                          ? 'Start a 7 days free Trail'
                          : '\$$amount/Year',
                      style: TextStyle(color: textColor),
                    ),
                    flex: 5,
                  ),
                  Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SubscriptionDetailsScreen(
                                title: packageName,
                                amount: amount,
                                userId: widget.userId ?? 'testing',
                                token: widget.token ?? 'testing',
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Buy Now',
                              style: TextStyle(color: textColor),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: textColor,
                            ),
                          ],
                        ),
                      ))
                ]),
          ),
          header: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              packageName,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18, color: textColor),
            ),
          ),
          child: Container(
            color: color,
          ),
        ),
      ),
    );
  }
}
