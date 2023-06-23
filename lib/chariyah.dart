import 'package:flutter/material.dart';

import 'loginpage.dart';

class chariyahForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _phone = "";
  String _address = "";
  String _amount = "";
  //String _description = "";
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
              Icons.attach_money,
              size: 50.80,
              color: Colors.green,
            ),
            Text(
              'Chariyah',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 43, 3, 186),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
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
              //obscureText: true,
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
              //obscureText: true,
              decoration: InputDecoration(
                hintText: 'DoateDate',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              //obscureText: true,
              decoration: InputDecoration(
                hintText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Text('Donate Now'),
            ),
          ],
        ),
      ),
    );
  }
}
