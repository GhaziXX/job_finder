import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/models/splash.dart';
import 'package:job_finder/screens/Main/splash_screen.dart';
import 'package:provider/provider.dart';

import 'package:job_finder/screens/Main/bottom_nav.dart';
import 'package:job_finder/screens/auth/auth.dart';

import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      return LitAuthState(
        authenticated: BottomNav(),
        unauthenticated: AuthScreen(),
      );
    } else {
      prefs.setBool('seen', true);
      return SplashView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ChangeNotifierProvider(
          create: (context) => SplashModel(),
          builder: (context, orientation) {
            return FutureBuilder(
              future: Future.wait([_initialization, checkFirstSeen()]),
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  return LitAuthInit(
                    authProviders: const AuthProviders(
                        emailAndPassword: true, // enabled by default
                        google: true),
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
                        home: snapshot.data[1]),
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

//return ChangeNotifierProvider(
//    create: (context) => SplashModel(),
//    child:
//       MaterialApp(debugShowCheckedModeBanner: false, home: SplashView()));
