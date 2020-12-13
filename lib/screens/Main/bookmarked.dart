import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/Main/Offers.dart';
import 'package:job_finder/screens/Main/settings.dart';

class BookmarkedPage extends StatefulWidget {
  const BookmarkedPage({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const BookmarkedPage(),
      );

  @override
  _BookmarkedPageState createState() => _BookmarkedPageState();
}

class _BookmarkedPageState extends State<BookmarkedPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        backgroundColor: Palette.powderBlue,
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
          if (index == 1) {
            Navigator.push(context, MyHomePage.route);
          } else if (index == 0) {
            Navigator.push(context, SettingsPage.route);
          }
        },
      ),
      backgroundColor: Palette.powderBlue,
      body: new Center(
        child: new Text("Bookmark Page"),
      ),
    );
  }
}
