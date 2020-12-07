import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/screens/Main/bookmarked.dart';
import 'package:job_finder/screens/Main/settings.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import '../auth/auth.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const OfferScreen(),
      );

  @override
  Widget build(BuildContext context) {
    int _index = 0;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.settings, size: 30),
          Icon(Icons.perm_identity, size: 30),
          Icon(Icons.favorite, size: 30)
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        height: 50.0,
        onTap: (index) {
          _index = index;
        },
      ),
      appBar: AppBar(
        title: const Text('Offers'),
      ),
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: RaisedButton(
          onPressed: () {
            context.signOut();
            Navigator.of(context).push(AuthScreen.route);
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
