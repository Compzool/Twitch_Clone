import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/controllers/auth_controller.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/screens/auth/login_screen.dart';
import 'package:twitch_clone/screens/auth/signup_screen.dart';
import 'package:twitch_clone/screens/broadcast_screen.dart';
import 'package:twitch_clone/screens/home_screen.dart';
import 'package:twitch_clone/screens/welcome_screen.dart';
import 'package:twitch_clone/utils/colors.dart';
import 'package:twitch_clone/utils/constants.dart';
import 'package:twitch_clone/models/user.dart' as model;
import 'package:twitch_clone/widgets/loading_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBfeBO5jkmEtLOmay7CA5lluwuP_mXUPII",
            authDomain: "twitch-20cab.firebaseapp.com",
            projectId: "twitch-20cab",
            storageBucket: "twitch-20cab.appspot.com",
            messagingSenderId: "554636565729",
            appId: "1:554636565729:web:c2401f1fba0c437b4deba0"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twtich Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: primaryColor),
        ),
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: 'ios',
            ),
        primaryTextTheme: ThemeData.light().textTheme.apply(
              fontFamily: 'ios',
            ),
      ),
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      home: FutureBuilder(
          future: AuthMethods()
              .getCurrentUser(firebaseAuth.currentUser != null
                  ? firebaseAuth.currentUser!.uid
                  : null)
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(model.User.fromMap(value));
            }
            return value;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingIndicator();
            }
            if (snapshot.data != null) {
              return HomeScreen();
            }
            return WelcomeScreen();
          }),
    );
  }
}
