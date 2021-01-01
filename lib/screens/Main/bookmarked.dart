import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';

import 'package:job_finder/widgets/recent_job_card.dart';

// ignore: must_be_immutable
class BookmarkedPage extends StatefulWidget {
  List<String> faves = List();

  BookmarkedPage({Key key,this.faves}) : super(key: key);

  static MaterialPageRoute get route =>
      MaterialPageRoute(
        builder: (context) => BookmarkedPage(),
      );

  @override
  _BookmarkedPageState createState() => _BookmarkedPageState();
}
class _BookmarkedPageState extends State<BookmarkedPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.faves);
    return new Scaffold(
      backgroundColor: Palette.powderBlue,
      body: new Center(
        child: ListView.builder(
          itemCount: RecentJobCard.faves.length,
          itemBuilder: (context, index) => Column(
              children:[ ListTile(
                title: Text(RecentJobCard.faves[index]),
              ),
              ]
          ),
        ),
      ),

    );
  }
}