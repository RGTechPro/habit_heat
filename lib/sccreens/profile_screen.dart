import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import '../Provider/weatherDart.dart';
import '../colorsOur.dart';
import '../textStyleOur.dart';
import '../widgets/heat_map.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  final TextEditingController _houseNo = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _pincode = TextEditingController();

  //TextEditingController selectedDate = TextEditingController();

  String gender = "female";

  DateTime selectedDate = DateTime.now();
  var d = 0;
  var m = 0;
  var y = 0;
  var ismale = false;
  var checkbox = [false, false, false];
  bool buttonNotActive = false;
  String buttonValue = "SAVE";

  @override
  void initState() {
    initialApiCalls();
    super.initState();
  }

  initialApiCalls() async {
    //await apiCall
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.yellow,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'My Profile',
          style: MyTextStyle.text3,
        ),
      ),
      // bottomNavigationBar: AbsorbPointer(
      //   absorbing: buttonNotActive,
      //   child: GestureDetector(
      //     child: Container(
      //       height: height * 0.08,
      //       color: MyColors.yellowish,
      //       child: Center(
      //         child: Text(
      //           buttonValue,
      //           style: TextStyle(
      //             fontSize: 16.0,
      //             fontWeight: FontWeight.w400,
      //             color: Colors.white,
      //             fontFamily: 'Roboto',
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            //padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
            child: FutureBuilder(
              future: Future.delayed(Duration(seconds: 2)),
              builder: (context, snap) {
                switch (snap.connectionState) {
                  case ConnectionState.none:
                    return Container(
                      child: Text("this is nothing"),
                    );
                  case ConnectionState.waiting:
                    return Container(
                        padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
                        height: height - 100,
                        child: Center(
                            child: Lottie.asset(
                          "assets/lottie/profileLoader.json",
                        )));
                  case ConnectionState.done:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 20, left: 45, right: 45),
                              height: 115,
                              width: 115,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: MyColors.yellowish),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20, left: 45, right: 45),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: MyColors.yellowish,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 15),
                        //       child: Text(
                        //         'USERNAME',
                        //         style: MyTextStyle.referEarnText,
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 7, bottom: 28),
                        //       child: TextField(
                        //         decoration: InputDecoration(
                        //           border: OutlineInputBorder(),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 45, right: 45),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'NAME',
                                  style: MyTextStyle.referEarnText,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 7, bottom: 28),
                                child: TextField(
                                  enabled: false,
                                  controller: _name,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: size.width,
                          height: 2,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        SizedBox(height: 10,),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, left: 25, right: 45),
                              child: Text(
                                "Activity",
                                style: GoogleFonts.abel(
                                    color: Colors.black, fontSize: 20),
                              ),
                            )),

                        ...List.generate(10, (index) {
                          return Container(
                            child: Text("This is activty ",
                                style: GoogleFonts.openSans(
                                    color: Colors.black, fontSize: 16)),
                          );
                        }),
                        SizedBox(height: 15,),

                        Container(
                          width: size.width,
                          height: 2,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
                          child: HeatMaps(
                            date: DateTime.now(),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 2,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Streak",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              "assets/icons/streak.svg",
                              height: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "5",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Container(
                          height: height * 0.08,
                          color: MyColors.yellowish,
                          child: Center(
                            child: Text(
                              "Compare",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 15),
                        //       child: Text('CHOOSE VECHICLE'),
                        //     ),
                        //     Padding(
                        //         padding:
                        //             const EdgeInsets.only(top: 13, bottom: 28, left: 25),
                        //         child: Column(
                        //           children: [
                        //             CheckBox(
                        //               pos: 0,
                        //               text: 'Bike',
                        //               update: _updateCheckbox,
                        //               boxStatus: checkbox,
                        //             ),
                        //             SizedBox(
                        //               height: 7,
                        //             ),
                        //             CheckBox(
                        //               pos: 1,
                        //               text: 'Car',
                        //               update: _updateCheckbox,
                        //               boxStatus: checkbox,
                        //             ),
                        //             SizedBox(
                        //               height: 7,
                        //             ),
                        //             CheckBox(
                        //               pos: 2,
                        //               text: 'Truck',
                        //               update: _updateCheckbox,
                        //               boxStatus: checkbox,
                        //             ),
                        //           ],
                        //         )),
                        //   ],
                        // ),
                      ],
                    );
                  default:
                    return Container();
                }
              },
            )),
      ),
    );
  }
}

// class CheckBox extends StatelessWidget {
//   CheckBox({this.update, this.pos, this.text, this.boxStatus});
//   var update, boxStatus;
//   int pos;
//   String text;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => update(pos),
//       child: Row(
//         children: [
//           Container(
//             height: 20,
//             width: 20,
//             decoration: BoxDecoration(
//               color: !boxStatus[pos] ? Colors.white : Colors.black,
//               border: Border.all(width: 1, color: Colors.grey),
//             ),
//           ),
//           SizedBox(
//             width: 13,
//           ),
//           Text(
//             '$text',
//             style: MyTextStyle.text3,
//           )
//         ],
//       ),
//     );
//   }
// }
