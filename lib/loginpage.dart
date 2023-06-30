import 'dart:convert';
import 'dart:math';
// import 'package:dart_ipify/dart_ipify.dart';
// import 'package:hilwalal_app/Api/api.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:hilwalal_app/signuppage.dart';
// import 'package:network_info_plus/network_info_plus.dart';
import 'dashboard.dart';

class LoginPage extends StatelessWidget {
  // final info = NetworkInfo();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiil-Walal '),
        automaticallyImplyLeading: false,
        centerTitle: true,
        //actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 100.80,
              color: Colors.green,
            ),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 3, 106, 189),
                fontWeight: FontWeight.bold,
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
                // border: OutlineInputBorder(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
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
                // border: OutlineInputBorder(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Future<void> startLogin() async {
                  String apiUrl =
                      "http://" + apiLogin + "/flutterApi/Login.php";

                  try {
                    // setState(() {
                    //   isLoading = true;
                    // });

                    var response = await http.post(Uri.parse(apiUrl), body: {
                      'username': userName.text,
                      'password': password.text,
                    });

                    if (response.statusCode == 200) {
                      var jsonData = json.decode(response.body);
                      var sessionManager = SessionManager();
                      sessionManager.set("data", jsonData);
                      // await sessionManager.set("id", 3);
                      // await sessionManager.set("measure", 23.2);
                      // await sessionManager.set("isLoggedIn", true);
                      // Provider.of<AppData>(context, listen: false).setRole(jsonData['Role']);
                      //app.setRole(jsonData['Role']);
                      if (jsonData["message"] == "Login successful") {
                        // Store the role in the session variable
                        //setRoleInSession(jsonData['Role']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                        // print(jsonData['Role']);
                        SetSumOFBloodDOnor(jsonData['SumBloodDonors']);
                        // print(jsonData['SumBloodDonors']);
                        SetFullName(jsonData['Role']['Name']);
                        SetAddress(jsonData['Role']['Address']);
                        SetPhone(jsonData['Role']['Phone']);
                        SetUser(jsonData['Role']['ID']);
                        setRole(jsonData['Role']['Role']);
                        //print(GetUser());
                        // clean();
                      } else {
                        Widget okButton = TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Username or password is incorrect"),
                          actions: [okButton],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    }
                  } catch (error) {
                    //log("Error: $error");
                  } finally {
                    //setState(() {
                    //isLoading = false;
                    //ali });
                  }
                }

                startLogin();
              },
              child: Text('Login'),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text('SignUp'),
            ),
          ],
        ),
      ),
    );
  }
}
