import 'package:flutter/material.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/models/compay.dart';

class HowToTab extends StatelessWidget {
  final Company company;
  HowToTab({this.company});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Text(
            "How to Apply",
            style: kTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.0),
          Text(
            company.howTo,
            style: kSubtitleStyle.copyWith(
              fontWeight: FontWeight.w300,
              height: 1.5,
              color: Color(0xFF5B5B5B),
            ),
          ),
        ],
      ),
    );
  }
}
