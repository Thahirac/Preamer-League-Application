import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tpl/constants/tpl_text.dart';

import 'logo_uploading page.dart';

class Addteam extends StatefulWidget {
  Addteam({Key? key}) : super(key: key);

  @override
  _AddteamState createState() => _AddteamState();
}

class _AddteamState extends State<Addteam> {
  final _formKey = GlobalKey<FormState>();

  var clubname = "";
  var p = "";
  var w = "";
  var d = "";
  var l = "";
  var gd = "";
  var pts = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final clubnameController = TextEditingController();
  final pController = TextEditingController();
  final wController = TextEditingController();
  final dController = TextEditingController();
  final lController = TextEditingController();
  final gdController = TextEditingController();
  final ptsController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    clubnameController.dispose();
    pController.dispose();
    wController.dispose();
    dController.dispose();
    lController.dispose();
    gdController.dispose();
    ptsController.dispose();
    super.dispose();
  }

  clearText() {
    clubnameController.clear();
    pController.clear();
    wController.clear();
    dController.clear();
    lController.clear();
    gdController.clear();
    ptsController.clear();
  }

  // Adding Student
  CollectionReference teams = FirebaseFirestore.instance.collection('teams');

  Future<void> addUser() {
    return teams
        .add({
          'club name': clubname,
          'd': d,
          'gd': gd,
          'l': l,
          'p': p,
          'pts': pts,
          'w': w
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add teams: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TPLText(
          text:  "Add New Team"
        ),

        centerTitle: true,
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                height: 45,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Club Name',
                    labelStyle: TextStyle(fontSize: 15.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: clubnameController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Played',
                    labelStyle: TextStyle(fontSize: 15.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: pController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Win',
                    labelStyle: TextStyle(fontSize: 15.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: wController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Draw',
                    labelStyle: TextStyle(fontSize: 15.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: dController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Lost',
                    labelStyle: TextStyle(fontSize: 15.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: lController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Goal Diffrence',
                    labelStyle: TextStyle(fontSize: 15.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: gdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter goal diffrence count';
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Points',
                    labelStyle: TextStyle(fontSize: 15.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: ptsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter points';
                    }
                    return null;
                  },
                ),
              ),


              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            clubname = clubnameController.text;
                            p = pController.text;
                            w = wController.text;
                            d = dController.text;
                            l = lController.text;
                            gd = gdController.text;
                            pts = ptsController.text;
                            addUser();
                            clearText();

                            Fluttertoast.showToast(
                                msg: "New team added Successfully!",
                                backgroundColor: Colors.green);

                            Navigator.pop(context);
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "New team added failed",
                              backgroundColor: Colors.red);
                        }
                      },
                      child:
                      TPLText(text:  'Register',fontSize: 15,),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade500),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child:
                      TPLText(text: ' Reset  ',fontSize: 15,),
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
