import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_finder/config/Palette.dart';

class SplashModel extends ChangeNotifier {
  int _index = 0;
  get index => _index;
  set index(value) {
    _index = value;
    notifyListeners();
  }

  bool _isHalfWay = false;
  get isHalfWay => _isHalfWay;
  set isHalfWay(value) {
    _isHalfWay = value;
    notifyListeners();
  }

  bool _isToggled = false;
  get isToggled => _isToggled;
  set isToggled(value) {
    _isToggled = value;
    notifyListeners();
  }

  void swapColors() {
    if (index == 0) {
      _backGroundColor = Palette.navyBlue;
      _foreGroundColor = Palette.darkCornflowerBlue;
    } else if (index == 1) {
      _backGroundColor = Palette.darkCornflowerBlue;
      _foreGroundColor = Palette.navyBlue;
    } else {
      _backGroundColor = Palette.navyBlue;
      _foreGroundColor = Palette.darkCornflowerBlue;
    }
    // if (_isToggled) {
    //   _backGroundColor = Palette.navyBlue;
    //   _foreGroundColor = Palette.darkCornflowerBlue;
    // } else {
    //   _backGroundColor = Palette.darkCornflowerBlue;
    //   _foreGroundColor = Palette.navyBlue;
    // }
    notifyListeners();
  }

  Color _backGroundColor = Palette.navyBlue;
  get backGroundColor => _backGroundColor;
  set backGroundColor(value) {
    _backGroundColor = value;
    notifyListeners();
  }

  Color _foreGroundColor = Palette.darkCornflowerBlue;
  get foreGroundColor => _foreGroundColor;
  set foreGroundColor(value) {
    _foreGroundColor = value;
    notifyListeners();
  }
}
