import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';

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
      backgroundColor: Palette.powderBlue,
      body: new Center(
        child: new Text("Bookmark Page"),
      ),
    );
  }
}
