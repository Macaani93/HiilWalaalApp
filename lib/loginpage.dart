import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:hilwalal_app/signuppage.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  Color errorColor = Colors.red.shade100;
  String errorMessage = '';
  bool hasUserNameEntered = false;
  bool hasPasswordEntered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiil-Walal '),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   Icons.person,
                //   size: 100.80,
                //   color: Colors.green,
                // ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 35,
                    color: Color.fromARGB(255, 3, 106, 189),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Login with your Account',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 3, 106, 189),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                if (errorMessage != '')
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: errorMessage.isNotEmpty
                          ? errorColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: errorMessage.isNotEmpty
                            ? Colors.red
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: errorMessage.isNotEmpty
                              ? Colors.red
                              : Colors.transparent,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: errorMessage.isNotEmpty
                                  ? Colors.red
                                  : Colors.transparent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: userName,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: hasUserNameEntered
                        ? FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                            size: 24,
                          )
                        : FaIcon(
                            FontAwesomeIcons.exclamationTriangle,
                            color: Colors.red,
                            size: 24,
                          ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      hasUserNameEntered = value.isNotEmpty;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                  width: 60,
                ),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: hasPasswordEntered
                        ? FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                            size: 24,
                          )
                        : FaIcon(
                            FontAwesomeIcons.exclamationTriangle,
                            color: Colors.red,
                            size: 24,
                          ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      hasPasswordEntered = value.isNotEmpty;
                    });
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Future<void> startLogin() async {
                      String apiUrl =
                          "http://" + apiLogin + "/flutterApi/Login.php";

                      try {
                        var response =
                            await http.post(Uri.parse(apiUrl), body: {
                          'username': userName.text,
                          'password': password.text,
                        });

                        if (response.statusCode == 200) {
                          var jsonData = json.decode(response.body);
                          var sessionManager = SessionManager();
                          sessionManager.set("data", jsonData);

                          if (jsonData["message"] == "Login successful") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()),
                            );
                            SetSumOFBloodDOnor(jsonData['SumBloodDonors']);
                            SetFullName(jsonData['Role']['Name']);
                            SetAddress(jsonData['Role']['Address']);
                            SetPhone(jsonData['Role']['Phone']);
                            SetUser(jsonData['Role']['ID']);
                            setRole(jsonData['Role']['Role']);
                          } else {
                            setState(() {
                              errorMessage = jsonData["message"];
                              hasUserNameEntered = false;
                              hasPasswordEntered = false;
                            });
                          }
                        } else {
                          setState(() {
                            errorMessage = "Error";

                            //response.reasonPhrase;
                          });
                        }
                      } catch (e) {
                        setState(() {
                          errorMessage = "Error: " + e.toString();
                          hasUserNameEntered = false;
                          hasPasswordEntered = false;
                        });
                      }
                    }

                    if (userName.text.isEmpty || password.text.isEmpty) {
                      setState(() {
                        errorMessage =
                            "Please enter your username and password";
                        hasUserNameEntered = false;
                        hasPasswordEntered = false;
                      });
                    } else {
                      startLogin();
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    primary: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
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
