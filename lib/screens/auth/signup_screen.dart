import 'package:flutter/material.dart';
import 'package:twitch_clone/controllers/auth_controller.dart';
import 'package:twitch_clone/screens/home_screen.dart';
import 'package:twitch_clone/widgets/custom_button.dart';
import 'package:twitch_clone/widgets/custom_textfield.dart';
import 'package:twitch_clone/widgets/loading_indicator.dart';
import 'package:twitch_clone/widgets/responsive_widget/responsive_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _userNameController = TextEditingController();
  AuthMethods _authMethods = AuthMethods();

  bool _isLoading = false;
  
   @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          centerTitle: true,
        ),
        body: _isLoading ? LoadingIndicator():ResponsiveWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomTextField(
                      controller: _emailController,
                      text: "Enter Your Email",
                      icon: Icons.email_outlined),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    text: "Enter Your Password",
                    icon: Icons.lock_clock_outlined,
                    isObscure: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Username",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomTextField(
                      controller: _userNameController,
                      text: "Enter Your GamerTag!",
                      icon: Icons.lock_clock_outlined),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Sign Up", pressed: () => signUpUser(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUpUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    bool isSigned = await _authMethods.signUpUser(
        context,
        _emailController.text.trim(),
        _userNameController.text.trim(),
        _passwordController.text.trim(),);

        setState(() {
          _isLoading = false;
        
        });
    if (isSigned) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }
}
