import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/models/compay.dart';
import 'package:job_finder/screens/Main/bookmarked.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';



// ignore: must_be_immutable
class RecentJobCard extends StatefulWidget {
  final Company company;
  Color couleur;
  static List<Company> faves = List();
  static Future<List<Company>> faveBooks = List() as Future<List<Company>>;
  static List<String> identifier = List();
  RecentJobCard({this.company,this.couleur});


  @override
  _RecentJobCardState createState() => _RecentJobCardState();
}

class _RecentJobCardState extends State<RecentJobCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final databaseReference =
    FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});

    return Card(

      child: StatefulBuilder(
          builder: (context, setState) {
            return Card(
              color: Colors.white,
              elevation: 0.0,
              margin: EdgeInsets.only(right: 18.0, top: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(

                leading: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image(
                        image: NetworkImage(widget.company.companyLogo))),
                title: FittedBox(
                    child: Text(widget.company.title, style: kTitleStyle)),
                subtitle: FittedBox(
                  child: Text(
                    "${widget.company.company} • ${widget.company.time}",
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.favorite),
                    color: isPressed ? Colors.red : null,

                    onPressed:  () {

                      setState(() {
                        isPressed = !isPressed;


                        if (isPressed == true) {
                          widget.couleur = Colors.red;

                          RecentJobCard.faves.add(widget.company);
                          RecentJobCard.identifier.add(widget.company.id);
                        }
                        if (isPressed == false) {
                          widget.couleur = Colors.grey;

                          RecentJobCard.faves.remove(widget.company);

                          RecentJobCard.identifier.remove(widget.company.id);
                        }

                        getData(
                            databaseReference, uid, RecentJobCard.identifier);
                        print(RecentJobCard.faves);
                      });
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookmarkedPage(
                                    faves: RecentJobCard.faves,
                                  ),
                            ),
                          );
                        },
                      );
                    }),
                isThreeLine: true,
              ),
            );

          }
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

  void updateData(CollectionReference f, String id, List<String> tags) {
    try {
      f.doc(id).update({'bookmarked': tags.toSet().toList()});
    } catch (e) {
      print(e.toString());
    }
  }
}
