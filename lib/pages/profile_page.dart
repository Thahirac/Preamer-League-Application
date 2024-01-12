import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tpl/constants/tpl_text.dart';
import 'package:tpl/pages/login_page.dart';
class ProfilePage extends StatefulWidget {
  final User? user;
  final String? name;
  final String? email;
  const ProfilePage({Key? key,this.user,this.email,this.name}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: TPLText(text:"Profile",fontColor: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,),
        centerTitle: true,

        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: IconButton(
              onPressed: () {
                showDialog(
                  builder: (ctxt) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(right: 190),
                        child: const TPLText(text: "Logout",fontColor: Colors.black, fontWeight: FontWeight.w900, fontSize: 17,),
                      ),

                      content: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: TPLText(text:"Are you sure want to logout?",fontColor: Colors.black, fontWeight: FontWeight.w300, fontSize: 15,),
                      ),

                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:

                              const TPLText(text: "No",fontColor: Colors.black, fontWeight: FontWeight.w900, fontSize: 15,),

                            ),
                            SizedBox(width: 5),
                            IconButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              icon: const TPLText(text: "Yes",fontColor: Colors.red, fontWeight: FontWeight.w900, fontSize: 15,),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ],
                    );
                  },
                  context: context,
                );
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],


      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: 50.0),

            Icon(Icons.account_circle,size: 200,color: Colors.grey.shade500,),

            TPLText(
              text: _currentUser?.displayName==null&&widget.name==null? ""  :   _currentUser?.displayName??widget.name,
              fontColor: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),


            SizedBox(height: 10.0),

            TPLText(
              text: _currentUser?.email==null&&widget.email==null? ""  : _currentUser?.email??widget.email,
              fontColor: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),

            SizedBox(height: 5.0),
            Divider(thickness: 1.5,color: Colors.grey.shade700,endIndent: 9,indent: 9,),



            // Add widgets for verifying email
            // and, signing out the user
          ],
        ),
      ),
    );
  }
}