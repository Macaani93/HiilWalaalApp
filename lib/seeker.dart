import 'dart:convert';
// import 'dart:js';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:hilwalal_app/notices.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shimmer/shimmer.dart';
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

class BloodDonorsPage extends StatefulWidget {
  final List<Map<String, String>> data;

  const BloodDonorsPage({required this.data});

  @override
  _BloodDonorsPageState createState() => _BloodDonorsPageState();
}

class _BloodDonorsPageState extends State<BloodDonorsPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBloodDonorsDataWithDelay();
  }

  String? FullName;
  String? UserID;
  String? Address;
  String? Phone;
  String? Role;
  String? SumOfBloodDonors;

  Future<void> _GetSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FullName = prefs.getString('Name') ?? '';
    Address = prefs.getString('Address') ?? '';
    SumOfBloodDonors = prefs.getString('SumBloodDonors') ?? '';
    Phone = prefs.getString('Phone') ?? '';
    UserID = prefs.getString('ID') ?? '';
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      this.FullName = FullName;
      this.Phone = Phone;
    });
  }

  Future<void> sendSMS(String phoneNumber, String message) async {
    // Replace these values with your API credentials and URL
    final String user = 'TabaarakTest';
    final String password = 'TabaarakTest@@';
    final String apiUrl = 'https://tabaarakict.so/SendSMS.aspx';

    // Encode the message to URL format
    String encodedMessage = Uri.encodeComponent(message);

    // Construct the API URL with the required parameters
    String smsApiUrl =
        '$apiUrl?user=$user&pass=$password&cont=$encodedMessage&rec=$phoneNumber';

    try {
      // Make an HTTP GET request to the API
      var response = await http.get(Uri.parse(smsApiUrl));

      // Check if the request was successful
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "SMS sent successfully.",
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          ),
        );
        print('SMS sent successfully.');
      } else {
        // Handle the error if the request was not successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Failed to send SMS.",
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          ),
        );
        print('Failed to send SMS. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Error sending SMS: $e');
    }
  }

  Future<void> fetchBloodDonorsDataWithDelay() async {
    await Future.delayed(Duration(seconds: 2)); // Add a 2-second delay
    setState(() {
      isLoading = false;
      _GetSessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 213, 212),
      appBar: AppBar(
        title: Text('Blood Donors'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(3, 10, 3, 0),
        child: isLoading ? _buildShimmerEffect() : _buildBloodDonorsList(),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 5, // Show 5 shimmering placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 24,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 12,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 12,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBloodDonorsList() {
    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        final item = widget.data[index];
        final bool isCollapsed = item['isCollapsed'] == 'true';

        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Card(
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          BadgeIcon1(
                            iconData: Icons.bloodtype,
                            iconColor: Colors.red,
                            badgeColor: Colors.blue,
                            badgeText: item['BloodType'] ??
                                '', // Replace with the appropriate blood type (e.g., 'A', 'B', 'AB', 'O', etc.)
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '${item['Address']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (isCollapsed)
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40, // Set the height to reduce button size
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 38, 193, 182),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              icon: Icon(Icons.phone, size: 18),
                              label: Text('Call'),
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
                          child: SizedBox(
                            height: 40, // Set the height to reduce button size
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              icon: Icon(Icons.message, size: 18),
                              label: Text('Message'),
                              onPressed: () {
                                final phoneUri =
                                    Uri(scheme: 'sms', path: item['Phone']!);
                                launchUrl(phoneUri);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 40, // Set the height to reduce button size
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            icon: Icon(Icons.send, size: 18),
                            label: Text('Send sms'),
                            onPressed: () {
                              String recipientPhoneNumber = item['Phone']!;
                              String message =
                                  'Fadlan Walaal Qofkan Dhiigaada ugu deeq si deg deg ah,Magaca: ' +
                                      FullName! +
                                      ', Numberka: ' +
                                      Phone! +
                                      ', Mahadsanid';

                              sendSMS(recipientPhoneNumber, message);

                              // Add functionality to handle favoriting the donor
                            },
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // Toggle the value of 'isCollapsed' when the card is tapped
                            item['isCollapsed'] =
                                isCollapsed ? 'false' : 'true';
                          });
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors
                                .blue, // Replace with the desired background color for the button
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isCollapsed
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: Colors
                                    .white, // Replace with the desired icon color
                              ),
                              SizedBox(width: 8),
                              Text(
                                isCollapsed ? '' : '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BadgeIcon1 extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color badgeColor;
  final String badgeText;

  BadgeIcon1({
    required this.iconData,
    required this.iconColor,
    required this.badgeColor,
    required this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor
                .withOpacity(0.3), // Add some opacity to the icon background
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 35,
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  12), // Adjust the value to change the badge's roundness
              gradient: LinearGradient(
                colors: [
                  badgeColor
                      .withOpacity(0.8), // Add some opacity to the badge color
                  badgeColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              badgeText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
