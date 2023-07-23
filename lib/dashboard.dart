import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/About.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/ChariyahDash.dart';
import 'package:hilwalal_app/ContactUs.dart';
import 'package:hilwalal_app/blood.dart';
import 'package:hilwalal_app/changePassword.dart';
import 'package:hilwalal_app/donor.dart';
import 'package:hilwalal_app/homepage.dart';
import 'package:hilwalal_app/loginpage.dart';
import 'package:hilwalal_app/notices.dart';

import 'package:hilwalal_app/profilepage.dart';
import 'package:hilwalal_app/seeker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String? FullName;
  String? UserID;
  String? Address;
  String? Phone;
  String? Role;
  String? SumOfBloodDonors;

  Future<void> _GetSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FullName = prefs.getString('Name') ?? '';
    Address = prefs.getString('Address') ?? '';
    SumOfBloodDonors = prefs.getString('SumBloodDonors') ?? '';
    Phone = prefs.getString('Phone') ?? '';
    UserID = prefs.getString('ID') ?? '';
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      this.FullName = FullName;
      this.UserID = UserID;
    });
  }

  _navigateToProfilePage() async {
    // Navigate to the Dashboard page and wait for the result
    bool refreshProfilePage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );

    // Check if the Dashboard page needs to refresh the Profile page
    if (refreshProfilePage == true) {
      // Call a function to refresh the Profile page data or state
      // For example, if your page contains an init() function to fetch profile data, you can call it here
      // init();
      _GetSessions();
      // Alternatively, you can use setState() to trigger a rebuild of the Profile page.
    }
  }

  Future<void> _RemoveSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.setString('SumBloodDonors', '');
    await prefs.setString('Name', '');
    await prefs.setString('Address', '');
    await prefs.setString('Phone', '');
    await prefs.setString('ID', '');
    await prefs.setString('Role', '');
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  void initState() {
    _GetSessions();
    super.initState();
  }

  // List<Menu> data = [];
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to Exit?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.of(context).pop(true),
                    SystemNavigator.pop(),
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        //  title: 'Hiil-Walaal Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Hiil-Walal',
              style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                icon: Icon(Icons.person),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Profile"),
                      value: "profile",
                    ),
                    PopupMenuItem(
                      child: Text("Logout"),
                      value: "logout",
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == "profile") {
                    _navigateToProfilePage();
                    // Navigate to profile screen
                  } else if (value == "logout") {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Confirm LogOut",
                          style: GoogleFonts.aBeeZee(),
                        ),
                        content: Text(
                          "Are you sure you want to logout?",
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.normal),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Perform logout action
                              _RemoveSessions();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              "LogOut",
                              style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          body: _currentPage,
          bottomNavigationBar: Visibility(
            visible: !(_currentPage is DashboardPage),
            child: ConvexAppBar.badge(
              const <int, dynamic>{3: ''},
              style: TabStyle.reactCircle,
              items: <TabItem>[
                TabItem(
                  icon: Icons.home,
                  title: 'Home',
                ),
                TabItem(icon: Icons.bloodtype, title: 'Blood'),
                TabItem(icon: Icons.attach_money, title: 'Charity'),
                TabItem(icon: Icons.history, title: 'Notices'),
                // TabItem(icon: Icons.person, title: 'Profile'),
              ],
              onTap: (int i) {
                if (i == 1) {
                  _navigateToPage(blood());
                } else if (i == 2) {
                  _navigateToPage(Charity());
                } else if (i == 4) {
                  _navigateToPage(ProfilePage());
                } else if (i == 3) {
                  _navigateToPage(NoticesPage());
                } else if (i == 0) {
                  _navigateToPage(MyHomePage());
                }
              },
            ),
          ),
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage('Images/logo-Black.pngs'),
                  //   fit: BoxFit.cover,
                  // ),
                  ),
              child: Column(
                children: [
                  // MyCard(),
                  DrawerHeader(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: Border(),
                      color: Colors.white,
                      // image: DecorationImage(
                      //   image: AssetImage('Images/logo-Black.png'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 48,
                                backgroundImage:
                                    AssetImage('Images/profile.png'),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      FullName ?? '',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      Address ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  // Divider(
                  //   thickness: 1,
                  // ),
                  Container(
                    width: double
                        .infinity, // Set the container width to match parent
                    alignment: Alignment
                        .centerLeft, // Set the alignment of the container
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Main Features',
                        textAlign: TextAlign.left,
                        style: GoogleFonts
                            .aBeeZee(), // Set the textAlign property of the Text widget
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.bloodtype_sharp,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      "Blood Register",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => DonorForm())));
                      // Implement onTap functionality here
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.local_hospital_sharp,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Blood Seeker",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => seekerForm())));
                      // Implement onTap functionality here
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: Colors.yellow,
                    ),
                    title: Text(
                      "Charity",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => ChariyahDash())));
                      // Implement onTap functionality here
                    },
                  ),
                  // Divider(
                  //   thickness: 1,
                  //   //color: Colors.black,
                  // ),
                  Container(
                    width: double
                        .infinity, // Set the container width to match parent
                    alignment: Alignment
                        .centerLeft, // Set the alignment of the container
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Setting',
                        textAlign: TextAlign.left,
                        style: GoogleFonts
                            .aBeeZee(), // Set the textAlign property of the Text widget
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.warning,
                      color: Colors.orange,
                    ),
                    title: Text(
                      "Notices",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => NoticesPage())));
                      // Implement onTap functionality here
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.houseUser,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Profile",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    onTap: () {
                      _navigateToProfilePage();
                      // Implement onTap functionality here
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: Colors.redAccent),
                    title: Text(
                      "Change Password",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => ChangePasswordPage())));
                      // Implement onTap functionality here
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.mail_outline,
                      color: Colors.lightBlue,
                    ),
                    title: Text(
                      "Contact Us",
                      style: GoogleFonts.aBeeZee(),
                      // style: TextStyle(),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => ContactUsPage())));
                      // Implement onTap functionality here
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_sharp,
                      color: Colors.cyan,
                    ),
                    title: Text(
                      "About Us",
                      style: GoogleFonts.aBeeZee(),
                      // style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => AboutTeamPage())));
                      // Implement onTap functionality here
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Log Out",
                      style: GoogleFonts.aBeeZee(),

                      //style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.exit_to_app, color: Colors.lightGreen),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "Confirm LogOut",
                            style: GoogleFonts.aBeeZee(),
                          ),
                          content: Text(
                            "Are you sure you want to logOut?",
                            style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.normal),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Perform logout action
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                                _RemoveSessions();
                              },
                              child: Text(
                                "LogOut",
                                style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );

                      // Implement onTap functionality here
                    },
                  ),
                ],
              ),
            ),
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
      length: 3,
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
    'History': Icons.history,
    // 'Profile': Icons.person,
  };
}
