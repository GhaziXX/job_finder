import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/config/SplashConstants.dart';
import 'package:job_finder/models/splash.dart';
import 'package:job_finder/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:provider/provider.dart';

import 'bottom_nav.dart';

class AnimatedCircle extends AnimatedWidget {
  final Tween<double> tween;
  final Tween<double> horizontalTween;
  final Animation<double> animation;
  final Animation<double> horizontalAnimation;
  final double flip;
  final Color color;

  AnimatedCircle({
    Key key,
    @required this.animation,
    this.horizontalTween,
    this.horizontalAnimation,
    @required this.color,
    @required this.flip,
    @required this.tween,
  })  : assert(flip == 1 || flip == -1),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SplashModel>(context, listen: false);
    return Transform(
      alignment: FractionalOffset.centerLeft,
      transform: Matrix4.identity()
        ..scale(
          tween.evaluate(animation) * flip,
          tween.evaluate(animation),
        ),
      child: Transform(
        transform: Matrix4.identity()
          ..translate(
            horizontalTween != null
                ? horizontalTween.evaluate(horizontalAnimation)
                : 0.0,
          ),
        child: Container(
          width: SplashConstants.radius,
          height: SplashConstants.radius,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              SplashConstants.radius / 2.0 -
                  tween.evaluate(animation) / (SplashConstants.radius / 2.0),
            ),
          ),
          child: Icon(
              flip == 1
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left,
              color: Colors.white),
        ),
      ),
    );
  }
}

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation startAnimation;
  Animation endAnimation;
  Animation horizontalAnimation;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    animationController =
        AnimationController(duration: Duration(milliseconds: 750), vsync: this);

    startAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.000, 0.500, curve: Curves.easeInExpo),
    );

    endAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.500, 1.000, curve: Curves.easeOutExpo),
    );

    horizontalAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.750, 1.000, curve: Curves.easeInOutQuad),
    );

    animationController
      ..addStatusListener((status) {
        final model = Provider.of<SplashModel>(context, listen: false);
        if (status == AnimationStatus.completed) {
          model.swapColors();
          animationController.reset();
        }
      })
      ..addListener(() {
        final model = Provider.of<SplashModel>(context, listen: false);
        if (animationController.value > 0.5) {
          model.isHalfWay = true;
        } else {
          model.isHalfWay = false;
        }
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SplashModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:
          model.isHalfWay ? model.foreGroundColor : model.backGroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            color:
                model.isHalfWay ? model.foreGroundColor : model.backGroundColor,
            width: screenWidth / 2.0 - SplashConstants.radius / 2.0,
            height: double.infinity,
          ),
          Transform(
            transform: Matrix4.identity()
              ..translate(
                screenWidth / 2 - SplashConstants.radius / 2.0,
                screenHeight -
                    SplashConstants.radius -
                    SplashConstants.bottomPadding,
              ),
            child: GestureDetector(
              onTap: () {
                if (animationController.status != AnimationStatus.forward) {
                  model.isToggled = !model.isToggled;
                  model.index++;

                  if (model.index > 2) {
                    model.index = 0;
                  }
                  if (model.index == 0) {
                    Navigator.push(context, AuthScreen.route);
                  }
                  pageController.animateToPage(model.index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutQuad);
                  animationController.forward();
                }
              },
              child: Stack(
                children: <Widget>[
                  AnimatedCircle(
                    animation: startAnimation,
                    color: model.foreGroundColor,
                    flip: 1.0,
                    tween:
                        Tween<double>(begin: 1.0, end: SplashConstants.radius),
                  ),
                  AnimatedCircle(
                    animation: endAnimation,
                    color: model.backGroundColor,
                    flip: -1.0,
                    horizontalTween:
                        Tween<double>(begin: 0, end: -SplashConstants.radius),
                    horizontalAnimation: horizontalAnimation,
                    tween:
                        Tween<double>(begin: SplashConstants.radius, end: 1.0),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: PageView.builder(
              controller: pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                String text = "";
                if (index == 0) {
                  text = "Welcome To Jobby!";
                } else if (index == 1) {
                  text = "Jobby gets you job offers\nright into your hands";
                } else if (index == 2) {
                  text = "Get Started!";
                }
                return Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
