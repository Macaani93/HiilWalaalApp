import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
import 'package:hilwalal_app/main.dart';
import 'package:hilwalal_app/profilepage.dart';
import 'package:hilwalal_app/seeker.dart';

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

  // List<Menu> data = [];
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
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // image: DecorationImage(
                    //   image: AssetImage('Images/logo-Black.png'),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 12.0,
                        left: 16.0,
                        child: Text(
                          GetFullName(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
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
                  leading: Icon(Icons.bloodtype_outlined),
                  title: Text(
                    "Blood Register",
                    style: GoogleFonts.aBeeZee(),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        (MaterialPageRoute(builder: (context) => DonorForm())));
                    // Implement onTap functionality here
                  },
                ),
                ListTile(
                  leading: Icon(Icons.local_hospital_outlined),
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
                  leading: Icon(Icons.monetization_on),
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
                  leading: Icon(Icons.person_outline),
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
                  leading: Icon(Icons.lock_outline),
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
                  leading: Icon(Icons.mail_outline),
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
                  leading: Icon(Icons.info_outline),
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
                  leading: Icon(Icons.lock_clock_rounded),
                  onTap: () {
                    Navigator.push(context,
                        (MaterialPageRoute(builder: (context) => LoginPage())));
                    // Implement onTap functionality here
                  },
                ),
              ],
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

// import 'package:flutter/material.dart';

// class ChatDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: Colors.grey.shade200,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   DrawerHeader(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundImage: AssetImage('assets/user.png'),
//                         ),
//                         Text(
//                           'John Doe',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                         Text(
//                           'john.doe@example.com',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text('Profile'),
//                     onTap: () {
//                       // Navigate to profile screen
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.settings),
//                     title: Text('Settings'),
//                     onTap: () {
//                       // Navigate to settings screen
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.logout),
//                     title: Text('Logout'),
//                     onTap: () {
//                       // Logout user
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 50,
//               color: Colors.blue,
//               child: Center(
//                 child: Text(
//                   'Version 1.0.0',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _buildDrawer() {
//   return ListView.separated(
//     padding: const EdgeInsets.only(top: 0),
//     itemCount: data.length,
//     itemBuilder: (BuildContext context, int index) {
//       if (index == 0) {
//         return _buildDrawerHeader(data[index]);
//       }
//       return _buildMenuList(data[index]);
//     },
//     separatorBuilder: (BuildContext context, int index) => const Divider(
//       height: 1,
//       thickness: 2,
//     ),
//   );
// }

// Widget _buildDrawerHeader(Menu headItem) {
//   return DrawerHeader(
//       margin: const EdgeInsets.only(bottom: 0),
//       decoration: const BoxDecoration(
//         color: Colors.blue,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             headItem.icon,
//             color: Colors.white,
//             size: 60,
//           ),
//           const Spacer(),
//           Text(
//             headItem.title,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ));
// }

// Widget _buildMenuList(Menu menuItem) {
//   //build the expansion tile
//   double lp = 0; //left padding
//   double fontSize = 20;
//   if (menuItem.level == 1) {
//     lp = 20;
//     fontSize = 16;
//   }
//   if (menuItem.level == 2) {
//     lp = 30;
//     fontSize = 14;
//   }

//   if (menuItem.children.isEmpty) {
//     return Builder(builder: (context) {
//       return InkWell(
//         child: Padding(
//           padding: EdgeInsets.only(left: lp),
//           child: ListTile(
//             leading: Icon(menuItem.icon),
//             title: Text(
//               menuItem.title,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//           ),
//         ),
//         onTap: () {
//           // Close the drawer
//           Navigator.pop(context);

//           //Then direct user to dashboard page
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => Dashboard(menuItem),
//           //   ),
//           // );
//         },
//       );
//     });
//   }

//   return Padding(
//     padding: EdgeInsets.only(left: lp),
//     child: ExpansionTile(
//       leading: Icon(menuItem.icon),
//       title: Text(
//         menuItem.title,
//         style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
//       ),
//       children: menuItem.children.map(_buildMenuList).toList(),
//     ),
//   );
// }

// //The Menu Model
// class Menu {
//   int level = 0;
//   IconData icon = Icons.drive_file_rename_outline;
//   String title = "";
//   List<Menu> children = [];
//   //default constructor
//   Menu(this.level, this.icon, this.title, this.children);

//   //one method for  Json data
//   Menu.fromJson(Map<String, dynamic> json) {
//     //level
//     if (json["level"] != null) {
//       level = json["level"];
//     }
//     //icon
//     if (json["icon"] != null) {
//       icon = json["icon"];
//     }
//     //title
//     title = json['title'];
//     //children
//     if (json['children'] != null) {
//       children.clear();
//       //for each entry from json children add to the Node children
//       json['children'].forEach((v) {
//         children.add(Menu.fromJson(v));
//       });
//     }
//   }
// }

// //menu data list
// List dataList = [
//   //menu data item
//   {
//     "level": 0,
//     "icon": Icons.account_circle_rounded,
//     "title": "HIIL WALAL",
//   },

//   //menu data item
//   {
//     "level": 0,
//     "icon": Icons.bloodtype_sharp,
//     "title": "Blood Donation",
//     "children": [
//       {
//         "level": 1,
//         "icon": Icons.bloodtype_sharp,
//         "title": "Blood Register",
//       },
//       {
//         "level": 1,
//         "icon": Icons.local_hospital,
//         "title": "Blood Seeker",
//       },
//       {
//         "level": 1,
//         "icon": Icons.monetization_on,
//         "title": "Charity",
//       },
//     ]
//   },
//   //menu data item
//   // {
//   //   "level": 0,
//   //   "icon": Icons.monetization_on,
//   //   "title": "Charity Donation",
//   //   "children": [
//   //     {
//   //       "level": 1,
//   //       "icon": Icons.monetization_on,
//   //       "title": "Charity",
//   //     },
//   //   ]
//   // },
//   {
//     "level": 0,
//     "icon": Icons.local_hospital,
//     "title": "Hospitals",
//     "children": [
//       // {
//       //   "level": 1,
//       //   "icon": Icons.monetization_on,
//       //   "title": "Charity",
//       // },
//     ]
//   },
//   {
//     "level": 0,
//     "icon": Icons.person_outline,
//     "title": "Profile",
//     "children": [
//       // {
//       //   "level": 1,
//       //   "icon": Icons.payment,
//       //   "title": "User Information",
//       // },
//     ]
//   },
//   {
//     "level": 0,
//     "icon": Icons.lock_outline,
//     "title": "Change Password",
//     "children": [
//       // {
//       //   "level": 1,
//       //   "icon": Icons.payment,
//       //   "title": "Change Password",
//       // },
//     ]
//   },
//   {
//     "level": 0,
//     "icon": Icons.mail_outline,
//     "title": "Contact Us",
//     "children": []
//   },
//   {"level": 0, "icon": Icons.info_outline, "title": "About Us", "children": []},
//   {
//     // "level": 0,
//     "icon": Icons.lock_clock_rounded,
//     "title": "Log Out",
//     "children": [
//       // {
//       //   "level": 1,
//       //   "icon": Icons.payment,
//       //   "title": "Change Password",
//       // },
//     ]
//   },
// ];

//import 'package:flutter/material.dart';

//import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/drawer_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(Icons.bloodtype_sharp),
              title: Text(
                "Blood Donation",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  leading: Icon(Icons.bloodtype_sharp),
                  title: Text("Blood Register"),
                  onTap: () {
                    // Implement onTap functionality here
                  },
                ),
                ListTile(
                  leading: Icon(Icons.local_hospital),
                  title: Text("Blood Seeker"),
                  onTap: () {
                    // Implement onTap functionality here
                  },
                ),
                ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text("Charity"),
                  onTap: () {
                    // Implement onTap functionality here
                  },
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(Icons.person_outline),
              title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text("User Information"),
                  onTap: () {
                    // Implement onTap functionality here
                  },
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(Icons.lock_outline),
              title: Text(
                "Change Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text("Change Password"),
                  onTap: () {
                    // Implement onTap functionality here
                  },
                ),
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text(
                "Contact Us",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Implement onTap functionality here
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(
                "About Us",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Implement onTap functionality here
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                "Log Out",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.lock_clock_rounded),
              onTap: () {
                // Implement onTap functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
