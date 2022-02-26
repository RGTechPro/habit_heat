import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_heat/constants/size_config.dart';
import 'package:habit_heat/sccreens/log_in.dart';
import 'package:habit_heat/widgets/card.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:habit_heat/Provider/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_heat/services/auth_services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          title:const Center(
              child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Text(
              'TODO',
              style:
                  const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
            ),
          )),
          leading: Container(
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

            child: Lottie.asset("assets/lottie/profile.json"),
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
              padding: const EdgeInsets.only(right:15.0),
              child: PopupMenuButton(
                color: Colors.black,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                itemBuilder: (context) {
                  return List.generate(1, (index) {
                    return PopupMenuItem(
                      onTap: () {

                      },
                      //textStyle: GoogleFonts.openSans(fontSize: 12,color:ourWhite),
                      height: 20,
                      child: Container(
                          color: Colors.black,
                          height: 20,

                          child: Text("data"),
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
              flex:3,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
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
                      'Hello,John',
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 35,

                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
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

                    Center(
                      child: Row(
                        children: [
                          Text("Streak",style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),),
                          SvgPicture.asset("assets/icons/streak.svg"),
                          Text("5",style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat.yMMMMd('en_US').format(now),
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
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
                  child: PageView(
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
                      children: [
                        TaskCard(
                          profile: 'Personal',
                          icon: Icons.person,
                          color: [Color(0xfff6ac51), Color(0xfff65875)],
                        ),
                        TaskCard(
                          profile: 'Work',
                          icon: Icons.work,
                          color: [Color(0xff62aee9), Color(0xff5363e2)],
                        ),
                        TaskCard(
                          profile: 'Home',
                          icon: Icons.home,
                          color: [Color(0xff4cc1a9), Color(0xff378e7c)],
                        )
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
