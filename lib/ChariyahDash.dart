import 'package:flutter/material.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:hilwalal_app/sadaqah.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Donation {
  final String id;
  final String name;
  final String phone;
  final String type;
  final String District;
  final String donateDate;
  final String amount;
  final String description;
  final String userID;

  Donation({
    required this.id,
    required this.name,
    required this.phone,
    required this.type,
    required this.District,
    required this.donateDate,
    required this.amount,
    required this.description,
    required this.userID,
  });
}

class ChariyahDash extends StatefulWidget {
  ChariyahDash({Key? key}) : super(key: key);

  @override
  _ChariyahDashState createState() => _ChariyahDashState();
}

class _ChariyahDashState extends State<ChariyahDash> {
  List<Donation> donations = [];
  String s = "\$";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse("http://" + apiLogin + "/flutterApi/ChariyahData.php"));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          donations = jsonResponse
              .map((data) => Donation(
                    id: data['ID'],
                    name: data['Name'],
                    phone: data['Phone'],
                    type: data['Type'],
                    donateDate: data['DonateDate'],
                    amount: data['Amount'],
                    District: data['District'],
                    description: data['Description'],
                    userID: data['UserID'],
                  ))
              .toList();
        });
      } else {
        // Handle error status code
        print('API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Color.fromARGB(255, 227, 224, 224),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: donations.length,
            itemBuilder: (context, index) {
              final donation = donations[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 35,
                            width: 330,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 11, 229),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                donation.type,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            donation.name,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.grey[800],
                            ),
                          ),
                          Container(height: 10),
                          Text(
                            donation.District,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                          Container(height: 10),
                          Text(
                            donation.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 229, 38, 0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Remaining: \$' + donation.amount,
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 244, 242, 242),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                    backgroundColor:
                                        Color.fromARGB(255, 4, 229, 0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SadaqahForm(
                                          name: donation.name,
                                          district: donation.District,
                                          amount: donation.amount,
                                          Type: donation.type,
                                          description: donation.description,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.attach_money,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Donate Now',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
