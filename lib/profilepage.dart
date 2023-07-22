import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   Widget textfield({@required hintText}) {
//     return SingleChildScrollView(
//       child: Material(
//         elevation: 4,
//         shadowColor: Colors.blue,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: TextField(
//           decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 letterSpacing: 2,
//                 color: Colors.black54,
//                 fontWeight: FontWeight.bold,
//               ),
//               fillColor: Colors.white30,
//               filled: true,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide.none)),
//         ),
//       ),
//     );
//   }

//   String? FullName;
//   String? UserID;
//   String? Address;
//   String? Phone;
//   String? Role;
//   String? SumOfBloodDonors;

//   Future<void> _GetSessions() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     FullName = prefs.getString('Name') ?? '';
//     Address = prefs.getString('Address') ?? '';
//     SumOfBloodDonors = prefs.getString('SumBloodDonors') ?? '';
//     Phone = prefs.getString('Phone') ?? '';
//     UserID = prefs.getString('ID') ?? '';
//     //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//     setState(() {
//       this.FullName = FullName;
//     });
//   }

//   Future<void> _RemoveSessions() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//     await prefs.setString('SumBloodDonors', '');
//     await prefs.setString('Name', '');
//     await prefs.setString('Address', '');
//     await prefs.setString('Phone', '');
//     await prefs.setString('ID', '');
//     await prefs.setString('Role', '');
//     //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//   }

//   void initState() {
//     _GetSessions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         // backgroundColor: Colors.white,
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 height: 250,
//                 child: Center(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Edit My Profile',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(150, 40),
//                       primary: Color.fromARGB(255, 255, 0, 0),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           CustomPaint(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//             ),
//             painter: HeaderCurvedContainer(),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Text(
//                   "Profile",
//                   style: TextStyle(
//                     fontSize: 35,
//                     letterSpacing: 1.5,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 width: MediaQuery.of(context).size.width / 2,
//                 height: MediaQuery.of(context).size.width / 2,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 5),
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage('Images/profile.png'),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 // width: MediaQuery.of(context).size.width / 2,
//                 height: MediaQuery.of(context).size.width / 2,

//                 child: Column(
//                   children: [
//                     // Text(
//                     //   UserFullName + ' | ' + Address + ' | ' + Phone,
//                     //   style: TextStyle(
//                     //       // height: 500,
//                     //       color: Color.fromARGB(255, 0, 0, 0),
//                     //       fontSize: 17,
//                     //       // fontStyle: FontStyle.italic,
//                     //       fontWeight: FontWeight.bold),
//                     // ),

//                     SizedBox(
//                       height: 20,
//                     ),
//                     // textfield(
//                     //   hintText: 'haye',
//                     // )
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 10, 15, 0),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.user,
//                                 ),
//                                 SizedBox(
//                                   width: 14,
//                                 ),
//                                 Text(
//                                   FullName ?? '',
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.locationDot,
//                                 ),
//                                 SizedBox(
//                                   width: 14,
//                                 ),
//                                 Text(
//                                   Address ?? '',
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 40,
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Icon(
//                                   FontAwesomeIcons.phone,
//                                 ),
//                                 SizedBox(
//                                   width: 14,
//                                 ),
//                                 Text(
//                                   Phone ?? '',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Color.fromARGB(255, 24, 147, 236);
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [

//             Container(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 48,
//                     backgroundImage: NetworkImage(
//                         'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/1200px-WhatsApp.svg.png'),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'John Doe',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Last seen today at 10:30 AM',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Divider(),
//             ListTile(
//               leading: Icon(Icons.info_outline),
//               title: Text('About'),
//               trailing: Icon(Icons.keyboard_arrow_right),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.chat),
//               title: Text('Chats'),
//               trailing: Icon(Icons.keyboard_arrow_right),
//               onTap: () {},
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Row(
//                 children: [
//                   Icon(Icons.call, color: Colors.grey[600]),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         hintText: 'Calls',
//                         border: InputBorder.none,
//                       ),
//                       onTap: () {
//                         // handle tap event here
//                       },
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.edit, color: Colors.grey[600]),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           String _newText = '';
//                           return AlertDialog(
//                             title: Text('Edit Calls'),
//                             content: TextFormField(
//                               initialValue: 'Calls',
//                               onChanged: (value) {
//                                 _newText = value;
//                               },
//                               decoration: InputDecoration(
//                                 hintText: 'Enter new text',
//                               ),
//                             ),
//                             actions: [
//                               TextButton(
//                                 child: Text('Cancel'),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                               ElevatedButton(
//                                 child: Text('Save'),
//                                 onPressed: () {
//                                   // handle save event here
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.camera_alt),
//               title: Text('Camera'),
//               onTap: () {},
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Settings'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.help_outline),
//               title: Text('Help'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  // ... (existing code)

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage; // Add a variable to store the selected image
  String? FullName;
  String? UserID;
  String? Address;
  String? Phone;
  String? Role;
  String? SumOfBloodDonors;

  TextEditingController Name = TextEditingController();

  TextEditingController tell = TextEditingController();
  TextEditingController Addres = TextEditingController();
  Future<void> _GetSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FullName = prefs.getString('Name') ?? '';
    Address = prefs.getString('Address') ?? '';
    SumOfBloodDonors = prefs.getString('SumBloodDonors') ?? '';
    Phone = prefs.getString('Phone') ?? '';
    UserID = prefs.getString('ID') ?? '';
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      this.UserID = UserID;
    });
    Name.text = FullName ?? '';
    tell.text = Phone ?? '';
    Addres.text = Address ?? '';
  }

  void initState() {
    _GetSessions();
    super.initState();
  }

//
  // ... (existing code)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text('Profile'),
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 40),
              ],
            ),
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              // painter: HeaderCurvedContainer(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 35,
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showImagePickerDialog(); // Function to show the image picker dialog
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 100,
                              backgroundImage: _selectedImage != null
                                  ? Image.file(_selectedImage!).image
                                  : AssetImage(
                                      'Images/profile.png',
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Icon(
                                Icons.camera_alt,
                                color: const Color.fromARGB(255, 8, 8, 8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ... (existing code)
                      // Divider(),
                      SizedBox(
                        height: 40,
                      ),
                      ListTile(
                        leading: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 20), // Add SizedBox with height 10

                              // Add SizedBox with height 10
                              Icon(FontAwesomeIcons.user),
                            ],
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10), // Add SizedBox with height 10
                            Text(
                              'Name',
                              style: GoogleFonts.aBeeZee(fontSize: 12),
                            ),
                            SizedBox(height: 10), // Add SizedBox with height 10
                            Text(
                              FullName ?? '',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25), // Add SizedBox with height 10

                            // Add SizedBox with height 10
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              String _newText;
                              return AlertDialog(
                                title: Text(
                                  'Edit Name',
                                  style: GoogleFonts.aBeeZee(),
                                ),
                                content: Expanded(
                                  child: TextFormField(
                                    controller: Name,
                                    decoration: InputDecoration(
                                      hintText: 'Enter new text',
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.aBeeZee(),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.aBeeZee(),
                                    ),
                                    onPressed: () {
                                      //print(Name.text);
                                      Future<void> Update() async {
                                        String apiUrl = "http://" +
                                            apiLogin +
                                            "/flutterApi/ProfileUpdate.php";

                                        try {
                                          var response = await http
                                              .post(Uri.parse(apiUrl), body: {
                                            'ID': UserID,
                                            'data': Name.text,
                                            'Type': 'Name',
                                          });
                                          if (response.statusCode == 200) {
                                            print('response');
                                            var jsonData =
                                                json.decode(response.body);
                                            // print(jsonData);

                                            if (jsonData["message"] ==
                                                "Updated Success") {
                                              // _Clear();
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              await prefs.setString(
                                                  'Name', Name.text);

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Name Updated successfully.",
                                                    style: GoogleFonts.aBeeZee(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              );
                                              // Clear();
                                              FullName = Name.text;
                                            }
                                          }
                                        } catch (error) {}
                                      }

                                      Update();
                                      // handle save event here
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20), // Add SizedBox with height 10

                            // Add SizedBox with height 10
                            Icon(FontAwesomeIcons.phone),
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10), // Add SizedBox with height 10
                            Text(
                              'Phone',
                              style: GoogleFonts.aBeeZee(fontSize: 12),
                            ),
                            SizedBox(height: 10), // Add SizedBox with height 10
                            Text(
                              Phone ?? '',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25), // Add SizedBox with height 10

                            // Add SizedBox with height 10
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              String _newText = '';
                              return AlertDialog(
                                title: Text(
                                  'Edit Calls',
                                  style: GoogleFonts.aBeeZee(),
                                ),
                                content: TextFormField(
                                  controller: tell,
                                  decoration: InputDecoration(
                                    hintText: 'Enter new text',
                                  ),
                                  keyboardType: TextInputType
                                      .number, // Only allows numeric input
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                    // Restrict input to digits only
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.aBeeZee(),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.aBeeZee(),
                                    ),
                                    onPressed: () {
                                      Future<void> Update() async {
                                        String apiUrl = "http://" +
                                            apiLogin +
                                            "/flutterApi/ProfileUpdate.php";

                                        try {
                                          var response = await http
                                              .post(Uri.parse(apiUrl), body: {
                                            'ID': UserID,
                                            'data': tell.text,
                                            'Type': 'Phone',
                                          });
                                          if (response.statusCode == 200) {
                                            print('response');
                                            var jsonData =
                                                json.decode(response.body);
                                            // print(jsonData);

                                            if (jsonData["message"] ==
                                                "Updated Success") {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              await prefs.setString(
                                                  'Phone', tell.text);
                                              // _Clear();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Phone Updated successfully.",
                                                    style: GoogleFonts.aBeeZee(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              );
                                              // Clear();
                                              Phone = tell.text;
                                            }
                                          }
                                        } catch (error) {}
                                      }

                                      Update();
                                      // handle save event here
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20), // Add SizedBox with height 10

                            // Add SizedBox with height 10
                            Icon(FontAwesomeIcons.locationDot),
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10), // Add SizedBox with height 10
                            Text(
                              'Address',
                              style: GoogleFonts.aBeeZee(fontSize: 12),
                            ),
                            SizedBox(height: 10), // Add SizedBox with height 10
                            Text(
                              Address ?? '',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25), // Add SizedBox with height 10

                            // Add SizedBox with height 10
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              String _newText = '';
                              return AlertDialog(
                                title: Text(
                                  'Edit Address',
                                  style: GoogleFonts.aBeeZee(),
                                ),
                                content: TextFormField(
                                  controller: Addres,
                                  decoration: InputDecoration(
                                    hintText: 'Enter new text',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.aBeeZee(),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.aBeeZee(),
                                    ),
                                    onPressed: () {
                                      Future<void> Update() async {
                                        String apiUrl = "http://" +
                                            apiLogin +
                                            "/flutterApi/ProfileUpdate.php";
                                        try {
                                          var response = await http
                                              .post(Uri.parse(apiUrl), body: {
                                            'ID': UserID,
                                            'data': Addres.text,
                                            'Type': 'Address',
                                          });
                                          if (response.statusCode == 200) {
                                            print('response');
                                            var jsonData =
                                                json.decode(response.body);
                                            // print(jsonData);

                                            if (jsonData["message"] ==
                                                "Updated Success") {
                                              // _Clear();
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              await prefs.setString(
                                                  'Address', Addres.text);

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Address Updated successfully.",
                                                    style: GoogleFonts.aBeeZee(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              );
                                              // Clear();
                                              Address = Addres.text;
                                            } else if (jsonData["message"] ==
                                                "Password is Incorrect") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Password is Incorrect."),
                                                ),
                                              );
                                            }
                                          }
                                        } catch (error) {}
                                      }

                                      Update();
                                      // handle save event here
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(Icons.help_sharp),
                        title: Text(
                          'Help',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () async {
                          final whatsappUrl = "https://wa.me/252619346686";
                          // ignore: deprecated_member_use
                          try {
                            await launch(whatsappUrl);
                          } catch (e) {}
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Function to show the image picker dialog
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose a profile picture'),
          actions: [
            TextButton(
              onPressed: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: Text('From Gallery'),
            ),
            TextButton(
              onPressed: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: Text('Take a Photo'),
            ),
          ],
        );
      },
    );
  }

  // Function to pick an image from gallery or camera
  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  // ... (existing code)
}
