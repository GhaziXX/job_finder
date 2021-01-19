import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/Main/Offers.dart';
import 'package:job_finder/screens/Main/bookmarked.dart';
import 'package:job_finder/screens/Main/settings_new.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const BottomNav(),
      );

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<StatefulWidget> _widgetOptions = [
    SettingsOnePage(),
    Offers(),
    BookmarkedPage(),
  ];
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    final databaseReference =
        FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    String name = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    litUser.when((user) => name = user.displayName,
        empty: () {}, initializing: () {});
    getData(databaseReference, uid, name);
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeInOut,
          onItemSelected: (index) => setState(() => _selectedIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.perm_identity),
                title: Text("Profile"),
                activeColor: Palette.darkCornflowerBlue,
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: Icon(Icons.explore),
                title: Text("Offers"),
                activeColor: Palette.starCommandBlue,
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite),
                title: Text("Favorite"),
                activeColor: Palette.burnt,
                textAlign: TextAlign.center)
          ],
        ));
  }

  void getData(CollectionReference f, String uid, String name) {
    f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      int l = snapshot.docs.length;
      for (var i = 0; i < l; i++) {
        if (d[i].data()["uid"] == "") {
          updateData(f, d[i].id, uid);
          break;
        }
      }
    });
  }

  void updateData(CollectionReference f, String id, String uid) {
    try {
      f.doc(id).update({'uid': uid});
    } catch (e) {
      print(e.toString());
    }
  }
}
