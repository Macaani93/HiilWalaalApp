import 'package:flutter/material.dart';

class BloodDonationRulesPage extends StatelessWidget {
  final String title = 'Blood Donation Rules';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'General Rules:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '1. Donors must be in good health and feeling well on the day of donation.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '2. Donors must weigh at least 50 kg.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '3. Donors must be at least 16 years old (with parental consent) or 18 years old (without parental consent).',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '4. Donors must not have donated blood in the last 8 weeks.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '5. Donors must not have any history of blood-borne diseases or infections.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Before Donation:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '6. Get plenty of rest and eat a healthy meal before donation.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '7. Drink plenty of fluids (water or juice) before donation.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '8. Avoid alcohol and smoking for at least 24 hours before donation.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'After Donation:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '9. Drink plenty of fluids (water or juice) after donation.',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '10. Avoid heavy lifting or strenuous exercise for at least 24 hours after donation.',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
