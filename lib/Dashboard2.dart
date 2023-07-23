import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/About.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/ApproveToDonated.dart';
import 'package:hilwalal_app/ChariyahDash.dart';
import 'package:hilwalal_app/ContactUs.dart';
import 'package:hilwalal_app/blood.dart';
import 'package:hilwalal_app/changePassword.dart';
import 'package:hilwalal_app/donor.dart';
import 'package:hilwalal_app/homepage.dart';
import 'package:hilwalal_app/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:hilwalal_app/notices.dart';
import 'package:hilwalal_app/profilepage.dart';
import 'package:hilwalal_app/seeker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'charity.dart';

class Dashboard2 extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard2> {
  Widget _currentPage = MyHomePage2();

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
    });
  }

  Future<void> _RemoveSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      this.FullName = FullName;
    });
  }

  void initState() {
    super.initState();
    _GetSessions();
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
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
                TabItem(icon: Icons.bloodtype, title: 'Seeker'),
                TabItem(icon: Icons.check_box_sharp, title: 'Donated'),
                TabItem(icon: Icons.history, title: 'Notice'),
                // TabItem(icon: Icons.person, title: 'Profile'),
              ],
              onTap: (int i) {
                if (i == 1) {
                  _navigateToPage(seekerForm());
                } else if (i == 2) {
                  _navigateToPage(ApprovedDonatedUsersPage());
                } else if (i == 3) {
                  _navigateToPage(NoticesPage());
                } else if (i == 0) {
                  _navigateToPage(MyHomePage2());
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
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => ProfilePage())));
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

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  String? FullName;
  String? UserID;
  String? Address;
  String? Phone;
  String? Role;
  String? SumOfBloodDonors;
  // String? FullName;
  String getGreeting() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);
    if (currentTime.hour < 12) {
      return 'Good Morning';
    } else if (currentTime.hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Night';
    }
  }

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
    });
  }

  void initState() {
    super.initState();
    _GetSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Hello, ' + FullName!,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    getGreeting(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white54),
                  ),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('Images/profile.png'),
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Donors Available', CupertinoIcons.drop,
                      Colors.deepOrange, SumOfBloodDonors ?? '',
                      pageBuilder: (context) => seekerForm()),
                  itemDashboard(
                      'Donated Users', CupertinoIcons.search, Colors.green, '4',
                      pageBuilder: null),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget itemDashboard(
      String title, IconData iconData, Color background, String TextData,
      {Widget Function(BuildContext)? pageBuilder}) {
    return GestureDetector(
      onTap: () {
        if (pageBuilder != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pageBuilder(context)));
        } else {
          // do something else when item is tapped but no page builder is provided
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white)),
            const SizedBox(height: 20),
            Text(title.toUpperCase(), style: GoogleFonts.aBeeZee(fontSize: 14)),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(TextData),
            ),
          ],
        ),
      ),
    );
  }
}
