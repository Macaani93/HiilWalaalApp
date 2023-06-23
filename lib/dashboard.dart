import 'package:flutter/material.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:hilwalal_app/ChariyahDash.dart';
import 'package:hilwalal_app/blood.dart';

import 'charity.dart';

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  Widget _currentPage = HomePage();

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
          title: Text('HIILLWALAL APPLICATION'),
          centerTitle: true,
          actions: [],
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
              }
            },
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Go to Dashboard'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        },
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
