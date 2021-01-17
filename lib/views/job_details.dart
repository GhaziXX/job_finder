import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/models/compay.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'company_tab.dart';
import 'description_tab.dart';
import 'howto_tab.dart';

class JobDetail extends StatefulWidget {
  final Company company;
  bool isBook = false;

  JobDetail({this.company, this.isBook});

  @override
  _JobDetailState createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  static List<String> identifier = List();

  void getOldData(CollectionReference f, String uid) async {
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
      identifier = temp;
    });
  }

  void getData(CollectionReference f, String uid, List<String> hearts) {
    f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      int l = snapshot.docs.length;

      for (var i = 0; i < l; i++) {
        if (d[i].data()['uid'] == uid) {
          updateData(f, d[i].id, hearts);
          break;
        }
      }
    });
  }

  void updateData(CollectionReference f, String id, List<String> tags) {
    try {
      f.doc(id).update({'bookmarked': tags.toSet().toList()});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseReference =
        FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getOldData(databaseReference, uid);
    return Scaffold(
      backgroundColor: Palette.powderBlue,
      appBar: AppBar(
        backgroundColor: Palette.powderBlue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.company.company,
          style: kTitleStyle,
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Container(
          width: double.infinity,
          // margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 250.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image(
                              image: NetworkImage(widget.company.companyLogo))),
                    ),
                    SizedBox(height: 20.0),
                    FittedBox(
                      child: Text(
                        widget.company.title,
                        style: kTitleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border:
                              Border.all(color: Colors.black.withOpacity(.5)),
                        ),
                        child: Text(
                          widget.company.time,
                          style: kSubtitleStyle,
                        ),
                      ),
                    ]),
                    SizedBox(height: 25.0),
                    Material(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: Colors.black.withOpacity(.2),
                        ),
                      ),
                      // borderRadius: BorderRadius.circular(12.0),
                      child: TabBar(
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: Palette.darkCornflowerBlue,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        tabs: [
                          Tab(text: "Description"),
                          Tab(text: "Company"),
                          Tab(text: "How to Apply")
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: TabBarView(
                  children: [
                    DescriptionTab(company: widget.company),
                    CompanyTab(company: widget.company),
                    HowToTab(company: widget.company)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          padding: EdgeInsets.only(left: 18.0, bottom: 25.0, right: 18.0),
          // margin: EdgeInsets.only(bottom: 25.0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(.5)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  color: widget.isBook ? Colors.red : Colors.grey,
                  onPressed: () {
                    setState(() {
                      widget.isBook = !widget.isBook;
                    });

                    if (widget.isBook == true) {
                      identifier.add(widget.company.id);
                    }
                    if (widget.isBook == false) {
                      identifier.remove(widget.company.id);
                    }
                    getData(databaseReference, uid, identifier);
                  },
                ),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: SizedBox(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      launchURL(widget.company.offerURL);
                    },
                    color: Palette.darkCornflowerBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      "Apply for Job",
                      style: kTitleStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
