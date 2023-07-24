import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilwalal_app/ChariyahDash.dart';
import 'package:hilwalal_app/donor.dart';

class Charity extends StatefulWidget {
  const Charity({super.key});

  @override
  State<Charity> createState() => _CharityState();
}

String searchText = '';

class _CharityState extends State<Charity> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Charities'),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Color.fromARGB(26, 187, 187, 187),
      body: Stack(
        children: [
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .35,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 149, 191, 245),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      // decoration: BoxDecoration(
                      //   color: Color(0xFFF2BEA1),
                      //   shape: BoxShape.circle,
                      // ),
                      //child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  Text(
                    "Charities You can Donate",
                    style: GoogleFonts.aBeeZee(fontSize: 30),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SearchBars(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        if (searchText.isEmpty ||
                            "MASJIDYADA"
                                .toLowerCase()
                                .contains(searchText.toLowerCase()))
                          GestureDetector(
                            child: CategoryCard(
                              title: "MASJIDYADA",
                              svgSrc: "Images/masjid1.jpg",
                              // press: () {},
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChariyahDash(
                                            Type: ' Masjid',
                                          )));
                            },
                          ),
                        if (searchText.isEmpty ||
                            "WADOOYINKA"
                                .toLowerCase()
                                .contains(searchText.toLowerCase()))
                          GestureDetector(
                            child: CategoryCard(
                              title: "WADOOYINKA",
                              svgSrc: "Images/wado.jpg",
                              // press: () {},
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChariyahDash(
                                            Type: ' Wado',
                                          )));
                            },
                          ),
                        if (searchText.isEmpty ||
                            "CEELASHA"
                                .toLowerCase()
                                .contains(searchText.toLowerCase()))
                          GestureDetector(
                            child: CategoryCard(
                              title: "CEELASHA",
                              svgSrc: "Images/masjid.jpg",
                              // press: () {},
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChariyahDash(
                                            Type: ' Ceel',
                                          )));
                            },
                          ),
                        if (searchText.isEmpty ||
                            "DUGSIYADA"
                                .toLowerCase()
                                .contains(searchText.toLowerCase()))
                          GestureDetector(
                            child: CategoryCard(
                              title: "DUGSIYADA",
                              svgSrc: "Images/dugsi.jpg",
                              // press: () {},
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChariyahDash(
                                            Type: ' Dugsi',
                                          )));
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
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

class SearchBars extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBars({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        // suffixIcon: Icon(Icons.search),
        // border: borde
      ),
    );
  }
}
