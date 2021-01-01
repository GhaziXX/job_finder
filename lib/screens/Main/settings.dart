import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
      backgroundColor: Palette.powderBlue,
      body: Column(
        children: [
          SizedBox(height: 50.0),
          Row(children: [
            Icon(
              Icons.account_circle,
            ),
            SizedBox(width: 5.0),
            RaisedButton(
              child: Text("Modify your profile"),
              onPressed: () {
                showMaterialModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
                            TextField(
                              controller: myName,
                              //to get the info in myText : myText.text

                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.home,
                                  size: 20.0,
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                                hintText: "Enter your new name",
                                hintStyle: kSubtitleStyle.copyWith(
                                  color: Palette.navyBlue,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            RaisedButton(
                                child: Text('Submit'),
                                onPressed: () {
                                  setState(() {
                                    newName = myName.text;
                                    setData(databaseReference, uid, newName);
                                  });
                                })
                          ]),
                        );
                      });
                    });
              },
            ),
          ]),
          RaisedButton(
            onPressed: () {
              context.signOut();
              Navigator.of(context).push(AuthScreen.route);
            },
            child: const Text('Sign out'),
          ),
        ],
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
