
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:job_finder/widgets/Tags.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => SettingsPage(),
  );

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); //
    }
  }

  //Location description

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final myName = TextEditingController();
  static String newName;

  @override
  Widget build(BuildContext context) {
    final databaseReference =
    FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});

    return new Scaffold(
      backgroundColor: Colors.white10,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Align(
          child: Column(
              children: [
                SizedBox(height: 200.0),
                FlatButton(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Container(
                                height : 300.0,
                                child: Column(children: [
                                  Text('Settings',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                    ),),
                                  SizedBox(height : 30),
                                  TextField(
                                    controller: myName,
                                    //to get the info in myText : myText.text

                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(

                                      border: InputBorder.none,
                                      hintText: "Enter your new name",
                                      hintStyle: kSubtitleStyle.copyWith(
                                        color: Palette.navyBlue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  RaisedButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        setState(() {
                                          newName = myName.text;
                                          setData(databaseReference, uid, newName);
                                        });
                                      })
                                ]),
                              ),
                            );
                          });
                        });
                  },

                  child: Row(children: [
                    Icon(
                      Icons.account_circle,
                    ),
                    SizedBox(width: 10.0),
                    Text("Account Settings",
                      style: TextStyle(
                        fontSize: 20.0,

                      ),
                    ),

                    SizedBox(width : 75.0),
                    Icon(
                      Icons.arrow_forward_ios,
                      size:20.0,
                    ),
                  ]),
                ),
                SizedBox(height:15),
                FlatButton(
                  onPressed: (){

                    showMaterialModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Tag(
                                              category: 'python',

                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Tag(category : 'python'),
                                          Tag(category : "JavaScript"),
                                          Tag(category : "Web development"),
                                          Tag(category : "Mobile development"),
                                          Tag(category : "Design"),




                                        ],
                                      ),
                                    ),
                                  ]
                              ),
                            );

                        });

                  },

                  child: Row(
                    children: [
                      Icon(
                        Icons.business_center,
                      ),

                      SizedBox(width : 10.0),
                      Text('Job Categories',
                        style : TextStyle(
                          fontSize: 20.0,
                        ),
                      ),

                      SizedBox(width : 95.0),
                      Icon(
                        Icons.arrow_forward_ios,
                        size:20.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height:15),

                FlatButton(

                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment_return,
                      ),
                      SizedBox(width : 10.0),
                      Text('Sign out',
                        style : TextStyle(
                          fontSize: 20.0,
                        ),),
                      SizedBox(width : 153.0),
                      Icon(
                        Icons.arrow_forward_ios,
                        size:20.0,
                      ),
                    ],
                  ),
                  onPressed: () {
                    context.signOut();
                    Navigator.of(context).push(AuthScreen.route);
                  },
                ),


              ]
          ),
        ),
      ),
    );
  }
}

void updateData(CollectionReference f, String id, String name) {
  try {
    f.doc(id).update({'name': name});
  } catch (e) {
    print(e.toString());
  }
}

void setData(CollectionReference f, String uid, String name) {
  f.get().then((QuerySnapshot snapshot) {
    List<QueryDocumentSnapshot> d = snapshot.docs;
    int l = snapshot.docs.length;
    for (var i = 0; i < l; i++) {
      if (d[i].data()["uid"].toString() == uid) {
        updateData(f, d[i].id, name);
        break;
      }
    }
  });
}