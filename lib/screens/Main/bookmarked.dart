import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

Future<Company> futureFavouriteBooks;

class _BookmarkedPageState extends State<BookmarkedPage> {
  static List<String> books = new List<String>();
  @override
  void initState() {
    super.initState();
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder<dynamic>(
                future: fetchOfferById(ids: books),
                builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: books.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var recent = snapshot.data[index];
                          return InkWell(
                            child: RecentJobCard(company: recent),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height* 0.45),
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              )),
                        ],
                      ),
                    );

                }),
          ]),
        ),
      ),
    );
  }

  getBooks(CollectionReference f, String uid) async {
    List<String> temp = new List();
    await f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      d.forEach((element) {
        Map<String, dynamic> da = element.data();
        if (da['uid'] == uid) {
          da['bookmarked'].forEach((element) {
            temp.add(element);
          });
        }
      });
    });
    books = temp;
  }
}
