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
                top: 10 * SizeConfig.heightMultiplier,
                left: 0.1 * SizeConfig.widthMultiplier),
            child: Column(
              children: [
                Text(
                  'Hi Ghazi,',
                  style: GoogleFonts.nunitoSans(
                      color: Palette.navyBlue,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      fontSize: 4 * SizeConfig.textMultiplier),
                ),
                SizedBox(
                  height: 0.3 * SizeConfig.heightMultiplier,
                ),
                Text(
                  'Find your Job',
                  style: GoogleFonts.nunitoSans(
                      color: Palette.navyBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: 2 * SizeConfig.textMultiplier),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(
            top: 2 * SizeConfig.heightMultiplier,
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
          height: 1 * SizeConfig.heightMultiplier,
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
                SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
                Container(
                    height: 23 * SizeConfig.heightMultiplier,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: _job(
                              "Design System Developer",
                              "google.png",
                              "Google LLC",
                              "Mountain View, California",
                              "United State"),
                        ),
                        SizedBox(
                          width: 4 * SizeConfig.widthMultiplier,
                        ),
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: _job("Visual Designer", "apple.png",
                              "Apple Inc.", "Cupertino", "United State"),
                        ),
                        SizedBox(
                          width: 4 * SizeConfig.widthMultiplier,
                        ),
                        _job("Design System", "spotify.png", "Spotify AB",
                            "Stockholm", "Sweden"),
                        SizedBox(
                          width: 5 * SizeConfig.widthMultiplier,
                        ),
                      ],
                    )),
                SizedBox(
                  width: 4 * SizeConfig.heightMultiplier,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4 * SizeConfig.heightMultiplier),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
          child: Row(
            children: [
              Text(
                "Recent Job",
                style: GoogleFonts.nunitoSans(
                    color: Palette.navyBlue,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 2.4 * SizeConfig.textMultiplier),
              ),
              Spacer(),
              Text(
                "Show All",
                style: GoogleFonts.nunitoSans(
                    color: Palette.navyBlue,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 1.8 * SizeConfig.textMultiplier),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
        Container(
            height: 18 * SizeConfig.heightMultiplier,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                _job_r("google.png", "Senior Web Developer",
                    "Google LLC, £180-140 / year", "5", "Full Time"),
                SizedBox(
                  height: 2 * SizeConfig.heightMultiplier,
                ),
                _job_r("apple.png", "Visual Designer",
                    "Apple Inc. £180-140 / year", "6", "Full Time"),
                SizedBox(
                  width: 2 * SizeConfig.heightMultiplier,
                ),
                _job_r("spotify.png", "Data Analyst", "Spotify AB", "2",
                    "Part Time"),
                SizedBox(
                  width: 3 * SizeConfig.heightMultiplier,
                ),
              ],
            )),
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

  _job_r(String logo, String offer, String des, String exp, String state) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
      height: 15 * SizeConfig.heightMultiplier,
      width: 20 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: FlatButton(
        onPressed: () {},
        child: Row(children: [
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
              height: 40.0,
              child: Image.asset(
                "assets/Images/$logo",
              )),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              Text(
                offer,
                style: GoogleFonts.nunitoSans(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    fontSize: 1.7 * SizeConfig.textMultiplier),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                des,
                style: GoogleFonts.nunitoSans(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 1.7 * SizeConfig.textMultiplier),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(12.0),
                    height: 18,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Palette.powderBlue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: FittedBox(
                      //padding: const EdgeInsets.fromLTRB(15.0, 2, 1, 2),
                      child: Text(
                        'Experience: $exp years',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    height: 18,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Palette.powderBlue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 2, 1, 2),
                      child: Text(
                        '$state',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ]),
      ),
    );
  }

  void openBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(top: 25 * SizeConfig.heightMultiplier),
              child: Container(
                height: 90 * SizeConfig.heightMultiplier,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3 * SizeConfig.heightMultiplier,
                          horizontal: 4 * SizeConfig.widthMultiplier),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 5 * SizeConfig.imageSizeMultiplier,
                          ),
                          Spacer(),
                          Icon(
                            Icons.file_upload,
                            color: Colors.black,
                            size: 6 * SizeConfig.imageSizeMultiplier,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(
                            "assets/Images/google.png",
                            height: 15 * SizeConfig.imageSizeMultiplier,
                            width: 15 * SizeConfig.imageSizeMultiplier,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    Center(
                      child: Text(
                        "Visual Designer",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 4 * SizeConfig.textMultiplier),
                      ),
                    ),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),
                    Center(
                      child: Text(
                        "Google LLC/Mountain View",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 1.7 * SizeConfig.textMultiplier),
                      ),
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 7 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3 * SizeConfig.widthMultiplier),
                            child: Center(
                              child: Text(
                                "Description",
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontSize: 2 * SizeConfig.textMultiplier),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 7 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3 * SizeConfig.widthMultiplier),
                            child: Center(
                              child: Text(
                                "Company",
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontSize: 2 * SizeConfig.textMultiplier),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 7 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3 * SizeConfig.widthMultiplier),
                            child: Center(
                              child: Text(
                                "Reviews",
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontSize: 2 * SizeConfig.textMultiplier),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4 * SizeConfig.widthMultiplier),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Minimum Qualifications",
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                fontSize: 2 * SizeConfig.textMultiplier),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 3.0,
                                  backgroundColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Text(
                                "Bachelor's degree in design or\nequivalent practical experience",
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontSize: 1.7 * SizeConfig.textMultiplier),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 3.0,
                                  backgroundColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Text(
                                "Experience designing across\nmultiple platforms",
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontSize: 1.7 * SizeConfig.textMultiplier),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 10 * SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(-3, -3),
                                blurRadius: 10.0)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4 * SizeConfig.widthMultiplier),
                        child: Row(
                          children: [
                            Container(
                              height: 7.5 * SizeConfig.heightMultiplier,
                              width: 15 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.greenAccent, width: 3.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.greenAccent,
                                  size: 7 * SizeConfig.imageSizeMultiplier,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2 * SizeConfig.widthMultiplier,
                            ),
                            Expanded(
                              child: Container(
                                height: 7.5 * SizeConfig.heightMultiplier,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Center(
                                  child: Text(
                                    "Apply Here",
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.5,
                                        fontSize:
                                            2 * SizeConfig.textMultiplier),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
