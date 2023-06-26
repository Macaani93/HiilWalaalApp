import 'package:flutter/material.dart';

import 'package:hilwalal_app/loginpage.dart';
import 'package:hilwalal_app/seeker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hiil Walaal',
      home: LoginPage(),
    );
  }
}
