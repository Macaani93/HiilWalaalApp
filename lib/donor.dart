// import 'dart:convert';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:hilwalal_app/Api/Sessions.dart';
// import 'package:hilwalal_app/Api/api.dart';
// import 'package:http/http.dart' as http;

// import 'loginpage.dart';

// class DonorForm extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController _name = TextEditingController();
//   TextEditingController _phone = TextEditingController();
//   TextEditingController _address = TextEditingController();
//   TextEditingController _birthDate = TextEditingController();
//   String _regDate = "";
//   String _userID = GetUser();
//   String? _bloodType;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HIILLWALAL APPLICATION'),
//         centerTitle: true,
//         actions: [
//           // IconButton(
//           //   icon: Icon(Icons.settings),
//           //   onPressed: () {
//           //     // Do something when the button is pressed
//           //   },
//           // ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.bloodtype,
//               size: 30.30,
//               color: Colors.red,
//             ),
//             Text(
//               'Blood Donor',
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Color.fromARGB(255, 43, 3, 186),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 30),
//             TextField(
//               controller: _name,
//               decoration: InputDecoration(
//                 hintText: 'FullName',
//                 // border: OutlineInputBorder(),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(60.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             TextField(
//               controller: _phone,
//               decoration: InputDecoration(
//                 hintText: 'Phone',
//                 // border: OutlineInputBorder(),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(60.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               controller: _address,
//               //obscureText: true,
//               decoration: InputDecoration(
//                 hintText: 'Address',
//                 // border: OutlineInputBorder(),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(60.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               controller: _birthDate,
//               //obscureText: true,
//               decoration: InputDecoration(
//                 hintText: 'Age',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(60.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               //obscureText: true,
//               decoration: InputDecoration(
//                 hintText: 'RegDate',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(60.0),
//                 ),
//               ),
//               onChanged: (value) => _regDate = value,
//             ),
//             SizedBox(height: 15),
//             SizedBox(height: 16.0),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 labelText: "Blood Type",
//                 // border: OutlineInputBorder(),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(60.0),
//                 ),
//               ),
//               items: [
//                 DropdownMenuItem(
//                   value: "1",
//                   child: Text("A+"),
//                 ),
//                 DropdownMenuItem(
//                   value: "5",
//                   child: Text("AB+"),
//                 ),
//                 DropdownMenuItem(
//                   value: "3",
//                   child: Text("B+"),
//                 ),
//                 DropdownMenuItem(
//                   value: "7",
//                   child: Text("O+"),
//                 ),
//                 DropdownMenuItem(
//                   value: "2",
//                   child: Text("A-"),
//                 ),
//                 DropdownMenuItem(
//                   value: "6",
//                   child: Text("AB-"),
//                 ),
//                 DropdownMenuItem(
//                   value: "4",
//                   child: Text("B-"),
//                 ),
//                 DropdownMenuItem(
//                   value: "8",
//                   child: Text("O-"),
//                 ),

//                 // Add other DropdownMenuItem items for different blood types
//               ],
//               value: _bloodType, // Set the current selected value
//               onChanged: (value) {
//                 _bloodType = value;
//               },
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 // if (_formKey.currentState!.validate()) {
//                 // print('now');
//                 Future<void> InsertDonor() async {
//                   // print('I am In');
//                   String apiUrl =
//                       "http://" + apiLogin + "/flutterApi/blood_donation.php";
//                   try {
//                     var response = await http.post(Uri.parse(apiUrl), body: {
//                       'name': _name,
//                       'Phone': _phone,
//                       'Address': _address,
//                       'Age': _birthDate,
//                       'BloodType': _bloodType,
//                       'UserID': _userID,
//                     });
//                     print(response);
//                     if (response.statusCode == 200) {
//                       var jsonData = json.decode(response.body);
//                       // print(jsonData);

//                       if (jsonData["message"] == "Inserted Success") {
//                         //======> =============>  ============> print('Inserted');
//                         AwesomeDialog(
//                           context: context,
//                           dialogType: DialogType.SUCCES,
//                           animType: AnimType.RIGHSLIDE,
//                           title: 'Donor Registeration',
//                           desc: 'Your Have Been Successfully Saved',
//                           // btnCancelOnPress: () {},
//                           btnOkOnPress: () {},
//                         ).show();
//                       }
//                     }
//                   } catch (error) {
//                     // log("Error: $error");
//                     print('error');
//                   }
//                 }

//                 InsertDonor();
//               },
//               //},
//               child: Text('Register Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;

class DonorForm extends StatelessWidget {
  DonorForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _phone = "";
  String _address = "";
  String _birthDate = "";
  String _regDate = "";
  String _userID = GetUser();
  String? _bloodType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hiil-Walal",
          style: TextStyle(fontSize: 24.0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.bloodtype,
                  size: 80.80,
                  color: Colors.red,
                ),
                SizedBox(height: 10.0),
                Text(
                  'BLOOD DONOR',
                  style: TextStyle(fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _phone = value;
                  },
                  keyboardType:
                      TextInputType.number, // Only allows numeric input
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly // Restrict input to digits only
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _address = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _birthDate = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid numeric age';
                    }
                    return null;
                  },
                  keyboardType:
                      TextInputType.number, // Only allows numeric input
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly // Restrict input to digits only
                  ],
                ),
                SizedBox(height: 16.0),
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

                    // Add other DropdownMenuItem items for different blood types
                  ],
                  value: _bloodType, // Set the current selected value
                  onChanged: (value) {
                    _bloodType = value;
                  },
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 90,
                    right: 90,
                  ),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: ElevatedButton(
                      onPressed: () async {
                        // print('now');
                        Future<void> InsertDonor() async {
                          String apiUrl = "http://" +
                              apiLogin +
                              "/flutterApi/blood_donation.php";
                          try {
                            var response =
                                await http.post(Uri.parse(apiUrl), body: {
                              'name': _name,
                              'Phone': _phone,
                              'Address': _address,
                              'Age': _birthDate,
                              'BloodType': _bloodType,
                              'UserID': _userID,
                            });

                            if (response.statusCode == 200) {
                              var jsonData = json.decode(response.body);
                              print(jsonData);

                              if (jsonData["message"] == "Inserted Success") {
                                // print('Inserted');
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.RIGHSLIDE,
                                  title: 'Donor Registeration',
                                  desc: 'Your Have Been Successfully Saved',
                                  // btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                ).show();
                              } else if (jsonData['Status'] ==
                                  "Already Registered") {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.WARNING,
                                  animType: AnimType.RIGHSLIDE,
                                  title: 'Donor Regisration',
                                  desc: 'Your Have Been Already Registered!',
                                  // btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                ).show();
                              }
                            }
                          } catch (error) {
                            // log("Error: $error");
                            print('error');
                          }
                        }

                        InsertDonor();
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
