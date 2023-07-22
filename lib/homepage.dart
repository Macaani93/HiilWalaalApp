import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/ChariyahDash.dart';
import 'package:hilwalal_app/charity.dart';
import 'package:hilwalal_app/donor.dart';
import 'package:hilwalal_app/seeker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                const SizedBox(height: 30)
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
                  itemDashboard('BLOOD DONOR', CupertinoIcons.drop,
                      Colors.deepOrange, SumOfBloodDonors ?? '',
                      pageBuilder: (context) => DonorForm()),
                  itemDashboard(
                      'BLOOD SEEKER', CupertinoIcons.search, Colors.green, '4',
                      pageBuilder: (context) => seekerForm()),
                  itemDashboard(
                    'Blood Donated',
                    CupertinoIcons.person_2,
                    Colors.purple,
                    '110',
                    pageBuilder: null,
                  ),
                  itemDashboard('CHARITY', CupertinoIcons.chat_bubble_2,
                      Colors.brown, '1000',
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

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              image: DecorationImage(
                image:
                    AssetImage('Images/profile.png'), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  // final VoidCallback? press;

  const CategoryCard({
    required this.svgSrc,
    required this.title,
    // required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: const Color.fromARGB(31, 80, 80, 80),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Image.asset(svgSrc),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
