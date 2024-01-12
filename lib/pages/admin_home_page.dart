import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tpl/constants/tpl_text.dart';
import 'package:tpl/pages/add_team_page.dart';
import 'package:tpl/pages/admin_list_teams.dart';
import 'package:tpl/pages/profile_page.dart';

import 'logo_uploading page.dart';

class AdminHome extends StatefulWidget {
  final User? user;
  final String? name;
  final String? email;
  const AdminHome({Key? key,this.user,this.name,this.email}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Center(
                  child: Container(
                    child:  Image.asset(
                      "assets/images/logo.png",
                      height: 100.0,
                      width: 100.0,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.control_point,color: Colors.black,),
                title: Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: const TPLText(
                    text: "Add New Team",
                    fontColor: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Addteam(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.upload_file,color: Colors.black,),
                title: Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: const TPLText(text: ' Upload logos  ',
                    fontSize: 15,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogoUploadPage(),
                    ),
                  );
                },
              ),






            ],
          ),
        ),
        appBar: AppBar(
          title: TPLText(text:"TPL",fontColor: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,),
          centerTitle: true,
          backgroundColor: Colors.indigo.shade900,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
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
            )
          ],
        ),
        body: ListClubs(),
      ),
    );
  }
}
