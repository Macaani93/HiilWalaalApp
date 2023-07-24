import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  String errorMessage = '';
  bool isLoading = false;
  bool _isLoadingAvatar = true;
  // bool _isLoadingSocialIcons = true;
  void _Clear() {
    _confirmController.clear();
    _passwordController.clear();
    _usernameController.clear();
  }

  Future<void> ResetPassword(String UserID) async {
    String apiUrl = "http://" + apiLogin + "/flutterApi/resetPassword.php";

    try {
      var response = await http.post(Uri.parse(apiUrl), body: {
        'ID': UserID,
        'NewPassword': _confirmController.text,
      });
      if (response.statusCode == 200) {
        print('response');
        var jsonData = json.decode(response.body);
        // print(jsonData);

        if (jsonData["message"] == "Updated Success") {
          _Clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text("Password changed successfully."),
            ),
          );
        } else if (jsonData["message"] == "Password is Incorrect") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password is Incorrect."),
            ),
          );
        }
      }
    } catch (error) {}
  }

  void _checkUsername() async {
    setState(() {
      isLoading = true;
    });

    String username = _usernameController.text;

    // Make the API call to check the username
    final apiUrl = 'http://' + apiLogin + '/flutterApi/GetUserName.php';
    final response =
        await http.post(Uri.parse(apiUrl), body: {'username': username});

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final Map<String, dynamic> data = json.decode(response.body);
      // print(data);
      // Check if the response contains 'id', which means the username exists
      if (data.containsKey('id')) {
        errorMessage = '';
        // Username exists, show the password reset dialog
        showPasswordResetDialog(data['id']);
      } else {
        // Username does not exist
        setState(() {
          errorMessage = 'Sorry, we can`t get your UserName';
        });
      }
    } else {
      // If the server did not return a 200 OK response, handle the error
      setState(() {
        errorMessage = 'Failed to check username';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void showPasswordResetDialog(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'New Password', prefixIcon: Icon(Icons.lock)),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _confirmController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Perform password reset here
                if (_confirmController.text == _passwordController.text) {
                  // Passwords match, you can update the password in the database here
                  // Remember to handle the password update on the server-side securely.
                  // ...
                  print(userId);
                  ResetPassword(userId);
                  Navigator.pop(context); // Close the dialog
                } else {
                  // Passwords do not match, show an error or handle as required
                  // ...
                }
              },
              child: Text('Reset'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // void _checkUsername() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   setState(() {
  //     isLoading = false;
  //     errorMessage =
  //         'Sorry, we could not find an account associated with that username.';
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // Simulate an asynchronous data loading delay for the avatar
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoadingAvatar = false;
        // _isLoadingSocialIcons = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.to,
            children: [
              _buildShimmeringCircleAvatar(),
              SizedBox(height: 30),
              Text(
                'Change Password',
                style: GoogleFonts.aBeeZee(fontSize: 20),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Username',
                    labelStyle: GoogleFonts.aBeeZee()),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _checkUsername();
                },
                child: Text(
                  'Check',
                  style: GoogleFonts.aBeeZee(),
                ),
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmeringCircleAvatar() {
    return Visibility(
      visible: _isLoadingAvatar,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.white,
          child: Container(
            color: Colors.white,
          ),
        ),
      ),
      replacement: CircleAvatar(
        radius: 100,
        backgroundImage: AssetImage(
          'Images/logo-white.jpg',
        ),
      ),
    );
  }
}
