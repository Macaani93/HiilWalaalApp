// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const sidebar(title: 'Dashboard '),
//     );
//   }
// }

// class sidebar extends StatefulWidget {
//   const sidebar({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   State<sidebar> createState() => _sidebarState();
// }

// class _sidebarState extends State<sidebar> {
//   List<Menu> data = [];

//   @override
//   void initState() {
//     for (var element in dataList) {
//       data.add(Menu.fromJson(element));
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         drawer: Drawer(
//           child: _buildDrawer(),
//         ),
//         body: const Center(
//             // child: Text(
//             //   "Welcome to HIIL WALAAL",
//             //   style: TextStyle(fontSize: 30),
//             // ),
//             ));
//   }

