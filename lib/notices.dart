import 'package:flutter/material.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class Notice {
  String comment;
  String time;

  Notice({required this.comment, required this.time});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      comment: json['Comment'],
      time: json['Time'],
    );
  }
}

class BadgeIcon extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color badgeColor;

  BadgeIcon({
    required this.iconData,
    required this.iconColor,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(iconData, color: iconColor),
        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            backgroundColor: badgeColor,
            radius: 6,
          ),
        ),
      ],
    );
  }
}

class NoticesPage extends StatefulWidget {
  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  List<Notice> notices = [];
  bool isLoading = true;
  String? UserID;

  Future<void> _GetSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    UserID = prefs.getString('ID') ?? '';
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      this.UserID = UserID;
    });
  }

  @override
  void initState() {
    super.initState();
    _GetSessions();
    fetchNoticesDataWithDelay();
  }

  Future<void> fetchNoticesData() async {
    try {
      String apiUrl = "http://" + apiLogin + "/flutterApi/notices.php";
      var response = await http.post(Uri.parse(apiUrl), body: {
        'userID':
            UserID ?? '', // Provide a default value for UserID if it is null
      });

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        // Explicitly cast to List<dynamic> before mapping to List<Notice>
        List<Notice> fetchedNotices = (jsonData as List<dynamic>)
            .map((data) => Notice.fromJson(data))
            .toList();

        print("Fetched notices: $fetchedNotices");

        setState(() {
          notices = fetchedNotices;
          isLoading = false;
        });
      } else {
        print('Failed to load notices');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchNoticesDataWithDelay() async {
    await Future.delayed(Duration(seconds: 2)); // Add a 2-second delay
    fetchNoticesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 228),
      appBar: AppBar(
        title: Text('Notices'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? _buildShimmerEffect()
            : notices.isEmpty
                ? Center(child: Text('No notices found.'))
                : ListView.builder(
                    itemCount: notices.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: BadgeIcon(
                                iconData: Icons.notifications,
                                iconColor: Colors.blue,
                                badgeColor: Colors.blue,
                              ),
                              title: Text(notices[index].comment),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  BadgeIcon(
                                    iconData: Icons.comment,
                                    iconColor: Colors.orange,
                                    badgeColor: Colors.orange,
                                  ),
                                  Text(notices[index].time),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 5, // Show 5 shimmering placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              color: Colors.white,
            ),
            title: Container(
              height: 20,
              color: Colors.white,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 12,
                  color: Colors.white,
                ),
                Container(
                  height: 12,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Run the NoticesPage widget in your app
