import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
  final String district;
  final String amount;
  final String Type;
  final String description;
  SadaqahForm({
    Key? key,
    required this.name,
    required this.district,
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
  TextEditingController _amount = TextEditingController();

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
      var stateStartIndex = responseMsg.indexOf('(STATE: ') + '(STATE: '.length;
      var stateEndIndex = responseMsg.indexOf(',', stateStartIndex);
      var state = responseMsg.substring(stateStartIndex, stateEndIndex);

      print(state);

      if (state == 'declined') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: state,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (state == 'rejected') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: state,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Warbixin',
          desc: state,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    } else {
      // The request failed
      print('Error: ${response.statusCode}');
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
              Padding(
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
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid amount';
                        }
                        double enteredAmount = double.parse(value);
                        if (enteredAmount > double.parse(donation.amount)) {
                          return 'The entered amount is greater than the donation amount';
                        }
                        return null;
                      },
                      keyboardType:
                          TextInputType.number, // Only allows numeric input
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly // Restrict input to digits only
                      ],
                    ),
                  ],
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
