import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/donor.dart';
import 'package:hilwalal_app/seeker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? fullName;
  String? userID;
  String? address;
  String? phone;
  String? role;
  String? sumOfBloodDonors;
  String? sumOfBloodDonorPending;
  String? sumOfCharity;
  String? SumBloodDonated;

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

  Future<void> _getSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullName = prefs.getString('Name') ?? '';
    address = prefs.getString('Address') ?? '';
    sumOfBloodDonors = prefs.getString('SumBloodDonors') ?? '';
    sumOfBloodDonorPending = prefs.getString('SumBloodDonorNotApproved') ?? '';
    SumBloodDonated = prefs.getString('SumBloodDonated') ?? '';
    sumOfCharity = prefs.getString('SumCharity') ?? '';
    phone = prefs.getString('Phone') ?? '';
    userID = prefs.getString('ID') ?? '';
    setState(() {
      this.fullName = fullName;
      this.userID = userID;
      this.sumOfBloodDonorPending = sumOfBloodDonorPending;
      this.sumOfCharity = sumOfCharity;
      this.sumOfBloodDonors = sumOfBloodDonors;
      this.SumBloodDonated = SumBloodDonated;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSessions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)), // Delay of 2 seconds
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show shimmer effect while waiting for 2 seconds
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Scaffold(
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
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          title: Text(
                            'Hello, ' + (fullName ?? 'LOADING'),
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
                          trailing: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('Images/profile.png'),
                          ),
                        ),
                        const SizedBox(height: 30),
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
                            BorderRadius.only(topLeft: Radius.circular(200)),
                      ),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 30,
                        children: [
                          shimmerItemDashboard(),
                          shimmerItemDashboard(),
                          shimmerItemDashboard(),
                          shimmerItemDashboard(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        } else {
          // Show actual content after 2 seconds delay
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        title: Text(
                          'Hello, ' + (fullName ?? ''),
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
                        trailing: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('Images/profile.png'),
                        ),
                      ),
                      const SizedBox(height: 30),
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
                          BorderRadius.only(topLeft: Radius.circular(200)),
                    ),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 30,
                      children: [
                        itemDashboard('BLOOD DONOR', CupertinoIcons.drop,
                            Colors.deepOrange, sumOfBloodDonors ?? '',
                            pageBuilder: (context) => DonorForm()),
                        itemDashboard('BLOOD SEEKER', CupertinoIcons.search,
                            Colors.green, sumOfBloodDonorPending ?? '',
                            pageBuilder: (context) => seekerForm()),
                        itemDashboard('Blood Donated', CupertinoIcons.person_2,
                            Colors.purple, SumBloodDonated ?? '',
                            pageBuilder: null),
                        itemDashboard('CHARITY', CupertinoIcons.chat_bubble_2,
                            Colors.brown, sumOfCharity ?? '',
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
      },
    );
  }

  Widget shimmerItemDashboard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'LOADING',
            style: GoogleFonts.aBeeZee(fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 60,
            height: 10,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(
      String title, IconData iconData, Color background, String textData,
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
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(title.toUpperCase(), style: GoogleFonts.aBeeZee(fontSize: 14)),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(textData),
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
