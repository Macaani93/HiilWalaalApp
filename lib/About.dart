import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("Images/logo-Black.png"),
                  ),
                  SizedBox(height: 16),
                  Text("Hiil-Walaal ",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 16),
                  Text(
                      "Hiilwalaal is a blood donor and seeker who understands the importance of reliable blood supply. They support and trust charity organizations using mobile apps to make a positive impact on the world.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.aBeeZee(fontSize: 16)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Meet Our Team",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTeamMember(
                    name: "Ubeyd Abdi Sheikh",
                    jobTitle: "Leader",
                    imageUrl: "Images/Obaid2.jpg",
                  ),
                  _buildTeamMember(
                    name: "Mohamed Ahmed Isse",
                    jobTitle: "Co-Leader",
                    imageUrl: "Images/macani.png",
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTeamMember(
                    name: "Zakariye dahir Farah",
                    jobTitle: "Member",
                    imageUrl: "Images/zaki.jpg",
                  ),
                  _buildTeamMember(
                    name: "Shuceyb Ibrahim Ali",
                    jobTitle: "Member",
                    imageUrl: "Images/shuceyb2.png",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMember(
      {required String name,
      required String jobTitle,
      required String imageUrl}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(imageUrl),
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.aBeeZee(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(jobTitle,
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
