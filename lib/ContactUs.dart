import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  bool _isLoadingAvatar = true;
  bool _isLoadingSocialIcons = true;

  @override
  void initState() {
    super.initState();
    // Simulate an asynchronous data loading delay for the avatar
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoadingAvatar = false;
        _isLoadingSocialIcons = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildShimmeringCircleAvatar(),
            SizedBox(
              height: 20,
            ),
            ContactCard(
              iconData: Icons.email,
              title: 'Email',
              content: 'faasle113@gmail.com',
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            ContactCard(
              iconData: Icons.phone,
              title: 'Phone',
              content: '+252 (061) 934-6686',
              color: Colors.green,
            ),
            SizedBox(height: 20),
            ContactCard(
              iconData: Icons.location_on,
              title: 'Address',
              content: 'Digfeer Street,Hodan,Mogadisho,Somalia ',
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            _buildShimmeringSocialIcons()
          ],
        ),
      ),
    );
  }

  Widget _buildShimmeringCircleAvatar() {
    return Visibility(
      visible: _isLoadingAvatar,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.white,
          child: Container(
            color: Colors.white,
          ),
        ),
      ),
      replacement: CircleAvatar(
        radius: 100,
        backgroundImage: AssetImage(
          'Images/logo-white.jpg',
        ),
      ),
    );
  }

  Widget _buildShimmeringSocialIcons() {
    return Visibility(
      visible: _isLoadingSocialIcons,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIconPlaceholder(),
            _buildSocialIconPlaceholder(),
            _buildSocialIconPlaceholder(),
            _buildSocialIconPlaceholder(),
          ],
        ),
      ),
      replacement: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SocialIcon(
            iconData: FontAwesomeIcons.facebook,
            url: 'https://www.facebook.com/EngCubeydah',
          ),
          SocialIcon(
            iconData: FontAwesomeIcons.instagram,
            url: 'https://www.instagram.com/obaid__abdi__sheikh/',
          ),
          SocialIcon(
            iconData: FontAwesomeIcons.whatsapp,
            url: 'https://wa.me/252619346686',
          ),
          SocialIcon(
            iconData: FontAwesomeIcons.twitter,
            url: 'https://twitter.com/ObaidAbdi',
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIconPlaceholder() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class ContactCard extends StatefulWidget {
  final IconData iconData;
  final String title;
  final String content;
  final Color color;

  ContactCard({
    required this.iconData,
    required this.title,
    required this.content,
    required this.color,
  });

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate an asynchronous data loading delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? _buildShimmerEffect() : _buildContactCard();
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                widget.iconData,
                size: 50,
                color: widget.color,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 18,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 200,
                      height: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              widget.iconData,
              size: 50,
              color: widget.color,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData iconData;
  final String url;

  SocialIcon({required this.iconData, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Icon(
          iconData,
          size: 40,
          color: Colors.blue, // Customize the icon color here
        ),
      ),
    );
  }
}
//  Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SocialIcon(
//                   iconData: FontAwesomeIcons.facebook,
//                   url: 'https://www.facebook.com/your-page',
//                 ),
//                 SocialIcon(
//                   iconData: FontAwesomeIcons.instagram,
//                   url: 'https://www.instagram.com/your-page',
//                 ),
//                 SocialIcon(
//                   iconData: FontAwesomeIcons.whatsapp,
//                   url: 'https://wa.me/your-phone-number',
//                 ),
//                 SocialIcon(
//                   iconData: FontAwesomeIcons.twitter,
//                   url: 'https://twitter.com/your-page',
//                 ),
//               ],
//             ),

// You'll need to import the url_launcher package to use _launchURL function

// Function to launch the given URL
void _launchURL(String url) async {
  try {
    await launch(url);
  } catch (e) {}
}
