import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/Main/bottom_nav.dart';
import 'package:job_finder/screens/auth/register.dart';
import 'package:job_finder/screens/auth/sign_in.dart';
import 'package:job_finder/screens/background_painter.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LitAuth.custom(
        errorNotification: const NotificationConfig(
          backgroundColor: Palette.navyBlue,
          icon: Icon(
            Icons.error_outline,
            color: Palette.burnt,
            size: 32,
          ),
        ),
        successNotification: const NotificationConfig(
          backgroundColor: Palette.navyBlue,
          icon: Icon(
            Icons.check,
            color: Colors.white,
            size: 32,
          ),
        ),
        onAuthSuccess: () {
          Navigator.of(context).pushReplacement(BottomNav.route);
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800),
                child: ValueListenableBuilder<bool>(
                    valueListenable: showSignInPage,
                    builder: (context, value, child) {
                      return PageTransitionSwitcher(
                        reverse: !value,
                        duration: Duration(milliseconds: 800),
                        transitionBuilder:
                            (child, animation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            fillColor: Colors.transparent,
                            child: child,
                          );
                        },
                        child: value
                            ? SignIn(
                                key: ValueKey('SignIn'),
                                onRegisterClicked: () {
                                  context.resetSignInForm();
                                  showSignInPage.value = false;
                                },
                              )
                            : Register(
                                key: ValueKey('Register'),
                                onSignInPressed: () {
                                  context.resetSignInForm();
                                  showSignInPage.value = true;
                                },
                              ),
                      );
                      // return
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
