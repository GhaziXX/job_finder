import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/config/SizeConfig.dart';
import 'package:job_finder/screens/Main/Off.dart';
import 'package:job_finder/screens/auth/auth.dart';
import 'package:job_finder/screens/Main/Offers.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return FutureBuilder(
              future: _initialization,
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  // Initialize Lit Firebase Auth. Needs to be called before
                  // `MaterialApp`, to ensure all of the child widget, even when
                  // navigating to a new route, has access to the Lit auth methods
                  return LitAuthInit(
                    authProviders: const AuthProviders(
                        emailAndPassword: true, // enabled by default
                        google: true,
                        twitter: true),
                    child: MaterialApp(
                      title: 'Jobby',
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        textTheme: GoogleFonts.muliTextTheme(),
                        accentColor: Palette.blueGreen,
                        appBarTheme: const AppBarTheme(
                          brightness: Brightness.dark,
                          color: Palette.blueGreen,
                        ),
                      ),
                      home: Off()//LitAuthState(
                        //authenticated: MyHomePage(),
                        //unauthenticated: AuthScreen(),
                      //),
                    ),
                  );
                }
                // Otherwise, show something while waiting for initialization to complete
                return Center(child: CircularProgressIndicator());
              },
            );
          },
        );
      },
    );
  }
}
