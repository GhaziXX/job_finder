import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
Future <Company> futureFavouriteBooks;

class _BookmarkedPageState extends State<BookmarkedPage> {
   List<String> books = new List();

  @override
  void initState() {
    super.initState();
    final databaseReference =
    FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();

    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getBooks(databaseReference, uid);
    //futureFavouriteBooks = fetchOfferById(id:books[0]);
  }
  Widget build(BuildContext context) {
    final databaseReference =
    FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getBooks(databaseReference, uid);
    return Scaffold(
      backgroundColor: Colors.white10,
      body:Column(
        children: [
          FutureBuilder<Company>(
            future: fetchOfferById(id:books[0]),
            builder: (context, snapshot) {
              print(books[0]+"aaaaaasba");
              return StatefulBuilder(builder:
              (BuildContext context,
                  StateSetter setState){
                  if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 100,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var recent = snapshot.data;
                    return InkWell(
                      child: RecentJobCard(company: recent),
                    );
                  },
                );
              }
              else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      )));
            });}),
      ]),
    );
  }
    getBooks(CollectionReference f, String uid) async {
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