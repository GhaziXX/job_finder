import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class Tag extends StatefulWidget {
  final String category;
  Tag({Key key, this.category}) : super(key: key);

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  bool pressAttention = false;
  static List<String> choices = List();

  @override
  Widget build(BuildContext context) {
    final databaseReference =
        FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});

    return RaisedButton(
      child: Text(widget.category),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: pressAttention ? Colors.grey : Colors.blue,
      onPressed: () => setState(() {
        pressAttention = !pressAttention;
        if (pressAttention == true) {
          choices.add(widget.category);
        }
        if (pressAttention == false) {
          choices.remove(widget.category);
        }
        getData(databaseReference, uid, choices);
        print(choices);
      }),
    );
  }

  void getData(CollectionReference f, String uid, List<String> tags) {
    f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      int l = snapshot.docs.length;

      for (var i = 0; i < l; i++) {
        if (d[i].data()['uid'] == uid) {
          updateData(f, d[i].id, tags);
          break;
        }
      }
    });
  }

  void updateData(CollectionReference f, String id, List<String> tags) {
    try {
      f.doc(id).update({'tags': tags.toSet().toList()});
    } catch (e) {
      print(e.toString());
    }
  }
}
