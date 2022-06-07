import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitch_clone/screens/auth/login_screen.dart';
import 'package:twitch_clone/screens/auth/signup_screen.dart';
import 'package:twitch_clone/utils/hexcolor.dart';
import 'package:twitch_clone/widgets/glassmorphism.dart';
import 'package:twitch_clone/widgets/responsive_widget/responsive_widget.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveWidget(
        child: Stack(
          children: [
            // SizedBox(
            //   width: double.infinity,
            //   height: double.infinity,
            //   child: Image.asset(
            //     "assets/images/twitch.jpg",
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurpleAccent,
                    HexColor('651FFF'),
                    HexColor('6D2AFF'),
                    HexColor('7C40FF'),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/twitch_logo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  Column(
                    children: [
                      Glassmorphism(
                        blur: 15,
                        opacity: 0.2,
                        radius: 15,
                        child: TextButton(
                          onPressed: () =>
                              // handle push to HomeScreen
                              Navigator.pushNamed(context, LoginScreen.routeName),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Glassmorphism(
                        blur: 15,
                        opacity: 0.2,
                        radius: 15,
                        child: TextButton(
                          onPressed: () =>
                              // handle push to HomeScreen
                              Navigator.pushNamed(
                                  context, SignUpScreen.routeName),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Center(
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 100,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
