import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tpl/constants/tpl_text.dart';
import 'package:tpl/pages/update_team_page.dart';

class ListClubs extends StatefulWidget {
  ListClubs({Key? key}) : super(key: key);

  @override
  _ListClubsState createState() => _ListClubsState();
}

class _ListClubsState extends State<ListClubs> {
  final Stream<QuerySnapshot> studentsStream =
  FirebaseFirestore.instance.collection('teams').snapshots();

  // For Deleting User
  CollectionReference students =
  FirebaseFirestore.instance.collection('teams');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children:  const [
                SizedBox(
                  height: 420,
                ),
                Center(
                    child: CircularProgressIndicator(strokeWidth: 1,)
                ),
              ],
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Table(
                border:
                TableBorder(bottom: BorderSide(color: Colors.grey.shade400), horizontalInside: BorderSide(color: Colors.grey.shade400)),
                columnWidths: {
                  0: FlexColumnWidth(0.1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(0.16),
                  3: FlexColumnWidth(0.16),
                  4: FlexColumnWidth(0.16),
                  5: FlexColumnWidth(0.16),
                  6: FlexColumnWidth(0.25),
                  7: FlexColumnWidth(0.5),
                },
                // border: TableBorder.all(),
                // columnWidths: const <int, TableColumnWidth>{
                //   1: FixedColumnWidth(140),
                // },
                // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(

                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text("",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: TPLText(
                            text: "Team",
                            fontColor: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Center(
                            child: TPLText(
                              text: "P",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Center(
                            child: TPLText(
                              text: "W",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Center(
                            child: TPLText(
                              text: "D",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Center(
                            child: TPLText(
                              text: "L",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Center(
                            child: TPLText(
                              text: "GD",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Center(
                            child: TPLText(
                              text: "PTS",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),


                      TableCell(
                        child: Container(
                          child: Center(
                            child: TPLText(
                              text: "Edit",
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TPLText(
                              text: i.toString(),
                              fontColor: Colors.green,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: TPLText(
                              text: storedocs[i]['club name'],
                              fontColor: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: TPLText(
                              text: storedocs[i]['p'],
                              fontColor: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: TPLText(
                              text: storedocs[i]['w'],
                              fontColor: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: TPLText(
                              text: storedocs[i]['d'],
                              fontColor: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: TPLText(
                              text: storedocs[i]['l'],
                              fontColor: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                            child: TPLText(
                              text: storedocs[i]['gd'],
                              fontColor: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: TPLText(
                                  text: storedocs[i]['pts'],
                                  fontColor: Colors.black,
                                  fontSize: 13,
                                ),
                              )),
                        ),


                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  Updateteam(
                                          id: storedocs[i]['id']),
                                    ),
                                  )
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                  size: 15,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                {deleteUser(storedocs[i]['id'])},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
