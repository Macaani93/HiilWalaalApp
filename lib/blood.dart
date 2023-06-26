import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:hilwalal_app/Api/Sessions.dart';

import 'donor.dart';
import 'seeker.dart';

class blood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userRole = GetRole();

    Widget button;

    if (userRole == 'donor') {
      button = ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DonorForm()),
          );
        },
        child: Text('Blood Donor'),
      );
    } else if (userRole == 'seeker') {
      button = ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => seekerForm()),
          );
        },
        child: Text('Blood Seeker'),
      );
    } else {
      // If the user's role is not recognized, render an error message or default button
      button = Text('Error: unrecognized user role');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HIILWALAL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            minimumSize: MaterialStateProperty.all(Size(400, 80)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.blue),
            textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //button,
              SizedBox(
                height: 10,
              ),
              Container(
                child: Card(
                  // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // Set the clip behavior of the card
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // Define the child widgets of the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                      Image.asset(
                        ('Images/BLOOD.jpg'),
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      // Add a container with padding that contains the card's title, text, and buttons
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Display the card's title using a font size of 24 and a dark grey color
                            Text(
                              "Blood Donation",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey[800],
                              ),
                            ),
                            // Add a space between the title and the text
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Text(
                              ('Your Blood can save A person`s Life'),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                            // Add a row with two buttons spaced apart and aligned to the right side of the card
                            Row(
                              children: <Widget>[
                                // Add a spacer to push the buttons to the right side of the card
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
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DonorForm()))
                                    },
                                    icon: Icon(
                                      Icons.add_home,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Register Now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Add a small space between the card and the next widget
                      Container(height: 5),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Card(
                  // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // Set the clip behavior of the card
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // Define the child widgets of the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                      Image.asset(
                        ('Images/blood-seeker.jpg'),
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                      // Add a container with padding that contains the card's title, text, and buttons
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Display the card's title using a font size of 24 and a dark grey color
                            Text(
                              "Blood Receiver",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey[800],
                              ),
                            ),
                            // Add a space between the title and the text
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Text(
                              ('Your can Search A blood Type, To save A Life'),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                            // Add a row with two buttons spaced apart and aligned to the right side of the card
                            Row(
                              children: <Widget>[
                                // Add a spacer to push the buttons to the right side of the card
                                const Spacer(),

                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      textStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255)),
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  seekerForm()))
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Search',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Add a small space between the card and the next widget
                      Container(height: 5),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(26, 137, 134, 134),
      ),
    );
  }
}
