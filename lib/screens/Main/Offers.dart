import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/Main/bookmarked.dart';
import 'package:job_finder/screens/Main/settings.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      );

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Palette.powderBlue,
        items: <Widget>[
          Icon(Icons.settings, size: 30),
          Icon(Icons.perm_identity, size: 30),
          Icon(Icons.favorite, size: 30)
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        height: 50.0,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, SettingsPage.route);
          } else if (index == 2) {
            Navigator.push(context, BookmarkedPage.route);
          }
        },
      ),
        backgroundColor: Palette.powderBlue,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 3 / 100,
              horizontal: screenWidth * 2 / 100),
          child: Column(children: [
            SizedBox(
              height: screenHeight * 6 / 100,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Row(
                children: [
                  SizedBox(width: screenWidth * 5 / 100),
                  Text(
                    'Hello, Ghazi ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Palette.navyBlue,
                    ),
                  ),
                ],
              )),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Row(
                children: [
                  SizedBox(width: screenWidth * 5 / 100),
                  Text(
                    'Find your dream job/internship',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.darkCornflowerBlue,
                    ),
                  ),
                ],
              )),
            ),
            SizedBox(
              height: screenHeight * 2 / 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 2 / 100,
                  horizontal: screenWidth * 2 / 100),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      height: screenHeight * 8 / 100,
                      width: screenWidth * 7 / 10,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: screenHeight * 2 / 100,
                            width: screenWidth * 4 / 100,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            height: screenHeight * 2 / 100,
                            width: screenWidth * 4 / 100,
                          ),
                          SizedBox(
                              height: screenHeight * 2 / 100,
                              width: screenWidth * 20 / 100,
                              child: TextFormField(
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Search',
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 2 / 100,
                    ),
                    Container(
                      height: screenHeight * 8 / 100,
                      width: screenWidth * 2 / 10,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: screenHeight * 2 / 100,
                            width: screenWidth * 7 / 100,
                          ),
                          Icon(
                            Icons.swap_horiz,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(children: [
                  SizedBox(
                    height: screenHeight * 1 / 100,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Row(
                      children: [
                        SizedBox(width: screenWidth * 3 / 100),
                        Text(
                          'Popular Jobs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Palette.navyBlue,
                          ),
                        ),
                        SizedBox(width: screenWidth * 45 / 100),
                        Text(
                          'see all',
                          style: TextStyle(
                            fontSize: 15,
                            color: Palette.navyBlue,
                          ),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(height: screenHeight * 1 / 100),
                  SizedBox(
                    height: screenHeight * 20 / 100,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            width: screenWidth * 40 / 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          50.0, 2.0, 50.0, 10.0),
                                      height: 25.0,
                                      child: Image.asset(
                                        'assets/Images/Apple_logo_hollow.svg.png',
                                      )),
                                  Text('UI/UX Designer'),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10, top: 5, right: 10, bottom: 5),
                                    height: screenHeight * 9 / 100,
                                    width: screenWidth * 10 / 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Column(children: [
                                        Text('Apple'),
                                        Text('Zurich Office'),
                                        Text('80-90k/year'),
                                      ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 2 / 100,
                          ),
                          Container(
                            height: screenHeight * 10 / 100,
                            width: screenWidth * 4 / 10,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          50.0, 3.0, 50.0, 5.0),
                                      height: 23.0,
                                      child: Image.asset(
                                        'assets/Images/google.png',
                                      )),
                                  Text(
                                    'Marketing Manager',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    height: screenHeight * 9 / 100,
                                    width: screenWidth * 10 / 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Column(children: [
                                        Text('Google'),
                                        Text('Dubai Office'),
                                        Text('100-150k/year'),
                                      ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 3 / 100,
                          ),
                          Container(
                            height: screenHeight * 10 / 100,
                            width: screenWidth * 4 / 10,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: FlatButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          50.0, 3.0, 50.0, 5.0),
                                      height: 20.0,
                                      child: Image.asset(
                                        'assets/Images/dell.png',
                                      )),
                                  Text('Software Engineer'),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10,
                                        top: 15,
                                        right: 10,
                                        bottom: 5),
                                    height: screenHeight * 9 / 100,
                                    width: screenWidth * 10 / 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Column(children: [
                                        Text('Dell'),
                                        Text('Belgium Office'),
                                        Text('100-140k/year'),
                                      ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 2 / 100,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: screenHeight * 2 / 100,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Row(
                      children: [
                        SizedBox(width: screenWidth * 1 / 100),
                        Text(
                          'Recent jobs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Palette.navyBlue,
                          ),
                        ),
                        SizedBox(width: screenWidth * 50 / 100),
                        Text(
                          'see all',
                          style: TextStyle(
                            fontSize: 15,
                            color: Palette.navyBlue,
                          ),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    //Recent jobs

                    height: screenHeight * 28 / 100,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 0),
                        height: screenHeight * 11 / 100,
                        width: screenWidth * 30 / 10,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: FlatButton(
                          onPressed: () {},
                          child: Row(children: [
                            Container(
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                                height: 40.0,
                                child: Image.asset(
                                  'assets/Images/spotify.png',
                                )),
                            SizedBox(width: screenWidth * 2 / 100),
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Column(children: [
                                Text(
                                  'Senior Web Developer',
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Spotify | £140 - 180 k/year',
                                  style: TextStyle(fontSize: 10.0),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(6.0),
                                      height: screenHeight * 2.5 / 100,
                                      width: screenWidth * 3 / 10,
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15.0, 2, 1, 2),
                                        child: Text(
                                          'Experience: 5 years',
                                          style: TextStyle(fontSize: 9.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(6.0),
                                      height: screenHeight * 2.5 / 100,
                                      width: screenWidth * 2 / 10,
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 2, 1, 2),
                                        child: Text(
                                          'Fulltime',
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 5),
                        height: screenHeight * 11 / 100,
                        width: screenWidth * 30 / 10,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: FlatButton(
                          onPressed: () {},
                          child: Row(children: [
                            Container(
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                                height: 40.0,
                                child: Image.asset(
                                  'assets/Images/fb.png',
                                )),
                            SizedBox(width: screenWidth * 2 / 100),
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Column(children: [
                                Text(
                                  'Data Analyst',
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Facebook | £200 - 220 k/year',
                                  style: TextStyle(fontSize: 10.0),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(6.0),
                                      height: screenHeight * 2.5 / 100,
                                      width: screenWidth * 3 / 10,
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15.0, 2, 1, 2),
                                        child: Text(
                                          'Experience: 2 years',
                                          style: TextStyle(fontSize: 9.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(6.0),
                                      height: screenHeight * 2.5 / 100,
                                      width: screenWidth * 2 / 10,
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 2, 1, 2),
                                        child: Text(
                                          'Fulltime',
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ]),
                        ),
                      ),
                    ]),
                  ),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
