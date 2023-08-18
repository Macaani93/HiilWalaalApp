import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    String? base64Image = prefs.getString('Image');
    // print('')
    if (base64Image != null && base64Image.isNotEmpty) {
      List<int> imageBytes = base64Decode(base64Image);
      setState(() {
        _selectedImage = File.fromRawPath(Uint8List.fromList(imageBytes));
      });
    }
    print(_selectedImage);
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
                      SizedBox(
                        height: 50,
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
                                  : AssetImage('Images/profile.png'),
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
                                        // String apiUrl = "http://" +
                                        //     apiLogin +
                                        //     "/flutterApi/ProfileUpdate.php";
                                        String apiUrl =
                                            apiDomain + "ProfileUpdate.php";

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
                                        String apiUrl =
                                            apiDomain + "ProfileUpdate.php";
                                        // String apiUrl = "http://" +
                                        //     apiLogin +
                                        //     "/flutterApi/ProfileUpdate.php";

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
                                        // String apiUrl = "http://" +
                                        //     apiLogin +
                                        //     "/flutterApi/ProfileUpdate.php";
                                        String apiUrl =
                                            apiDomain + "ProfileUpdate.php";
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
      final File imageFile = File(pickedFile.path);
      setState(() {
        _selectedImage = imageFile;
      });

      // Send the image file to the API
      await _sendImageToAPI(imageFile);
    }
  }

  Future<void> _sendImageToAPI(File imageFile) async {
    try {
      // Read the image file as bytes
      List<int> imageBytes = await imageFile.readAsBytes();

      // Encode the bytes as base64
      String base64Image = base64Encode(imageBytes);

      // Create the API request body
      Map<String, dynamic> requestBody = {
        'image': base64Image,
        'UserID': UserID
      };

      // Send the API request
      final response = await http.post(
        // Uri.parse('http://' + apiLogin + '/flutterApi/ImageSave.php'),
        Uri.parse(apiDomain + 'ImageSave.php'),
        body: requestBody,
      );

      // Check the response status
      var jsonData = json.decode(response.body);
      // print(jsonData);

      if (jsonData["message"] == "Updated Success") {
        // _Clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Image changed successfully."),
          ),
        );
        // Clear();
      } else if (jsonData["message"] == "Password is Incorrect") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Image is Incorrect."),
          ),
        );
      }
    } catch (e) {
      // Handle error case
      print('Error uploading image: $e');
    }
  }
}
