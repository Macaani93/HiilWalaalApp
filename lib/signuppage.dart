import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;

import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => Dashboard()),
          // );
          // print('Inserted');
          // clean();
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => Dashboard()),
          // );
          // print('Inserted');
          // clean();
        }
      }
      //   if (jsonData["error"]) {
      //     // Handle error case
      //     log("Login error");
      //   } else {}
      // } else {
      //   print('Error');
      //   log("HTTP request failed with status code: ${response.statusCode}");
      // }
    } catch (error) {
      // log("Error: $error");
    }
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
                TextField(
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
                ),
                SizedBox(height: 15),
                TextField(
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
                ),
                SizedBox(height: 15),
                TextField(
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
                  keyboardType:
                      TextInputType.number, // Only allows numeric input
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly // Restrict input to digits only
                  ],
                ),
                SizedBox(height: 15),
                TextField(
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
                ),
                SizedBox(height: 15),
                TextField(
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
                ),
                SizedBox(height: 15),
                TextField(
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
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    //print('999999999999');
                    // Access the text values using the controllers
                    startSignUp();
                    // Do something with the text values
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
    );
  }
}
