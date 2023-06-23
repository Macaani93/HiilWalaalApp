import 'package:flutter/material.dart';

import 'loginpage.dart';

class seekerForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // String _name = "";
  // String _phone = "";
  // String _address = "";
  // String _birthDate = "";
  String _regDate = "";
  // String _userID = "1";
  String? _bloodType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HIILLWALAL APPLICATION'),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.settings),
          //   onPressed: () {
          //     // Do something when the button is pressed
          //   },
          // ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bloodtype,
              size: 30.30,
              color: Colors.red,
            ),
            Text(
              'Blood Seeker',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 43, 3, 186),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                hintText: 'FullName',
                // border: OutlineInputBorder(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                hintText: 'Phone',
                // border: OutlineInputBorder(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Address',
                // border: OutlineInputBorder(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'RegDate',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Blood Type",
                // border: OutlineInputBorder(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
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

                // Add other DropdownMenuItem items for different blood types
              ],
              value: _bloodType, // Set the current selected value
              onChanged: (value) {
                _bloodType = value;
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Text('Get Now'),
            ),
          ],
        ),
      ),
    );
  }
}
