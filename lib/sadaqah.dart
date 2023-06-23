import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SadaqahForm extends StatefulWidget {
  SadaqahForm({Key? key}) : super(key: key);

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
        "payerInfo": {
          "accountNo": _phone.text,
        },
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
      print(response.body);
    } else {
      // The request failed
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HIILLWALAL APPLICATION'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attach_money,
                size: 50.80,
                color: Colors.green,
              ),
              Text(
                'Sadaqah',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 43, 3, 186),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _phone,
                decoration: InputDecoration(
                  hintText: 'Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _amount,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
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
