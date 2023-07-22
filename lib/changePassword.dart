import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? Password;
  String? UserID;

  Future<void> _GetSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Password = prefs.getString('Password') ?? '';
    UserID = prefs.getString('ID') ?? '';
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      this.Password = Password;
      this.UserID = UserID;
    });
  }

  void initState() {
    _GetSessions();
    super.initState();
  }

  void _Clear() {
    _newPasswordController.clear();
    _oldPasswordController.clear();
    _confirmPasswordController.clear();
  }

  Future<void> ChangePassword() async {
    String apiUrl = "http://" + apiLogin + "/flutterApi/ChangePassword.php";

    try {
      var response = await http.post(Uri.parse(apiUrl), body: {
        'ID': UserID,
        'OldPassword': _oldPasswordController.text,
        'NewPassword': _newPasswordController.text,
      });
      if (response.statusCode == 200) {
        print('response');
        var jsonData = json.decode(response.body);
        // print(jsonData);

        if (jsonData["message"] == "Updated Success") {
          _Clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password changed successfully."),
            ),
          );
          // Clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_reset),
                  labelText: "Old Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your old password.";
                  }
                  if (value != Password) {
                    return "Incorrect Password.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                    labelText: "New Password",
                    prefixIcon: Icon(Icons.lock_open)),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your new password.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_open),
                  labelText: "Confirm Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your new password.";
                  }
                  if (value != _newPasswordController.text) {
                    return "Passwords do not match.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Implement password change functionality here
                    ChangePassword();
                  }
                },
                child: Text("Change Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
