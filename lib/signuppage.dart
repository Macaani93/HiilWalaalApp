import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;

import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

final _formKey = GlobalKey<FormState>();

class _SignupPageState extends State<SignupPage> {
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> startSignUp() async {
    String apiUrl = "http://" + apiLogin + "/flutterApi/SignUp.php";

    try {
      //  print('000000000000000000000000000');
      var response = await http.post(Uri.parse(apiUrl), body: {
        'username': usernameController.text,
        'fullname': fullNameController.text,
        'password': passwordController.text,
        'address': addressController.text,
        'phone': phoneController.text,
      });
      if (response.statusCode == 200) {
        print('response');
        var jsonData = json.decode(response.body);
        print(jsonData);

        if (jsonData["message"] == "Inserted Success") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'Warbixin',
            desc: 'Inserted Success',
            // btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
          Clear();
        } else if (jsonData["message"] == "User already exists") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Warbixin',
            desc: 'User already exists',
            // btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      }
    } catch (error) {}
  }

  @override
  void dispose() {
    fullNameController.dispose();
    addressController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void Clear() {
    fullNameController.clear();
    addressController.clear();
    phoneController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SIGN-UP',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 43, 3, 186),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color(0xFFE5E5E5),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      prefixIcon: Icon(Icons.home),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFE5E5E5),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Address';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFE5E5E5),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone';
                      }
                      return null; // Return null if the input is valid
                    },
                    keyboardType:
                        TextInputType.number, // Only allows numeric input
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly // Restrict input to digits only
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFE5E5E5),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your UserName';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFE5E5E5),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFE5E5E5),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Confirm Password';
                      }
                      if (value != passwordController.text) {
                        return "Passwords do not match.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, now check if passwords match
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          // Passwords match, proceed with signup
                          startSignUp();
                        } else {
                          // Passwords do not match, show an error
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.RIGHSLIDE,
                            title: 'Error',
                            desc: 'Password and Confirm Password do not match',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                    },
                    child: Text('Signup'),
                  ),
                  SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Already have an account? Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
