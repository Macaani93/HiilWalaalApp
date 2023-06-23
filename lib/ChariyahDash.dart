import 'package:flutter/material.dart';
import 'package:hilwalal_app/donor.dart';
import 'package:hilwalal_app/sadaqah.dart';

class ChariyahDash extends StatelessWidget {
  ChariyahDash({Key? key});

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 224, 224),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                      // Display an image at the top of the carz|||||||d that fills the width of the card and has a height of 160 pixels

                      Image.asset(
                        ('Images/masjid1.jpg'),
                        height: 110,
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
                              "Masjid Abuu Hurera",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey[800],
                              ),
                            ),
                            // Add a space between the title and the text
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Text(
                              ('Waxa uu ku yaala Bakaaro'),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Text(
                              ('018369673'),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                            // Add a row with two buttons spaced apart and aligned to the right side of the card
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
                                      'Sadaqa Chariyah',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ), // Add a spacer to push the buttons to the right side of the card
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
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SadaqahForm()))
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
                height: 5,
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
                      // Display an image at the top of the carz|||||||d that fills the width of the card and has a height of 160 pixels

                      Image.asset(
                        ('Images/masjid2.jfif'),
                        height: 110,
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
                              "Masjidu raxma",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey[800],
                              ),
                            ),
                            // Add a space between the title and the text
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Text(
                              ('Waxa uu ku yaala madiino'),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                            // Add a row with two buttons spaced apart and aligned to the right side of the card
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Text(
                              ('0617937157'),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                            // Add a row with two buttons spaced apart and aligned to the right side of the card
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
                                      'Sadaqa Chariyah',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ), // Add a spacer to push the buttons to the right side of the card
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
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SadaqahForm()))
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

              // Add widgets here...
            ],
          ),
        ),
      ),
    );
  }
}
