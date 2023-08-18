import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:hilwalal_app/sadaqah.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer/shimmer.dart';

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
  final String Type;
  ChariyahDash({required this.Type});

  @override
  _ChariyahDashState createState() => _ChariyahDashState();
}

class _ChariyahDashState extends State<ChariyahDash> {
  List<Donation> donations = [];
  String s = "\$";
  bool isShimmerVisible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isShimmerVisible = false;
      });
    });
    fetchData();
  }

  void _navigateToSadaqahForm(Donation donation) async {
    // Navigate to the SadaqahForm page and wait for the result
    bool shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SadaqahForm(
          ID: donation.id,
          name: donation.name,
          district: donation.District,
          amount: donation.amount,
          Type: donation.type,
          description: donation.description,
        ),
      ),
    );

    // Check if the result indicates that a refresh is needed
    if (shouldRefresh == true) {
      // Perform the data refresh
      fetchData();
    }
  }

  Future<void> fetchData() async {
    // String URL = "http://" + apiLogin + "/flutterApi/ChariyahData.php";
    String URL = apiDomain + "ChariyahData.php";
    try {
      final response = await http.post(Uri.parse(URL), body: {
        'Type': (widget.Type),
      });
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse);
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
        title: Text(
          'Hiil-Walaal',
          style: GoogleFonts.aBeeZee(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Color.fromARGB(255, 227, 224, 224),
      body: Visibility(
        visible: isShimmerVisible,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: 5, // Set a fixed number of shimmer cards to show
            itemBuilder: (context, index) {
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
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 24,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                          Container(height: 10),
                          Container(
                            height: 16,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                          Container(height: 10),
                          Container(
                            height: 16,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  height: 35,
                                  width: 100,
                                  color: Colors.grey[300],
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
        ),
        replacement: ListView.builder(
          padding: EdgeInsets.all(10),
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
                                  _navigateToSadaqahForm(donation);
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
      ),
    );
  }
}
