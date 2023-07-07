import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/ChariyahDash.dart';
import 'package:hilwalal_app/blood.dart';
import 'package:hilwalal_app/homepage.dart';
import 'package:hilwalal_app/loginpage.dart';
import 'package:hilwalal_app/main.dart';
import 'package:hilwalal_app/profilepage.dart';

import 'charity.dart';

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  Widget _currentPage = MyHomePage();

  void _navigateToPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIILWALAL Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hiil-Walal'),
          centerTitle: true,
          // leading: ,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  SetFullName('');
                  SetAddress('');
                  SetUser(0);
                  setRole('');
                  print(GetFullName());
                },
                icon: Icon(Icons.logout_sharp))
          ],
        ),
        body: _currentPage,
        bottomNavigationBar: Visibility(
          visible: !(_currentPage is DashboardPage),
          child: ConvexAppBar.badge(
            const <int, dynamic>{3: ''},
            style: TabStyle.reactCircle,
            items: <TabItem>[
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.bloodtype, title: 'Blood'),
              TabItem(icon: Icons.attach_money, title: 'Charity'),
              TabItem(icon: Icons.list_alt_sharp, title: 'Lists'),
              TabItem(icon: Icons.person, title: 'Profile'),
            ],
            onTap: (int i) {
              if (i == 1) {
                _navigateToPage(blood());
              } else if (i == 2) {
                _navigateToPage(ChariyahDash());
              } else if (i == 4) {
                _navigateToPage(ProfilePage());
              } else if (i == 0) {
                _navigateToPage(MyHomePage());
              }
            },
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: DashboardForm(),
    );
  }
}

class DashboardForm extends StatelessWidget {
  const DashboardForm({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Column(
        children: [
          const Divider(),
          Expanded(
            child: TabBarView(
              children: [
                for (final icon in _kPages.values) Icon(icon, size: 64),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _kPages = <String, IconData>{
    'Home': Icons.home,
    'Blood': Icons.bloodtype,
    'Charity': Icons.attach_money,
    'Lists': Icons.list_alt_sharp,
    'Profile': Icons.person,
  };
}
