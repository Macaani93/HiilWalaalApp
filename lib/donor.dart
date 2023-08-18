import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonorForm extends StatefulWidget {
  const DonorForm({Key? key}) : super(key: key);

  @override
  State<DonorForm> createState() => _DonorFormState();
}

final _formKey = GlobalKey<FormState>();

String _name = "";
String _phone = "";
String _birthDate = "";
// String _userID = GetUser();
String? _bloodType;
TextEditingController _birthdate = TextEditingController();
TextEditingController _nameController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
TextEditingController _birthDateController = TextEditingController();
TextEditingController _userIDController = TextEditingController();
TextEditingController _bloodTypeController = TextEditingController();
String? _region;
String region = _region ?? '1';
TextEditingController reg = TextEditingController();
// reg.text=region;
String? _district;
String? FullName;
String? UserID;
String? Address;
String? Phone;
String? Role;
String? SumOfBloodDonors;
bool isLoading = false;
Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2005),
    firstDate: DateTime(1950),
    lastDate: DateTime(2005),
  );
  if (picked != null) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(picked);
    _birthdate.text = formattedDate;
  }
}

Future<List<Map<String, dynamic>>> _fetchRegions() async {
  final response = await http.get(
    // Uri.parse('http://' + apiLogin + '/flutterApi/GetRegions.php'),
    Uri.parse(apiDomain + 'GetRegions.php'),
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    List<Map<String, dynamic>> regions = List<Map<String, dynamic>>.from(
        jsonData.map((region) => region as Map<String, dynamic>));
    return regions;
  } else {
    throw Exception('Failed to load regions');
  }
}

Stream<List<Map<String, dynamic>>> _fetchDistrictsByRegionId(String? regionId) {
  if (regionId == null) {
    return Stream.value([]);
  } else {
    return Stream.fromFuture(
      http.post(
        // Uri.parse('http://' + apiLogin + '/flutterApi/GetDistricts.php'),
        Uri.parse(apiDomain + 'GetDistricts.php'),
        body: {'region_id': regionId},
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          if (jsonData is List) {
            return List<Map<String, dynamic>>.from(
              jsonData
                  .map((district) => district as Map<String, dynamic>)
                  .toList(),
            );
          } else {
            throw Exception('Invalid response format');
          }
        } else {
          throw Exception('Failed to load districts');
        }
      }),
    );
  }
}

void _resetFormFields() {
  _nameController.clear();
  _phoneController.clear();
  _birthdate.clear(); // For the birth date text field
  _region = null;
  _district = null;
  _bloodType = null;
}

class _DonorFormState extends State<DonorForm> {
  // List<Map<String, dynamic>>? _districts;

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
      this.UserID = UserID;
    });
  }

  void initState() {
    _GetSessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to discard the changes and go back?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      {Navigator.of(context).pop(true), _resetFormFields()},
                  child: Text('Discard'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hiil-Walal",
            style: GoogleFonts.aBeeZee(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
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
                    style: GoogleFonts.aBeeZee(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Name",
                      labelStyle: GoogleFonts.aBeeZee(),
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
                    controller: _phoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Phone",
                      labelStyle: GoogleFonts.aBeeZee(),
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
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          10), // Limits input to 8 digits
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      labelText: 'BirthDate',
                      labelStyle: GoogleFonts.aBeeZee(),
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    controller: _birthdate,
                    onTap: () {
                      _selectDate(context);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    keyboardType:
                        TextInputType.number, // Only allows numeric input
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    children: [
                      Column(
                        children: [
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: _fetchRegions(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return DropdownButtonFormField<String>(
                                  items: [
                                    DropdownMenuItem(
                                      value: '0',
                                      child: Text("Loading..."),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _region = value;
                                    });
                                  },
                                );
                              }

                              final regions = snapshot.data!;
                              return DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.location_city),
                                  labelText: "Region",
                                  border: OutlineInputBorder(),
                                ),
                                items: regions
                                    .map<DropdownMenuItem<String>>((region) {
                                  return DropdownMenuItem<String>(
                                    value: region["id"],
                                    child: Text(region["name"]),
                                  );
                                }).toList(),
                                value: _region,
                                onChanged: (value) {
                                  setState(() {
                                    _region = value;
                                    _district =
                                        null; // Reset districts when region changes
                                    _fetchDistrictsByRegionId(_region!);
                                  });
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<List<Map<String, dynamic>>>(
                            stream: _region == null
                                ? Stream.value([])
                                : _fetchDistrictsByRegionId(_region!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final districtData = snapshot.data!;
                                final List<DropdownMenuItem<String>>
                                    dropdownItems = districtData
                                        .map<DropdownMenuItem<String>>(
                                          (district) =>
                                              DropdownMenuItem<String>(
                                            value: district["id"].toString(),
                                            child: Text(district["name"]),
                                          ),
                                        )
                                        .toList();

                                return DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.location_city),
                                    labelText: "District",
                                    border: OutlineInputBorder(),
                                  ),
                                  items: dropdownItems,
                                  value: _district,
                                  onChanged: (value) {
                                    setState(() {
                                      _district = value;
                                    });
                                  },
                                );
                              } else if (!snapshot.hasData) {
                                return DropdownButtonFormField<String>(
                                  items: [
                                    DropdownMenuItem(
                                      value: '0',
                                      child: Text("Loading..."),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _district = value;
                                    });
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                      // SizedBox(height: 16.0),
                    ],
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.bloodtype),
                      labelText: "Blood Type",
                      labelStyle: GoogleFonts.aBeeZee(),
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
                      setState(() {
                        _bloodType = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 90,
                      right: 90,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await insertDonor();
                          // _resetFormFields();
                          // Handle button press
                        },
                        child: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
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
      ),
    );
  }

  Future<void> insertDonor() async {
    setState(() {
      isLoading = true; // Set loading state to true
    });

    // String apiUrl = "http://" + apiLogin + "/flutterApi/blood_donation.php";
    String apiUrl = apiDomain + "blood_donation.php";
    try {
      var response = await http.post(Uri.parse(apiUrl), body: {
        'name': _name,
        'Phone': _phone,
        'Region': _region,
        'District': _district,
        'Age': _birthdate.text,
        'BloodType': _bloodType,
        'UserID': UserID,
      });

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print(jsonData);
        // print(object)
        if (jsonData["message"] == "Inserted Success") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'Donor Registration',
            desc: 'You have been successfully saved',
            btnOkOnPress: () {
              _resetFormFields();
            },
          ).show();
        } else if (jsonData['Status'] == "Already Registered") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.RIGHSLIDE,
            title: 'Donor Registration',
            desc: 'You have already registered!',
            btnOkOnPress: () {},
          ).show();
        }
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false; // Set loading state to false
      });
    }
  }
}
