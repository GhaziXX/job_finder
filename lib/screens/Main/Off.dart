import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/config/SizeConfig.dart';

class Off extends StatefulWidget {
  const Off({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const Off(),
      );

  @override
  _OffState createState() => _OffState();
}

class _OffState extends State<Off> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
            padding: EdgeInsets.only(
                top: 15 * SizeConfig.heightMultiplier,
                left: 0.1 * SizeConfig.widthMultiplier),
            child: Text(
              'Hi Ghazi,\nFind your Job/Internship',
              style: GoogleFonts.nunitoSans(
                  color: Palette.navyBlue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  fontSize: 4 * SizeConfig.textMultiplier),
            )),
        Padding(
          padding: EdgeInsets.only(
            top: 4 * SizeConfig.heightMultiplier,
            left: 5 * SizeConfig.widthMultiplier,
            right: 5 * SizeConfig.widthMultiplier,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3 * SizeConfig.widthMultiplier,
                        vertical: 2 * SizeConfig.heightMultiplier,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 5 * SizeConfig.imageSizeMultiplier,
                          ),
                          SizedBox(
                            width: 1.5 * SizeConfig.widthMultiplier,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: search,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.blue,
                            style: GoogleFonts.nunitoSans(
                                color: Palette.navyBlue,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 1.6 * SizeConfig.textMultiplier),
                            decoration: InputDecoration.collapsed(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    fontSize: 1.7 * SizeConfig.textMultiplier,
                                    color: Colors.grey)),
                          ))
                        ],
                      ),
                    )),
              ),
              SizedBox(
                width: 2 * SizeConfig.widthMultiplier,
              ),
              Container(
                width: 22.5 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.05)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.sort,
                    color: Colors.black,
                    size: 6 * SizeConfig.imageSizeMultiplier,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 2 * SizeConfig.heightMultiplier,
              left: 5 * SizeConfig.widthMultiplier),
          child: Row(
            children: [
              _category("Design"),
              SizedBox(
                width: 2 * SizeConfig.widthMultiplier,
              ),
              _category("Programming"),
              SizedBox(
                width: 2 * SizeConfig.widthMultiplier,
              ),
              _category("Marketing"),
            ],
          ),
        ),
        SizedBox(
          height: 7 * SizeConfig.heightMultiplier,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(40.0)),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5 * SizeConfig.widthMultiplier,
              vertical: 2 * SizeConfig.heightMultiplier,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Popular Job",
                      style: GoogleFonts.nunitoSans(
                          color: Palette.navyBlue,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          fontSize: 2.4 * SizeConfig.textMultiplier),
                    ),
                    Spacer(),
                    Text(
                      "show all",
                      style: GoogleFonts.nunitoSans(
                          color: Palette.navyBlue,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 1.8 * SizeConfig.textMultiplier),
                    )
                  ],
                ),
                SizedBox(height: 4 * SizeConfig.heightMultiplier),
                Container(
                    height: 23 * SizeConfig.heightMultiplier,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _job(
                            "Design System Developer",
                            "google.png",
                            "Google LLC",
                            "Mountain View, California",
                            "United State"),
                        SizedBox(
                          width: 4 * SizeConfig.widthMultiplier,
                        ),
                        _job("Visual Designer", "apple.png", "Apple Inc.",
                            "Cupertino", "United State"),
                        SizedBox(
                          width: 4 * SizeConfig.widthMultiplier,
                        ),
                        _job("Design System", "spotify.png", "Spotify AB",
                            "Stockholm", "Sweden"),
                        SizedBox(
                          width: 5 * SizeConfig.widthMultiplier,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }

  _category(String category) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: GoogleFonts.nunitoSans(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                fontSize: 1.6 * SizeConfig.textMultiplier),
          ),
        ));
  }

  _job(String job, String logo, String company, String state, String country) {
    return Container(
      height: 23 * SizeConfig.heightMultiplier,
      width: 65 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      "assets/Images/$logo",
                      height: 5 * SizeConfig.imageSizeMultiplier,
                      width: 5 * SizeConfig.imageSizeMultiplier,
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 6 * SizeConfig.imageSizeMultiplier,
                )
              ],
            ),
            SizedBox(
              height: 1 * SizeConfig.heightMultiplier,
            ),
            Text(
              company,
              style: GoogleFonts.nunitoSans(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  fontSize: 1.7 * SizeConfig.textMultiplier),
            ),
            SizedBox(
              height: 0.5 * SizeConfig.heightMultiplier,
            ),
            Text(
              job,
              style: GoogleFonts.nunitoSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  fontSize: 1.7 * SizeConfig.textMultiplier),
            ),
            SizedBox(
              height: 0.5 * SizeConfig.heightMultiplier,
            ),
            Text(
              state,
              style: GoogleFonts.nunitoSans(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  fontSize: 1.7 * SizeConfig.textMultiplier),
            ),
            Text(
              country,
              style: GoogleFonts.nunitoSans(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  fontSize: 1.7 * SizeConfig.textMultiplier),
            ),
          ],
        ),
      ),
    );
  }
}
