import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/models/compay.dart';

import 'package:job_finder/widgets/recent_job_card.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

// ignore: must_be_immutable
class BookmarkedPage extends StatefulWidget {
  List<Company> faves = new List();

  BookmarkedPage({Key key, this.faves}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => BookmarkedPage(),
      );

  @override
  _BookmarkedPageState createState() => _BookmarkedPageState();
}

class _BookmarkedPageState extends State<BookmarkedPage> {
  static List<String> books = new List();
  @override
  Widget build(BuildContext context) {
    final databaseReference =
        FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getBooks(databaseReference, uid);
    return new Scaffold(
      backgroundColor: Colors.white10,
      body: new Center(
        child: ListView.builder(
          itemCount: RecentJobCard.faves.length,
          itemBuilder: (context, index) {
            var recent = RecentJobCard.faves[index];

            return Column(children: [
              Container(
                child: RecentJobCard(company: recent),
              ),
            ]);
          },
        ),
      ),
    );
  }

  void getBooks(CollectionReference f, String uid) async {
    await f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      List<String> temp = new List();
      d.forEach((element) {
        Map<String, dynamic> da = element.data();
        if (da['uid'] == uid) {
          da['bookmarked'].forEach((element) {
            temp.add(element);
          });
        }
      });
      books = temp;
    });
  }
}
