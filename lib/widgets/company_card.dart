import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/models/compay.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

// ignore: must_be_immutable
class CompanyCard extends StatelessWidget {
  final Company company;
  bool isBook = false;
  static List<String> identifier = List();
  CompanyCard({this.company, this.isBook});
  @override
  Widget build(BuildContext context) {
    final databaseReference =
        FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getOldData(databaseReference, uid);
    return Container(
      width: 280.0,
      margin: EdgeInsets.only(right: 15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                  height: 60,
                  width: 60,
                  child: Image(image: NetworkImage(company.companyLogo))),
              Spacer(),
              IconButton(
                icon: Icon(Icons.favorite),
                color: isBook ? Colors.red : Colors.grey,
                onPressed: () {
                  isBook = !isBook;
                  if (isBook == true) {
                    identifier.add(company.id);
                  }
                  if (isBook == false) {
                    identifier.remove(company.id);
                  }
                  getData(databaseReference, uid, identifier);
                },
              ),
            ],
          ),
          SizedBox(height: 15.0),
          FittedBox(
            child: Text(
              company.title,
              style: kTitleStyle,
            ),
          ),
          SizedBox(height: 15.0),
          FittedBox(
              child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: company.company,
                  style: kSubtitleStyle,
                ),
                TextSpan(
                  text: "  •  ",
                  style: kSubtitleStyle,
                ),
                TextSpan(
                  text: company.location,
                  style: kSubtitleStyle,
                ),
              ],
            ),
          )),
          SizedBox(height: 15.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              child: FittedBox(
                child: Text(
                  company.time,
                  style: kSubtitleStyle.copyWith(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
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

  void updateData(CollectionReference f, String id, List<String> tags) {
    try {
      f.doc(id).update({'bookmarked': tags.toSet().toList()});
    } catch (e) {
      print(e.toString());
    }
  }
}
