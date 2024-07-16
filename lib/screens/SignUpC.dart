import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_nursery/screens/loginC.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _locationController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final _signUpkey = GlobalKey<FormState>();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _submitFormSignUp() async {
    final isValid = _signUpkey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim().toLowerCase(),
            password: _passwordController.text.trim().toLowerCase());
        final User? user = _auth.currentUser;
        final _uid = user!.uid;

        FirebaseFirestore.instance.collection('Users').doc(_uid).set({
          'id': _uid,
          'name': _nameController.text,
          'email': _emailController.text,
          'PhoneNumber': _phoneController.text,
          'Location': _locationController.text,
          'CreatedAt': Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        // GeneralMEthod.showErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  // Future addNewUser() async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'name': _nameController.text.trim(),
  //     'email': _emailController.text.trim(),
  //     'location': _locationController.text.trim(),
  //     'password': _passwordController.text.trim(),
  //     'phone': _phoneController.text.trim(),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Stack(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ListView(children: [
              Padding(
                  padding: EdgeInsets.only(left: 80, right: 80),
                  child: Image.asset("images/logo-removebg-preview.png")),
              Form(
                key: _signUpkey,
                child: Column(
                  children: [
                    Text(
                      'REGISTER HERE',
                      style: TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.black)),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name is required';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
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
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'please enter invalid email';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                // _obsecure = !_obsecure;
                              });
                            },
                            child: Icon(
                              Icons.visibility,
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
                      // obscureText: !_obsecure,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'must containt at least 8 charecters';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.black)),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter invalid email';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    _isLoading
                        ? Center(
                            child: Container(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : MaterialButton(
                            onPressed: () {
                              // _submitFormSignUp();
                              // addNewUser();
                              _submitFormSignUp();
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
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have An Account?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('  '),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginTest()));
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
