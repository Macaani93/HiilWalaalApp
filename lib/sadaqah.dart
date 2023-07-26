import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/Api/api.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Donation {
  String name;
  String district;
  String type;
  String description;
  String amount;

  Donation({
    required this.name,
    required this.district,
    required this.type,
    required this.description,
    required this.amount,
  });
}

class SadaqahForm extends StatefulWidget {
  final String name;
  final String ID;
  final String district;
  final String amount;
  final String Type;
  final String description;
  SadaqahForm({
    Key? key,
    required this.name,
    required this.district,
    required this.ID,
    required this.amount,
    required this.Type,
    required this.description,
  }) : super(key: key);

  @override
  _SadaqahFormState createState() => _SadaqahFormState();
}

class _SadaqahFormState extends State<SadaqahForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  TextEditingController _phone = TextEditingController();
  String _address = "";
  String? FullName;
  String? UserID;
  String? Address;
  String? Phone;
  String? Role;
  String? SumOfBloodDonors;
  bool _isAmountDisabled = false;
  final double minValue = 0.01; // Set your desired minimum value here

  Future<void> _GetSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    UserID = prefs.getString('ID') ?? '';
    //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      this.UserID = UserID;
    });
  }

  TextEditingController _amount = TextEditingController();
  Future<void> startSending(String CharityID) async {
    String apiUrl = "http://" + apiLogin + "/flutterApi/Sadaqah.php";

    try {
      var response = await http.post(Uri.parse(apiUrl), body: {
        'UserID': UserID ?? '',
        'Amount': _amount.text,
        'CharityID': CharityID,
        'Phone': _phone.text
      });
      if (response.statusCode == 200) {
        print('response');
        var jsonData = json.decode(response.body);
        print(jsonData);

        if (jsonData["message"] == "Inserted Success") {
          String formatCurrentDate() {
            DateTime now = DateTime.now();
            String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);
            return formattedDate;
          }

          String formattedDate = formatCurrentDate();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'Warbixin',
            desc: "\$" +
                _amount.text +
                " Ayaad Ku bixisay " +
                (widget.name) +
                ', Tar: ' +
                formattedDate,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
          String Number = _phone.text;
          String Body = "[-Hiil-Walaal-] waxaad \$" +
              _amount.text +
              ' u wareejisay ' +
              (widget.name) +
              ' Tar:' +
              formattedDate;
          sendSMS(Number, Body);
          _phone.clear();
          _amount.clear();
          // Clear();
        } else if (jsonData["message"] == "User already exists") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Warbixin',
            desc: 'User already exists',
            // btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      }
    } catch (error) {}
  }

  void _onAmountChanged() {
    // Get the entered amount
    String value = _amount.text;
    double enteredAmount = double.tryParse(value) ?? 0.0;
    if (_amount.text != '') {
      // Check if the entered amount is greater than the available donation amount
      if (enteredAmount > double.parse(widget.amount)) {
        // If entered amount is greater, set the _amount controller's text to the available donation amount
        _amount.text = widget.amount;
        // Optionally, you can show a toast or a message to inform the user that the amount exceeds the available donation amount
        // For example, you can use the fluttertoast package to show a toast message.
        // Fluttertoast.showToast(msg: 'Entered amount cannot exceed the available donation amount');
      }
    }
  }

  void initState() {
    _GetSessions();
    super.initState();
    _amount.addListener(_onAmountChanged);
  }

  Future<void> sendSMS(String phoneNumber, String message) async {
    // Replace these values with your API credentials and URL
    final String user = 'TabaarakTest';
    final String password = 'TabaarakTest@@';
    final String apiUrl = 'https://tabaarakict.so/SendSMS.aspx';

    // Encode the message to URL format
    String encodedMessage = Uri.encodeComponent(message);

    // Construct the API URL with the required parameters
    String smsApiUrl =
        '$apiUrl?user=$user&pass=$password&cont=$encodedMessage&rec=$phoneNumber';

    try {
      // Make an HTTP GET request to the API
      var response = await http.get(Uri.parse(smsApiUrl));

      // Check if the request was successful
      if (response.statusCode == 200) {
        print('SMS sent successfully.');
      } else {
        print('Failed to send SMS. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Error sending SMS: $e');
    }
  }

  Future<void> _submitData() async {
    // Construct the request body
    Map<String, dynamic> requestBody = {
      "schemaVersion": "1.0",
      "requestId": "10111331033",
      "timestamp": "client_timestamp",
      "channelName": "WEB",
      "serviceName": "API_PURCHASE",
      "serviceParams": {
        "merchantUid": "M0910291",
        "apiUserId": "1000416",
        "apiKey": "API-675418888AHX",
        "paymentMethod": "mwallet_account",
        "payerInfo": {"accountNo": _phone.text},
        "transactionInfo": {
          "referenceId": "12334",
          "invoiceId": "7896504",
          "amount": double.parse(_amount.text),
          "currency": "USD",
          "description": "Test USD"
        }
      }
    };

    // Encode the request body as JSON
    String requestBodyJson = jsonEncode(requestBody);

    // Set the request headers
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // Send the HTTP POST request to the API endpoint
    http.Response response = await http.post(
      Uri.parse('https://api.waafipay.net/asm'),
      headers: requestHeaders,
      body: requestBodyJson,
    );

    // Handle the response from the API endpoint
    if (response.statusCode == 200) {
      // The request was successful
      var responseJson = json.decode(response.body);

// Extract the value of STATE from the response message
      var responseMsg = responseJson['responseMsg'];
      print(responseMsg);
      String getResponseMessage(String responseMsg) {
        if (responseMsg.contains('User Aborted') ||
            responseMsg.contains('2, TransactionId:')) {
          return 'User Rejected';
        } else if (responseMsg.contains('Nambarka Sirta ah waa Khalad') ||
            responseMsg.contains('waa khalad numberka PIN-ka ah')) {
          return 'Number-ka Sirta ah Waa Khalad';
        } else if (responseMsg.contains('User do not exist in system') ||
            responseMsg.contains('Subscriber Not Found')) {
          return 'Numberkaan Majiro';
        } else if (responseMsg.contains('2, TransactionId:')) {
          return 'Waa laga laabtay';
        } else if (responseMsg.contains('Dialog Timedout') ||
            responseMsg.contains('timeout occured waiting user response')) {
          return 'Waqtiga Ayaa Dhamaaday';
        } else if (responseMsg.contains('RCS_SUCCESS')) {
          return 'dirid';
        } else if (responseMsg.contains('RCS_NO_ROUTE_FOUND')) {
          return 'RCS_NO_ROUTE_FOUND';
        } else if (responseMsg.contains('Haraaga xisaabtaadu kuguma filna')) {
          return 'Haraaga xisaabtaadu kuguma filna';
        } else if (responseMsg.contains('RCS_TRAN_FAILED_AT_ISSUER_SYSTEM')) {
          return 'RCS_TRAN_FAILED_AT_ISSUER_SYSTEM';
        } else {
          // Add more conditions to check for other response types if needed.
          return 'Other response type';
        }
      }

      if (getResponseMessage(responseMsg) == 'User Rejected') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: 'Waa Laga laabtay!.',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (getResponseMessage(responseMsg) ==
          'Number-ka Sirta ah Waa Khalad') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: 'Number-ka Sirta ah Waa Khalad',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (getResponseMessage(responseMsg) == 'Numberkaan Majiro') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: 'Numberkaan Majiro!',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (getResponseMessage(responseMsg) == 'RCS_NO_ROUTE_FOUND') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: 'Fadlan Number-ka si sax ah u qor!',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (getResponseMessage(responseMsg) == 'Waqtiga Ayaa Dhamaaday') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: 'Waqtiga Ayaa Dhamaaday',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (getResponseMessage(responseMsg) == 'Waa laga laabtay') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: 'Waa laga laabtay',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (getResponseMessage(responseMsg) == 'dirid') {
        startSending((widget.ID));
      } else if (getResponseMessage(responseMsg) ==
          'Haraaga xisaabtaadu kuguma filna') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: 'Haraaga xisaabtaadu kuguma filna, ' + _phone.text,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (getResponseMessage(responseMsg) ==
          'RCS_TRAN_FAILED_AT_ISSUER_SYSTEM') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: 'Fadlan markale ku celi!',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }

      // if (responseMsg.contains('rejected')) {
      //   if (responseMsg.contains('User Aborted')) {
      //     print('User Aborted');
      //   } else {
      //     print('Rejected');
      //   }
      // } else if (responseMsg.contains('declined')) {
      //   if (responseMsg.contains('Nambarka Sirta ah waa Khalad')) {
      //     print('Pin Invalid');
      //   } else {
      //     print('Declined');
      //   }
      // } else {
      //   print('Success');
      // }

      // var stateStartIndex = responseMsg.indexOf('(STATE: ') + '(STATE: '.length;
      // var stateEndIndex = responseMsg.indexOf(',', stateStartIndex);
      // var state = responseMsg.substring(stateStartIndex, stateEndIndex);

      // print(state);

      //   if (state == 'declined') {
      //
      //   } else if (state == 'rejected') {
      //     AwesomeDialog(
      //       context: context,
      //       dialogType: DialogType.WARNING,
      //       animType: AnimType.RIGHSLIDE,
      //       title: 'Warbixin',
      //       desc: state,
      //       // btnCancelOnPress: () {},
      //       btnOkOnPress: () {},
      //     ).show();
      //   } else {
      //     AwesomeDialog(
      //       context: context,
      //       dialogType: DialogType.SUCCES,
      //       animType: AnimType.RIGHSLIDE,
      //       title: 'Warbixin',
      //       desc: state,
      //       // btnCancelOnPress: () {},
      //       btnOkOnPress: () {},
      //     ).show();
      //   }
      // } else {
      //   // The request failed
      //   print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Donation donation = Donation(
        name: widget.name,
        district: widget.district,
        type: widget.Type,
        description: widget.description,
        amount: widget.amount);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiil-Walal'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   Icons.attach_money,
              //   size: 50.80,
              //   color: Colors.green,
              // ),
              // Text(
              //   'Sadaqah',
              //   style: TextStyle(
              //     fontSize: 30,
              //     color: Color.fromARGB(255, 43, 3, 186),
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 35,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 11, 229),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                donation.type,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            donation.name,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.grey[800],
                            ),
                          ),
                          Container(height: 10),
                          Text(
                            donation.district,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                          Container(height: 10),
                          Text(
                            donation.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.money),
                          hintText: 'Number',
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(60.0),
                          // ),
                        ),
                        keyboardType:
                            TextInputType.number, // Only allows numeric input
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly // Restrict input to digits only
                        ],
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _amount,
                        decoration: InputDecoration(
                          hintText: 'Amount',
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the donation amount';
                          }
                          double? enteredAmount = double.tryParse(value);
                          if (enteredAmount == null || enteredAmount < 0.1) {
                            return 'The entered amount must be at least $minValue';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed:
                    _submitData, // Call the submitData function when the button is pressed
                child: Text('Donate Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
