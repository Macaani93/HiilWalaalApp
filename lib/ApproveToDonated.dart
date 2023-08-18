import 'package:flutter/material.dart';
import 'package:hilwalal_app/Api/Sessions.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ApprovedDonatedUsersPage extends StatefulWidget {
  @override
  _ApprovedDonatedUsersPageState createState() =>
      _ApprovedDonatedUsersPageState();
}

class _ApprovedDonatedUsersPageState extends State<ApprovedDonatedUsersPage> {
  List<dynamic> donatedUsers = [];
  List<dynamic> filteredUsers = [];

  bool _isLoading = true;
  String? FullName;
  String? UserID;
  String? Address;
  String? Phone;
  String? Role;
  String? SumOfBloodDonors;
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
    fetchApprovedDonatedUsers();
  }

  Future<void> sendData(String userID, String hospitalID) async {
    // final url = 'http://' + apiLogin + '/flutterApi/UpdateBloodDonated.php';
    final url = apiDomain + 'UpdateBloodDonated.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'ID': userID,
        'HospitalID': hospitalID,
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['message'] == 'Update successful') {
        // Data updated successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated successfully."),
          ),
        );
      } else {
        // Error occurred during update
        print('Error: ${result['message']}');
      }
    } else {
      // Error occurred in the API request
      print('HTTP ${response.statusCode} Error');
    }
  }

  Future<void> fetchApprovedDonatedUsers() async {
    final response = await http.get(
        // Uri.parse('http://' + apiLogin + '/flutterApi/DisplayDonated.php'));
        Uri.parse(apiDomain + 'DisplayDonated.php'));
    if (response.statusCode == 200) {
      setState(() {
        donatedUsers = json.decode(response.body);
        filteredUsers = List.from(donatedUsers); // Copy all data initially
        _isLoading = false;
      });
    } else {
      // Handle error if the API call fails
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  void _filterUsers(String query) {
    setState(() {
      filteredUsers = donatedUsers
          .where((user) =>
              user['name'].toLowerCase().contains(query.toLowerCase()) ||
              user['Address'].toLowerCase().contains(query.toLowerCase()) ||
              user['Phone'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _showConfirmationDialog(dynamic user) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Approve Donated'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure to donate ' + user['name'] + ' ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                // Implement your approval logic here
                // For example, you can call an API to update the donor's status to "Approved"
                // and then update the UI accordingly.
                // For simplicity, let's just remove the donor from the list.
                sendData(user['ID'], UserID!);
                setState(() {
                  filteredUsers.remove(user);
                });
                Navigator.of(context).pop();
                // sendData()
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildListTile(dynamic user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 2, 5, 3),
          child: Card(
            child: ListTile(
              title: Text('Name: ${user['name']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address: ${user['Address']}'),
                  // Text('ID: ${user['ID']}'),
                  Text('Phone: ${user['Phone']}'),
                  Text('Blood Type: ${user['BloodType']}'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(user);
                },
                child: Text('Approve Donated'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerListTile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        title: Container(
          width: 100.0,
          height: 16.0,
          color: Colors.white,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150.0,
              height: 12.0,
              color: Colors.white,
            ),
            SizedBox(height: 4.0),
            Container(
              width: 100.0,
              height: 12.0,
              color: Colors.white,
            ),
            SizedBox(height: 4.0),
            Container(
              width: 80.0,
              height: 12.0,
              color: Colors.white,
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: null,
          child: Text('Approve Donated'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        title: Text('Approved Donated Users'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => _filterUsers(value),
              decoration: InputDecoration(
                labelText: 'Search by name, address, or phone',
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? ListView.builder(
                    itemCount: 5, // Show 5 shimmer tiles while loading
                    itemBuilder: (context, index) => _buildShimmerListTile(),
                  )
                : ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) =>
                        _buildListTile(filteredUsers[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
