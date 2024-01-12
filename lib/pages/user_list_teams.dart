import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_image/shimmer_image.dart';
import 'package:tpl/constants/tpl_text.dart';
import 'package:tpl/pages/update_team_page.dart';

class UserListClubs extends StatefulWidget {
  UserListClubs({Key? key}) : super(key: key);

  @override
  _ListClubsState createState() => _ListClubsState();
}

class _ListClubsState extends State<UserListClubs> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('teams').snapshots();

  // For Deleting User
  CollectionReference students = FirebaseFirestore.instance.collection('teams');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
      });
    });

    return files;
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
                columnWidths: {
                  // 0: FlexColumnWidth(0.25),
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(0.16),
                  2: FlexColumnWidth(0.16),
                  3: FlexColumnWidth(0.16),
                  4: FlexColumnWidth(0.16),
                  5: FlexColumnWidth(0.16),
                  6: FlexColumnWidth(0.25),
                },
              // border: TableBorder(bottom: BorderSide(color: Colors.grey.shade400), horizontalInside: BorderSide(color: Colors.grey.shade400)),
                children: [
                  TableRow(
                    children: [
                      // TableCell(
                      //   verticalAlignment: TableCellVerticalAlignment.middle,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 5),
                      //     child: Text("",
                      //         style: TextStyle(
                      //           fontSize: 15.0,
                      //           fontWeight: FontWeight.bold,
                      //         )),
                      //   ),
                      // ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: TPLText(
                            text: "Team",
                            fontColor: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
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
                    ],
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 5),
                        //   child: TableCell(
                        //     verticalAlignment: TableCellVerticalAlignment.middle,
                        //     child:  FutureBuilder(
                        //       future: _loadImages(),
                        //       builder: (context,
                        //           AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        //         if (snapshot.connectionState == ConnectionState.done) {
                        //           return ListView.builder(
                        //             shrinkWrap: true,
                        //             itemCount: snapshot.data?.length ?? 0,
                        //             itemBuilder: (context, index) {
                        //               final Map<String, dynamic> image = snapshot.data![index];
                        //
                        //               return Container(
                        //                 decoration: BoxDecoration(shape: BoxShape.circle),
                        //                 child: ProgressiveImage(
                        //                   baseColor: Colors.grey.shade500,
                        //                   highlightColor: Colors.grey.shade600,
                        //                   height: 10,
                        //                   width: 10,
                        //                   fit: BoxFit.fill,
                        //                   image: image['url'],
                        //                   imageError: "assets/images/nia.jpg",
                        //                 ),
                        //               );
                        //             },
                        //           );
                        //         }
                        //         return const Center(
                        //             child: SizedBox(height:10,width: 10,child: CircularProgressIndicator(strokeWidth: 1,))
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),

                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: TPLText(
                              text: storedocs[i]['club name'],
                              fontColor: Colors.black,
                              fontSize: 13,
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
