import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      );

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Palette.powderBlue,
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
