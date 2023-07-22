import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Dashboard2.dart';
import 'package:hilwalal_app/dashboard.dart';

import 'package:hilwalal_app/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hiil Walaal',
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoggedIn = false;
  String Page = '';
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String PageNow = prefs.getString('Role') ?? '';

    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.Page = PageNow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Expanded(
            flex: 2,
            child: Image.asset(
              'Images/logo-white.jpg',
              fit: BoxFit.contain,
              width: 400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: Text('Hiil-Walaal Official App',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
      splashIconSize: 600,
      nextScreen: isLoggedIn
          ? Page == 'Hospital'
              ? Dashboard2()
              : Dashboard()
          : LoginPage(), // Navigate to appropriate screen
      backgroundColor: Colors.white,
    );
  }
}
