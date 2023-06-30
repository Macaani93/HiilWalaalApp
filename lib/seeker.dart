import 'dart:convert';
// import 'dart:js';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'loginpage.dart';

class seekerForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String _regDate = "";
  String? _bloodType;
  Future<void> _sendBloodType(BuildContext context) async {
    if (_bloodType == null) {
      return;
    }

    final url = Uri.parse('http://' + apiLogin + '/flutterApi/bloodseeker.php');
    final response = await http.post(
      url,
      body: {'blood_type': _bloodType!},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<Map<String, String>> data =
          List<Map<String, String>>.from(responseData.map((item) {
        return Map<String, String>.from(item);
      }));
      print('Data: $data');
      // Navigate to the new page and pass the data as arguments
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BloodDonorsPage(data: data),
        ),
      );
    } else {
      throw Exception('Failed to send blood type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiil-Walal'),
        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 25),
                      Icon(
                        Icons.bloodtype,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Blood Seeker',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Blood Type",
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "1",
                        child: Text("A+"),
                      ),
                      DropdownMenuItem(
                        value: "5",
                        child: Text("AB+"),
                      ),
                      DropdownMenuItem(
                        value: "3",
                        child: Text("B+"),
                      ),
                      DropdownMenuItem(
                        value: "7",
                        child: Text("O+"),
                      ),
                      DropdownMenuItem(
                        value: "2",
                        child: Text("A-"),
                      ),
                      DropdownMenuItem(
                        value: "6",
                        child: Text("AB-"),
                      ),
                      DropdownMenuItem(
                        value: "4",
                        child: Text("B-"),
                      ),
                      DropdownMenuItem(
                        value: "8",
                        child: Text("O-"),
                      ),
                    ],
                    value: _bloodType, // Set the current selected value
                    onChanged: (value) {
                      _bloodType = value;
                    },
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () async {
                      _sendBloodType(context);
                    },
                    child: Text('Get Now'),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BloodDonorsPage extends StatelessWidget {
  final List<Map<String, String>> data;

  const BloodDonorsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 213, 212),
      appBar: AppBar(
        title: Text('Blood Donors'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(3, 10, 3, 0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['name'] ?? '',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                item['Phone'] ?? '',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${item['Address']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 38, 193, 182),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () {
                                final phoneUri =
                                    Uri(scheme: 'tel', path: item['Phone']!);
                                launchUrl(phoneUri);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                final phoneUri =
                                    Uri(scheme: 'sms', path: item['Phone']!);
                                launchUrl(phoneUri);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
