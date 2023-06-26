import 'dart:convert';
// import 'dart:js';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

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
      //print(responseData);

      final List<Map<String, String>> data =
          List<Map<String, String>>.from(responseData.map((item) {
        return Map<String, String>.from(item);
      }));

      print(data);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => BloodDonorsPage(
      //         data: List<Map<String, String>>.from(responseData)),
      //   ),
      //final responseData = json.decode(response.body);
      // final List<Map<String, String>> data =
      //     List<Map<String, String>>.from(responseData).map((item) {
      //   return item.map((key, value) => MapEntry(key, value.toString()));
      // }).toList();

      // print(data);
      // final List<Map<String, String>> data = [responseData];
      // print(data);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => BloodDonorsPage(
      //       data: data,
      //     ),
      //   ),
      // );
      //print(responseData);
      // Do something with responseData if needed
    } else {
      throw Exception('Failed to send blood type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HIILLWALAL APPLICATION'),
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

  BloodDonorsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donors'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => BloodDonorDetailsPage(item)),
              // );
            },
            child: ListTile(
              title: Text(item['name']!),
              subtitle: Text(item['Address']!),
              trailing: Text(item['BloodType']!),
            ),
          );
        },
      ),
    );
  }
}
