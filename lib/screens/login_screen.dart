import 'package:flutter/material.dart';
import 'package:plant_nursery/screens/home_screen.dart';
import 'package:plant_nursery/screens/signup_screen.dart';

import '../main.dart';
import '../widgets/reusable_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4, // Adjust this value to raise or lower the logo
                  child: Container(),
                ),
                LogoWidget("images/logo-removebg-preview.png"),
                Expanded(
                  flex: 6, // Adjust this value to raise or lower the logo
                  child: Container(),
                ),
                Text(
                  "PLANT NURSERY",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                LogInSignUpButton(context, true, () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                }),
                SizedBox(
                  height: 10,
                ),
                SignUpOption(),
                SizedBox(
                  height: 200,
                )
                // Add other widgets (e.g., TextFields, Buttons) below as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have Account",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupScreen()));
          },
          child: Text(" SIGN UP",
              style: TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
