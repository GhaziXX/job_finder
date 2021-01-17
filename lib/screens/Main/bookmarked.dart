import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:job_finder/models/compay.dart';
import 'package:job_finder/views/job_details.dart';

import 'package:job_finder/widgets/recent_job_card.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

// ignore: must_be_immutable
class BookmarkedPage extends StatefulWidget {
  BookmarkedPage({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => BookmarkedPage(),
      );

  @override
  _BookmarkedPageState createState() => _BookmarkedPageState();
}

Future<Company> futureFavouriteBooks;

class _BookmarkedPageState extends State<BookmarkedPage> {
  static List<String> books = new List<String>();
  final databaseReference = FirebaseFirestore.instance.collection("users_data");

  String uid = "";
  @override
  void initState() {
    final litUser = context.getSignedInUser();
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    super.initState();
    getBooks();
  }

  Widget build(BuildContext context) {
    getBooks();
    //test(books.last);
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Container(
        margin: EdgeInsets.only(left: 18.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            FutureBuilder<dynamic>(
                future: getAllBooks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: books.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        var recent = snapshot.data[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobDetail(
                                  company: recent,
                                  isBook: true,
                                ),
                              ),
                            );
                          },
                          child: RecentJobCard(
                            company: recent,
                            isBook: true,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.45),
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

  Future getAllBooks() async {
    //print(books.length);
    await getBooks();
    return fetchOfferById(ids: books);
  }

  Future getBooks() async {
    List<String> temp = new List();
    await databaseReference.get().then((QuerySnapshot snapshot) {
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
    return books;
  }
}
