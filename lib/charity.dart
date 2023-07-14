// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'chariyah.dart';
import 'sadaqah.dart';

class charity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HIILWALAAL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SadaqahForm(
                  //             name: donation.name,
                  //             district: donation.District,
                  //             amount: donation.amount,
                  //             Type: donation.type,
                  //           )),
                  // );
                },
                child: Text(
                  'SADAQAH',
                  style: TextStyle(fontSize: 30.0),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(400, 80)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => chariyahForm()),
                  );
                },
                child: Text(
                  'CHARIYAH',
                  style: TextStyle(fontSize: 30),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(400, 80)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
