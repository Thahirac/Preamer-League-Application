import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tpl/constants/tpl_text.dart';
import 'package:tpl/pages/add_team_page.dart';
import 'package:tpl/pages/admin_list_teams.dart';
import 'package:tpl/pages/profile_page.dart';
import 'package:tpl/pages/user_list_teams.dart';

class UserHome extends StatefulWidget {
  final User? user;
  final String? name;
  final String? email;
  const UserHome({Key? key,this.user,this.email,this.name}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  DateTime? pre_backpress = DateTime.now();
  bool _isSendingVerification = false;
  bool _isSigningOut = false;
  User? _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final timegap = DateTime.now().difference(pre_backpress!);

        final cantExit = timegap >= Duration(seconds: 2);

        pre_backpress = DateTime.now();

        if(cantExit){

          Fluttertoast.showToast(
              msg: "Press again to exit",
              backgroundColor: Colors.amber,
              textColor: Colors.black,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              fontSize: 16.0
          );
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: TPLText(text:"TPL",fontColor: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade900,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(user: widget.user,email:widget.email,name: widget.name,),
                    ),
                  );
                  // do something
                },
              ),
            )
          ],
        ),
        body: UserListClubs(),
      ),
    );
  }
}
