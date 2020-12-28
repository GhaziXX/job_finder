import 'package:flutter/material.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/models/compay.dart';

class CompanyCard extends StatelessWidget {
  final Company company;
  CompanyCard({this.company});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.only(right: 15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(height:60,width:60, child: Image(image : NetworkImage(company.companyLogo))),
              Spacer(),
              Text(
                'Salary',
                style: kTitleStyle,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          FittedBox(
            child: Text(
              company.title,
              style: kTitleStyle,
            ),
          ),
          SizedBox(height: 15.0),
          FittedBox(
              child :RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: company.company,
                  style: kSubtitleStyle,
                ),
                TextSpan(
                  text: "  •  ",
                  style: kSubtitleStyle,
                ),
                TextSpan(
                  text: company.location,
                  style: kSubtitleStyle,
                ),
              ],
            ),
          )),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 10.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        company.time,
                        style: kSubtitleStyle.copyWith(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ]),
        ],
      ),
    );
  }
}
