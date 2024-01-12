import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tpl/constants/tpl_text.dart';

class Updateteam extends StatefulWidget {
  final String id;
  Updateteam({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateteamState createState() => _UpdateteamState();
}

class _UpdateteamState extends State<Updateteam> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference teams =
  FirebaseFirestore.instance.collection('teams');






  Future<void> updateUser(id,clubname,d,gd,l,p,pts,w) {
    return teams
        .doc(id)
        .update({'club name': clubname, 'd': d, 'gd': gd,'l':l,'p':p,'pts':pts,'w':w})
        .then((value) => print("Team Updated"))
        .catchError((error) => print("Failed to update team: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TPLText(
            text: "Update Team"
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('teams')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children:  const [
                    SizedBox(
                      height: 380,
                    ),
                    Center(
                        child: CircularProgressIndicator(strokeWidth: 1,)
                    ),
                  ],
                );
              }
              var data = snapshot.data!.data();

              var clubname = data!['club name'];
              var d = data['d'];
              var gd = data['gd'];
              var l = data['l'];
              var p = data['p'];
              var pts = data['pts'];
              var w = data['w'];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: clubname,
                        autofocus: false,
                        onChanged: (value) => clubname = value,
                        decoration: InputDecoration(
                          labelText: 'Club Name',
                          labelStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Club Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: p,
                        autofocus: false,
                        onChanged: (value) => p = value,
                        decoration: InputDecoration(
                          labelText: 'Played',
                          labelStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter played count';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: w,
                        autofocus: false,
                        onChanged: (value) => w = value,
                        decoration: InputDecoration(
                          labelText: 'Win',
                          labelStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter win count';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: d,
                        autofocus: false,
                        onChanged: (value) => d = value,
                        decoration: InputDecoration(
                          labelText: 'Draw',
                          labelStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter draw count';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: l,
                        autofocus: false,
                        onChanged: (value) => l = value,
                        decoration: InputDecoration(
                          labelText: 'Lost',
                          labelStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter lost count';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: gd,
                        autofocus: false,
                        onChanged: (value) => gd = value,
                        decoration: InputDecoration(
                          labelText: 'Goal Diffrence',
                          labelStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter goal diffrence';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: pts,
                        autofocus: false,
                        onChanged: (value) => pts = value,
                        decoration: InputDecoration(
                          labelText: 'Points',
                          labelStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter points';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 15,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                updateUser(widget.id,clubname,d,gd,l,p,pts,w);

                                Fluttertoast.showToast(msg: "Update Successfully!",backgroundColor: Colors.green);

                                Navigator.pop(context);
                              }
                              else {
                                Fluttertoast.showToast(msg: "Update failed",backgroundColor: Colors.red);
                              }
                            },
                            child:
                            TPLText(text:    ' Update   ',fontSize: 15,),
                            style:ElevatedButton.styleFrom(
                                primary: Colors.green.shade600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
