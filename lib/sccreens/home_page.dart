import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glass/glass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_heat/Provider/currentState.dart';
import 'package:habit_heat/Provider/weatherDart.dart';
import 'package:habit_heat/constants/size_config.dart';
import 'package:habit_heat/sccreens/add_activity.dart';
import 'package:habit_heat/sccreens/log_in.dart';
import 'package:habit_heat/sccreens/profile_screen.dart';
import 'package:habit_heat/widgets/card.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:habit_heat/Provider/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_heat/services/auth_services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Provider/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future? data;
  Future? data2;

  @override
  void initState() {
    WeatherProvider weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    data = weatherProvider.getLocationInformationUser();
    CurrentState _instance = Provider.of(context, listen: false);
    data2 = _instance.getUserInfo();
    super.initState();
  }

  final now = new DateTime.now();
  List<Color> GColors = [Color(0xfff6ac51), Color(0xfff65875)];
  @override
  final _url = 'https://rgtechpro.github.io/doIt_privacy_policy/';

  void _launchURL() async {
    try {
      await launch(_url, forceWebView: true);
    } catch (e) {
      final snackBar = SnackBar(
          duration: Duration(milliseconds: 1250), content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget build(BuildContext context) {
    WeatherProvider weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    print(_instance.currentUser.imgLink);
    print(_instance.currentUser.email);
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: GColors,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      child: Scaffold(
        // drawer: Drawer(
        //   child: Padding(
        //     padding: const EdgeInsets.all(50.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 15),
        //           child: GestureDetector(
        //             onTap: () {
        //               Provider.of<Auth>(context, listen: false).logout(context);
        //               Navigator.of(context).popUntil((route) => route.isFirst);
        //               Navigator.pushReplacement(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => const LogIn()));
        //             },
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Logout',
        //                   style: TextStyle(
        //                       fontFamily: 'Roboto',
        //                       fontSize: 20,
        //                       color: Colors.red),
        //                 ),
        //                 Icon(
        //                   Icons.logout,
        //                   color: Colors.red,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.symmetric(vertical: 15),
        //           child: GestureDetector(
        //             onTap: () {
        //               _launchURL();
        //             },
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Privacy Policy',
        //                   style: TextStyle(
        //                       fontFamily: 'Roboto',
        //                       fontSize: 20,
        //                       color: Colors.red),
        //                 ),
        //                 Icon(
        //                   Icons.privacy_tip,
        //                   color: Colors.red,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(
              child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Text(
              DateFormat.HOUR24_MINUTE_SECOND,
              style: const TextStyle(
                  fontFamily: 'Roboto', fontWeight: FontWeight.bold),
            ),
          )),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 10),
              width: 30,
              height: 30,
              // decoration: BoxDecoration(
              //   shape: BoxShape.circle,
              //   boxShadow: [
              //     BoxShadow(
              //         blurRadius: 12,
              //         color: Colors.black38,
              //         spreadRadius: 0)
              //   ],
              // ),

              child: _instance.currentUser.imgLink == null
                  ? Lottie.asset("assets/lottie/profile.json")
                  : CircleAvatar(
                      child: Image.network(_instance.currentUser.imgLink ?? ""),
                    ),
              // child: CircleAvatar(
              //     radius: 20,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(30),
              //       child: Image.asset(
              //         'images/avatar.jpg',
              //         //height: 20,
              //         //width: 20,
              //         //fit: BoxFit.fitWidth,
              //       ),
              //     )),
            ),
          ),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.all(11.0),
            //   child: IconButton(
            //     icon: Icon(Icons.search),
            //     onPressed: () {},
            //   ),
            // )

            // this is the drop down menu thing in the application that will be used to
            // select a particular item in the field
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: PopupMenuButton(
                color: Colors.black,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                itemBuilder: (context) {
                  return List.generate(
                      _instance.currentUser.habits?.length ?? 0, (index) {
                    return PopupMenuItem(
                      onTap: () {},
                      //textStyle: GoogleFonts.openSans(fontSize: 12,color:ourWhite),
                      height: 20,
                      child: Container(
                        color: Colors.black,
                        height: 20,
                        child: Text(
                          _instance.currentUser.habits?[index].name ?? "",
                          style: GoogleFonts.aladin(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Row(
                  children: [
                    FutureBuilder(
                        future: data2,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Container(
                                child: Text("starting"),
                              );
                            case ConnectionState.waiting:
                              // return Center(
                              //   child: Shimmer.fromColors(
                              //     highlightColor: Colors.white,
                              //     baseColor: Colors.grey[300] ?? Colors.grey,
                              //     period: Duration(milliseconds: 10),
                              //     child: Container(
                              //       height: 200,
                              //       width: 200,
                              //       decoration: BoxDecoration(
                              //         color: Colors.grey,
                              //         borderRadius: BorderRadius.circular(20),
                              //       ),
                              //     ),
                              //   ),
                              // );

                              return Lottie.asset("assets/lottie/loader.json");
                            case ConnectionState.done:
                              return Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     shape: BoxShape.circle,
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //           blurRadius: 12,
                                    //           color: Colors.black38,
                                    //           spreadRadius: 0)
                                    //     ],
                                    //   ),
                                    //   child: CircleAvatar(
                                    //       radius: 30,
                                    //       child: ClipRRect(
                                    //         borderRadius: BorderRadius.circular(30),
                                    //         child: Image.asset(
                                    //           'images/avatar.jpg',
                                    //           height: 60,
                                    //           width: 60,
                                    //           fit: BoxFit.fitWidth,
                                    //         ),
                                    //       )),
                                    // ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _instance.currentUser.name ?? "",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 35,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    // Text(
                                    //   'Looks like feel good.\nYou have some tasks to do today.',
                                    //   style: TextStyle(
                                    //       fontFamily: 'Roboto',
                                    //       color: Colors.white.withOpacity(.75),
                                    //       fontSize: 20),
                                    //   textAlign: TextAlign.center,
                                    //
                                    // ),
                                    Spacer(flex: 1),
                                    Text(
                                      DateFormat.yMMMMd('en_US').format(now),
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Streak",
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
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
                                          _instance.currentUser.streak.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    Spacer(flex: 1),
                                  ],
                                ),
                              );
                            default:
                              return Text('No data found');
                          }
                        }),
                    FutureBuilder(
                      future: data,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Container(
                              child: Text("starting"),
                            );
                          case ConnectionState.waiting:
                            // return Center(
                            //   child: Shimmer.fromColors(
                            //     highlightColor: Colors.white,
                            //     baseColor: Colors.grey[300] ?? Colors.grey,
                            //     period: Duration(milliseconds: 10),
                            //     child: Container(
                            //       height: 20,
                            //       width: 20,
                            //       decoration: BoxDecoration(
                            //         color: Colors.grey,
                            //         borderRadius: BorderRadius.circular(20),
                            //       ),
                            //     ),
                            //   ),
                            // );
                            return Container();
                          case ConnectionState.done:
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.1),
                                        offset: Offset(0, 1),
                                        spreadRadius: 10,
                                        blurRadius: 13),
                                  ],
                                  //color: Colors.red,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                  "${weatherProvider.tempData} C",
                                  style: GoogleFonts.openSans(
                                  fontSize: 20, color: Colors.white),
                                ),
                                ),
                              ).asGlass(),
                            );
                          default:
                            return const Text('No data found');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SizedBox(
                  height: SizeConfig.screenHeight! * 0.5,
                  child: Consumer<CurrentState>(

                      builder: (context,_,__) {

                    int length = _instance.currentUser.habits?.length ?? 0;
                    if (length != 0) {
                      length = length + 1;
                    } else {
                      length = 1;
                    }
                    return PageView.builder(
                      itemCount: length,
                      controller: PageController(viewportFraction: 0.75),
                      onPageChanged: (int i) {
                        setState(() {
                          if (i == 1) {
                            GColors = [Color(0xff62aee9), Color(0xff5363e2)];
                          } else if (i == 2) {
                            GColors = [Color(0xff4cc1a9), Color(0xff378e7c)];
                          } else {
                            GColors = [Color(0xfff6ac51), Color(0xfff65875)];
                          }
                        });
                      },
                      //shrinkWrap: true,
                      //  physics: PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (index < length - 1) {
                          print("inside level 1 if stattement");
                          print(index);
                          print(length - 1);
                          return TaskCard(
                            index: index,
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 12, top: 15, left: 2, bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                //
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddActivity()));
                              },
                              child: Container(
                                height: SizeConfig.screenHeight! * 0.46,
                                width: SizeConfig.screenWidth! * 0.7,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset.zero,
                                          spreadRadius: 0,
                                          blurRadius: 13),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(.01))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    Center(
                                      child: Text(
                                        "Add",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.black54,
                                            fontSize: 22),
                                      ),
                                    ),

                                    // Expanded(
                                    //   child: Row(
                                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //       children: [
                                    //         Padding(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           child: Container(
                                    //             decoration: BoxDecoration(
                                    //                 shape: BoxShape.circle,
                                    //                 border: Border.all(
                                    //                     color: Colors.grey.withOpacity(.15))),
                                    //             child: Padding(
                                    //               padding: const EdgeInsets.all(10),
                                    //               child: Icon(
                                    //                 icon,
                                    //                 color: color!.first,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: const EdgeInsets.all(8),
                                    //           child: Icon(
                                    //             Icons.more_vert,
                                    //             color: Colors.grey.withOpacity(0.5),
                                    //           ),
                                    //         ),
                                    //       ]),
                                    // ),
                                    // SizedBox(
                                    //   height: SizeConfig.screenHeight! * 0.22,
                                    // ),
                                    // Padding(
                                    //             padding: const EdgeInsets.symmetric(
                                    //                 horizontal: 8.0, vertical: 3),
                                    //             child: Text(
                                    //               '0 Task today',
                                    //               style: TextStyle(
                                    //                   fontFamily: 'Roboto',
                                    //                   color: Colors.black54,
                                    //                   fontSize: 17),
                                    //             ),
                                    //           ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                                    //   child: Text(
                                    //     profile!,
                                    //     style: TextStyle(
                                    //         fontFamily: 'Roboto',
                                    //         fontWeight: FontWeight.bold,
                                    //         color: Colors.black54,
                                    //         fontSize: 30),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: SizeConfig.screenHeight! * 0.020,
                                    // ),
                                    // LinearPercentIndicator(
                                    //   //  padding: EdgeInsets.only(right: 10),
                                    //   trailing: Text(
                                    //     '69%',
                                    //     style: TextStyle(
                                    //         fontFamily: 'Roboto', color: Colors.black54),
                                    //   ),
                                    //   percent: 0.69,
                                    //   lineHeight: 3,
                                    //   backgroundColor: Colors.grey.withOpacity(.2),
                                    //   linearGradient: LinearGradient(
                                    //       colors: color!,
                                    //       begin: Alignment.centerLeft,
                                    //       end: Alignment.centerRight),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
