import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpl/pages/admin_home_page.dart';
import 'package:tpl/pages/login_page.dart';
import 'package:tpl/pages/user_home_page.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  String? finalUserId;
  String? finalUsername;
  String? finalUseremail;


  Future getValidationData() async {
    final SharedPreferences preference = await SharedPreferences.getInstance();
    var obtainedUseId = preference.getString('userId');
    var obtainedUsername = preference.getString('username');
    var obtainedUseremail = preference.getString('useremail');
    setState(() {
      finalUserId = obtainedUseId;
      finalUsername = obtainedUsername;
      finalUseremail = obtainedUseremail;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValidationData().whenComplete(() async {
      Timer(
        Duration(seconds: 3),
            () =>
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) =>
                finalUserId == null
                    ? LoginScreen()
                    : finalUserId=="CqOoy3mHgdOjrO0DCjB4w71bS8H2"? AdminHome(name:finalUsername.toString(),email: finalUseremail.toString(),) :  UserHome(name:finalUsername.toString(),email: finalUseremail.toString(),),
                transitionsBuilder: (context, animation, secondaryAnimation,
                    child) {
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
            ),

      );
    });
  }

    @override
    Widget build(BuildContext context) {
      // Size size = MediaQuery.of(context).size;
      return Scaffold(
        body: Center(
          child: Image.asset(
            "assets/images/logo.png",
            height: 200.0,
            width: 200.0,
          ),
        ),
      );
    }
  }
