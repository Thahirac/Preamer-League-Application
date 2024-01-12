import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpl/constants/tpl_text.dart';
import 'package:tpl/pages/admin_home_page.dart';
import 'package:tpl/pages/registration_page.dart';
import 'package:tpl/pages/user_home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _showPassword = true;
  bool _isloading=false;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  final key = GlobalKey<FormState>();


   Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      Fluttertoast.showToast(msg: "Login Successfully!",backgroundColor: Colors.green,textColor: Colors.white);

      setState(() {
        _isloading=false;
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.',backgroundColor: Colors.amber,textColor: Colors.black);

        setState(() {
          _isloading=false;
        });

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided.',backgroundColor: Colors.amber,textColor: Colors.black);

        setState(() {
          _isloading=false;
        });

        print('Wrong password provided.');
      }
    } catch (e) {
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

    return Scaffold(
      body: Form(
        key: key,
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
                "Login",
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
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter your email id";
                  }
                  return null;
                },
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
                controller: passwordcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter your password";
                  }
                  return null;
                },
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
                  onPressed: () async{
                    if (key.currentState!.validate()) {

                      setState(() {
                        _isloading=true;
                      });

                          User? user = await signInUsingEmailPassword(
                            email: emailcontroller.text,
                            password: passwordcontroller.text, context: context,);

                          if (user != null) {

                            String?  userId =user.uid;
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('userId', userId);

                           if(emailcontroller.text== "admin@gmail.com" && passwordcontroller.text =="admin123"){

                             Navigator.pushReplacement(
                               context,
                               PageRouteBuilder(
                                 pageBuilder: (c, a1, a2) => AdminHome(user: user),
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
                           else{


                             Navigator.pushReplacement(
                               context,
                               PageRouteBuilder(
                                 pageBuilder: (c, a1, a2) => UserHome(user: user),
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


                          }

                      FocusScope.of(context).unfocus();

                    }
                    else {
                      Fluttertoast.showToast(msg: "Login failed",backgroundColor: Colors.red);
                    }
                  },
                  child: _isloading? const Padding(padding: EdgeInsets.all(10.0), child: SizedBox(
                      height: 15,
                      width: 10,
                      child: CircularProgressIndicator(strokeWidth: 1,color: Colors.white,)),): const
                  TPLText(
                    text: "Login",
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
                    text: "Don't Have an Account?",
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.black,
                  ),
                  SizedBox(width: size.width * 0.01),
                  InkWell(
                    onTap: () {


                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => RegisterPage(),
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
                      text:  "Sign up",
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.black,
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
