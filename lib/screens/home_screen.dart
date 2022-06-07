import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/controllers/auth_controller.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/screens/welcome_screen.dart';
import 'package:twitch_clone/utils/colors.dart';
import 'package:twitch_clone/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              AuthMethods().logout();
              Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
            },
          ),
        ]),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: backgroundColor,
            selectedItemColor: buttonColor,
            unselectedItemColor: primaryColor,
            currentIndex: _page,
            unselectedFontSize: 12,
            onTap: onPageChange,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: "Following"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_rounded,
                  ),
                  label: "Go Live"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.copy,
                  ),
                  label: "Browse"),
            ]),
        body: pages[_page],
      ),
    );
  }
}
