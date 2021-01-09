import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const ApplicationPage(),
      );

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white10,
      body: new Center(
        child: new Text("Applications Page"),
      ),
    );
  }
}
