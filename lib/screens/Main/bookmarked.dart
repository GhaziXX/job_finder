import 'package:flutter/material.dart';

class BookmarkedPage extends StatefulWidget {
  @override
  _BookmarkedPageState createState() => _BookmarkedPageState();
}

class _BookmarkedPageState extends State<BookmarkedPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Bookmark"),
      ),
      body: new Center(
        child: new Text("Bookmark Page"),
      ),
    );
  }
}
