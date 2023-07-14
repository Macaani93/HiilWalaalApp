// import 'package:flutter/material.dart';
// import 'package:hilwalal_app/Api/Sessions.dart';

// class ProfilePage extends StatelessWidget {
//   TextEditingController FullName = TextEditingController(text: GetFullName());
//   TextEditingController Phone = TextEditingController(text: GetPhone());
//   TextEditingController Address = TextEditingController(text: GetAddress());

//   Widget textfield({@required hintText}) {
//     return Material(
//       elevation: 4,
//       shadowColor: Colors.blue,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(
//               letterSpacing: 2,
//               color: Colors.black54,
//               fontWeight: FontWeight.bold,
//             ),
//             fillColor: Colors.white30,
//             filled: true,
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide.none)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 height: 450,
//                 width: double.infinity,
//                 margin: EdgeInsets.symmetric(horizontal: 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: FullName,
//                       decoration: InputDecoration(
//                         hintText: 'FullName',
//                       ),
//                     ),
//                     TextField(
//                       controller: Phone,
//                       decoration: InputDecoration(
//                         hintText: 'Phone',
//                       ),
//                     ),
//                     TextField(
//                       controller: Address,
//                       decoration: InputDecoration(
//                         hintText: 'Address',
//                       ),
//                     ),

//                     // textfield(
//                     //   hintText: 'Confirm password',
//                     // ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           CustomPaint(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//             ),
//             painter: HeaderCurvedContainer(),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Text(
//                   "Profile",
//                   style: TextStyle(
//                     fontSize: 35,
//                     letterSpacing: 1.5,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 width: MediaQuery.of(context).size.width / 2,
//                 height: MediaQuery.of(context).size.width / 2,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 5),
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage('Images/profile.png'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Color.fromARGB(255, 24, 147, 236);
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hilwalal_app/Api/Sessions.dart';

class ProfilePage extends StatelessWidget {
  TextEditingController fullName = TextEditingController(text: GetFullName());
  TextEditingController phone = TextEditingController(text: GetPhone());
  TextEditingController address = TextEditingController(text: GetAddress());

  Widget textfield({@required hintText}) {
    return SingleChildScrollView(
      child: Material(
        elevation: 4,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                letterSpacing: 2,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              fillColor: Colors.white30,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                height: 250,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Delete My Account',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 40),
                      primary: Color.fromARGB(255, 255, 0, 0),
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 300,
              //   width: double.infinity,
              //   margin: EdgeInsets.symmetric(horizontal: 10),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Text(
              //         UserFullName + ' | ' + Address + ' | ' + Phone,
              //         style: TextStyle(
              //             // height: 500,
              //             color: Color.fromARGB(255, 0, 0, 0),
              //             fontSize: 17,
              //             // fontStyle: FontStyle.italic,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('Images/profile.png'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                // width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,

                child: Column(
                  children: [
                    // Text(
                    //   UserFullName + ' | ' + Address + ' | ' + Phone,
                    //   style: TextStyle(
                    //       // height: 500,
                    //       color: Color.fromARGB(255, 0, 0, 0),
                    //       fontSize: 17,
                    //       // fontStyle: FontStyle.italic,
                    //       fontWeight: FontWeight.bold),
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                    // textfield(
                    //   hintText: 'haye',
                    // )
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 15, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(
                                  FontAwesomeIcons.user,
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Text(
                                  fullName.text,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(
                                  FontAwesomeIcons.locationDot,
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Text(
                                  address.text,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(
                                  FontAwesomeIcons.phone,
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Text(
                                  phone.text,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromARGB(255, 24, 147, 236);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
