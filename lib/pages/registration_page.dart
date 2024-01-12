
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpl/auth/validator.dart';
import 'package:tpl/constants/tpl_text.dart';
import 'package:tpl/pages/admin_home_page.dart';
import 'package:tpl/pages/login_page.dart';
import 'package:tpl/pages/user_home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _showPassword = true;

  bool _isloading=false;

  Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;

      Fluttertoast.showToast(msg: "Registration Successfully!",backgroundColor: Colors.green);

      setState(() {
        _isloading=false;
      });

    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.",backgroundColor: Colors.amber,textColor: Colors.black);

        setState(() {
          _isloading=false;
        });

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.",backgroundColor: Colors.amber,textColor: Colors.black);
        setState(() {
          _isloading=false;
        });

        print('The account already exists for that email.');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.red,textColor: Colors.white);

      setState(() {
        _isloading=false;
      });

      print(e);
    }
    return user;
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: Form(
          key: _registerFormKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/images/logo1.png",
                    height: 80,
                    width: 160,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              //Username or email
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _nameTextController,
                  focusNode: _focusName,
                  validator: (value) => Validator.validateName(
                    name: value!,
                  ),


                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _emailTextController,
                  focusNode: _focusEmail,
                  validator: (value) => Validator.validateEmail(
                    email: value!,
                  ),
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),

              //Passsword
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _passwordTextController,
                  focusNode: _focusPassword,
                  validator: (value) => Validator.validatePassword(
                    password: value!,
                  ),
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),

              SizedBox(height: size.height * 0.01),
              //login button
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo.shade900,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: ()async {
                      if (_registerFormKey.currentState!.validate()) {

                        setState(() {
                          _isloading=true;
                        });

                          User? user = await registerUsingEmailPassword(
                            name: _nameTextController.text,
                            email: _emailTextController.text,
                            password:
                            _passwordTextController.text,
                          );


                          if (user != null) {

                            String?  username =user.displayName;
                            String?  useremail =user.email;
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('username',  username.toString());
                            prefs.setString('useremail', useremail.toString());


                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => LoginScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  var begin = Offset(1.0, 0.0);
                                  var end = Offset.zero;
                                  var tween = Tween(begin: begin, end: end);
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                                transitionDuration: Duration(milliseconds: 500),
                              ),
                            );


                          }


                        FocusScope.of(context).unfocus();


                      }
                      else {
                        Fluttertoast.showToast(msg: "Registration failed",backgroundColor: Colors.red);
                      }
                    },
                    child:  _isloading? const Padding(padding: EdgeInsets.all(10.0), child: SizedBox(
                        height: 15,
                        width: 10,
                        child: CircularProgressIndicator(strokeWidth: 1,color: Colors.white,)),): const
                    TPLText(
                      text: "Sign Up",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const
                    TPLText(
                      text:  "Already have an account?",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      fontColor: Colors.black,
                    ),
                    SizedBox(width: size.width * 0.01),
                    InkWell(
                      onTap: () {

                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => LoginScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              var begin = Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var tween = Tween(begin: begin, end: end);
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 500),
                          ),
                        );

                      },
                      child: const
                      TPLText(
                        text:  "Login",
                        fontWeight: FontWeight.bold,
                        fontColor: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }



}