import 'package:flutter/material.dart';
import 'package:plant_nursery/main.dart';
import 'package:plant_nursery/screens/home_screen.dart';

import '../widgets/reusable_widget.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(" SIGN UP",
              style: TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold)),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(children: <Widget>[
                  Expanded(
                    flex: 4, // Adjust this value to raise or lower the logo
                    child: Container(),
                  ),
                  LogoWidget("images/logo-removebg-preview.png"),
                  Expanded(
                    flex: 6, // Adjust this value to raise or lower the logo
                    child: Container(),
                  ),
                  reusableTextField("Enter Username", Icons.person_outline,
                      false, _usernameTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Your Email", Icons.email_outlined,
                      false, _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  LogInSignUpButton(context, false, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }),
                  SizedBox(
                    height: 200,
                  ),
                ]),
              ),
            )));
  }
}
