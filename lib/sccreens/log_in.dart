import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_heat/constants/custom_text.dart';
import 'package:habit_heat/constants/size_config.dart';
import 'package:habit_heat/sccreens/home_page.dart';
import 'package:habit_heat/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  static String routeName = "/log_in";

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  List<Color> GColors = [Color(0xff426BBA), Color(0xff40afb9)];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: GColors,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/tododesign.png',
                width: 200,
              ),
              Text(
                'Do.it',
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(55)!,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.075,
                width: SizeConfig.screenWidth! * 0.8,
                child: !Provider.of<Auth>(context, listen: false).isLoading
                    ? ElevatedButton(
                        onPressed: () async {
                          try {

                                await Provider.of<Auth>(context, listen: false)
                                    .signInWithGoogle(context);

                            // Provider.of<Auth>(context, listen: false)
                            //     .setUser(googleUserCred.user);
//                            Provider.of<Auth>(context, listen: false).addUser();
                            if (Provider.of<Auth>(context, listen: false)
                                    .getUser() !=
                                null) {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                              final snackBar =
                                  const SnackBar(content: Text('Logged In!'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            setState(() {
                              Provider.of<Auth>(context, listen: false)
                                  .isLoading = false;
                            });
                          } catch (e) {
                            setState(() {
                              Provider.of<Auth>(context, listen: false)
                                  .isLoading = false;
                            });
                            ;
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/google-icon.svg',
                              width: 25,
                            ),
                            CustomText(
                              text: 'SignIn with Google',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ))
                    : const CircularProgressIndicator(
                        color: Colors.redAccent,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
