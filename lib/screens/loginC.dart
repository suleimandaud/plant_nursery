import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:plant_nursery/screens/SignUpC.dart';
import 'package:plant_nursery/screens/home_screen.dart';
import 'package:plant_nursery/screens/main_screen.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({super.key});

  @override
  State<LoginTest> createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  TextEditingController _emailcontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();
  bool _obsecure = true;
  final _loginkey = GlobalKey<FormState>();
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  Future<void> _loginSave() async {
    final isValid = _loginkey.currentState!.validate();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim().toLowerCase(),
          password: _passwordcontroller.text.trim().toLowerCase(),
        );
        //session
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MainScreen()));
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        // GeneralMEthod.showErrorDialog(error: error.toString(), ctx: context);
        print('Eroor occured ${error}');
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: ListView(children: [
                Padding(
                    padding: EdgeInsets.only(left: 80, right: 80),
                    child: Image.asset("images/logo-removebg-preview.png")),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _loginkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.black)),
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains("@")) {
                            return 'invalid emial';
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _passwordcontroller,
                        decoration: InputDecoration(
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obsecure = !_obsecure;
                                });
                              },
                              child: Icon(
                                _obsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black)),
                        obscureText: !_obsecure,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'must containt at least 8 charecters';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _loginSave();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.green,
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Do not have an account?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: '   '),
                        ]),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignUp()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.green[900]),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
