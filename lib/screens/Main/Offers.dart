import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/models/compay.dart';
import 'package:job_finder/views/job_details.dart';
import 'package:job_finder/widgets/company_card.dart';
import 'package:job_finder/widgets/recent_job_card.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_finder/screens/main/bottom_nav.dart';

class Offers extends StatefulWidget {
  Offers({Key key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

Future<List<Company>> futureTaggedOffer;
Future<List<Company>> futureRecentOffer;

class _OffersState extends State<Offers> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  static String name = "";
  static String stags = "";
  static String oneTimeTags = "";
  static String nameFromShared;
  TextEditingController myText; //Search text input
  TextEditingController myLocation;
  //Location description
  TextEditingController myDescription;
  final List filterList = List();
  bool pressAttention = false;
  var items = List<String>();
  bool checkedFull = false;
  bool checkedR = false;
  bool checkedInt = false;
  bool updated = false;


  static List<String> books = new List<String>();
  final databaseReference = FirebaseFirestore.instance.collection("users_data");
  String uid = "";
  @override

  void initState() {
    super.initState();
    final litUser = context.getSignedInUser();
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getTags(databaseReference, uid);

    //futureTaggedOffer = fetchOfferTagged(tag: oneTimeTags);
    futureRecentOffer = fetchOfferRecent();
    myText = TextEditingController();
    myLocation = TextEditingController();
    myDescription = TextEditingController(); //description
  }

  void getNameFromShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameFromShared = prefs.getString('name');
    prefs.setString('name', "None");
  }

  Future getBooks() async {
    List<String> temp = new List();
    await databaseReference.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      d.forEach((element) {
        Map<String, dynamic> da = element.data();
        if (da['uid'] == uid) {
          da['bookmarked'].forEach((element) {
            temp.add(element);
          });
        }
      });
    });
    books = temp;
    return books;
  }

  void getName(CollectionReference f, String uid) async {
    await f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      d.forEach((element) {
        Map<String, dynamic> da = element.data();
        if (da['uid'] == uid) {
          setState(() {
            name = da['name'].toString();
          });
        }
      });
    });
  }

  void getTags(CollectionReference f, String uid) async {
    await f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      String tag = "";
      d.forEach((element) {
        Map<String, dynamic> da = element.data();
        if (da['uid'] == uid) {
          da['tags'].forEach((element) {
            tag += element + " ";
          });
          stags = tag;
        }
      });
    });
  }
  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Widget build(BuildContext context) {
    getName(databaseReference, uid);
    getTags(databaseReference, uid);
    getNameFromShared();
    getBooks();
    if (nameFromShared != 'None' &&
        nameFromShared != null &&
        nameFromShared != "") name = nameFromShared;
    if (oneTimeTags != stags) {
      oneTimeTags = stags;
    }
    futureTaggedOffer = fetchOfferTagged(tag: oneTimeTags);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.only(left: 18.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 32, top: 60, bottom: 3),
                    child: Text(
                      "Welcome\n$name",
                      style: kPageTitleStyle,
                    ),
                  ),
                  IconButton(
                    icon:Icon(Icons.refresh),
                    color: Palette.navyBlue,
                    onPressed: (){
                      _deleteCacheDir();
                      setState(() {
                        Navigator.push(context, BottomNav.route );
                      });
                    })
                      ],
                      ),
                      SizedBox(height: 25.0),
                      Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: EdgeInsets.only(right: 18.0),
                      child: Row(
                      children: <Widget>[
                      Expanded(
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0
                      ),
                          ),
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            controller: myText,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search for an opportunity",
                              hintStyle: kSubtitleStyle.copyWith(
                                color: Palette.navyBlue,
                              ),
                            ),
                            onSubmitted: (String value) async {
                              await showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FutureBuilder<List<Company>>(
                                        future: fetchOfferSearch(
                                            tag: myText.text,
                                            location: myLocation.text,
                                            fullTime: checkedFull.toString()),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setState) {
                                              return SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20),
                                                          Text(
                                                              'Search result for : \n' +
                                                                  myText.text,
                                                              style:
                                                                  kSectionTitleStyle),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      ListView.builder(
                                                          itemCount: snapshot
                                                              .data.length,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            var recent =
                                                                snapshot.data[
                                                                    index];
                                                            return InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            JobDetail(
                                                                      company:
                                                                          recent,
                                                                      isBook: books
                                                                              .contains(recent.id)
                                                                          ? true
                                                                          : false,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child:
                                                                  RecentJobCard(
                                                                company: recent,
                                                                isBook: books.contains(
                                                                        recent
                                                                            .id)
                                                                    ? true
                                                                    : false,
                                                              ),
                                                            );
                                                          }),
                                                    ]),
                                              );
                                            });
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return Center(
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                  )));
                                        });
                                  });
                            },
                          )),
                    ),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      margin: EdgeInsets.only(left: 12.0),
                      decoration: BoxDecoration(
                        color: Palette.navyBlue,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: FlatButton(
                        //filter
                        onPressed: () {
                          showMaterialModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height:400.0,
                                  child : StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState)
                                      { return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 20.0),
                                                Text("Salary Range",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,),),
                                                RangeSlider(
                                                  values: _currentRangeValues,
                                                  min: 0,
                                                  max: 100,
                                                  divisions: 5,
                                                  labels: RangeLabels(
                                                    _currentRangeValues.start.round().toString(),
                                                    _currentRangeValues.end.round().toString(),
                                                  ),
                                                  onChanged: (
                                                      RangeValues values) {
                                                    setState(() {
                                                      _currentRangeValues = values;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 20.0),
                                                Text("Job Type" ,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,),),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: checkedFull,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          checkedFull = value;
                                                        });
                                                      },
                                                      activeColor: Colors.blueAccent,
                                                    ),
                                                    Text('Full-Time Job'),
                                                    SizedBox(width: 40),
                                                  ],
                                                ),
                                                Row(
                                                  children:[
                                                    Checkbox(
                                                      value: checkedR,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          checkedR = value;
                                                        });
                                                      },
                                                      activeColor: Colors.blueAccent,
                                                    ),
                                                    Text('Remote'),
                                                    SizedBox(width: 40),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: checkedInt,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          checkedInt = value;
                                                        });
                                                      },
                                                      activeColor: Colors.blueAccent,
                                                    ),
                                                    Text('Internship'),
                                                    SizedBox(width: 40),
                                                  ],
                                                ),
                                                SizedBox(height: 20.0),
                                                SwitchListTile(
                                                  activeColor: Palette.navyBlue,
                                                  contentPadding: const EdgeInsets.all(0),
                                                  title: Text("use my location"),
                                                  value: updated,
                                                  onChanged: (bool newValue) {
                                                    setState(() {
                                                      updated = newValue;
                                                      //  saveSwitchState2(newValue);
                                                    });
                                                  },
                                                ),
                                              ]),
                                        );
                                      }),
                                );
                              }
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.slidersH,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35.0),
              Row(children: [
                Text(
                  "For you",
                  style: kSectionTitleStyle,
                ),
                Spacer(),
                Container(
                  child: FlatButton(
                    child: Text("Load More"),
                    onPressed: () {
                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return FutureBuilder<List<Company>>(
                                future: futureTaggedOffer,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var recent = snapshot.data[index];
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        JobDetail(
                                                      company: recent,
                                                      isBook: books.contains(
                                                              recent.id)
                                                          ? true
                                                          : false,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: RecentJobCard(
                                                  company: recent,
                                                  isBook:
                                                      books.contains(recent.id)
                                                          ? true
                                                          : false),
                                            );
                                          });
                                    });
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return Center(
                                      child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                          )));
                                });
                          });
                    },
                  ),
                ),
              ]),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 190.0,
                child: FutureBuilder<List<Company>>(
                    future: futureTaggedOffer,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var company = snapshot.data[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobDetail(
                                      company: company,
                                      isBook: books.contains(company.id)
                                          ? true
                                          : false,
                                    ),
                                  ),
                                );
                              },
                              child: CompanyCard(
                                company: company,
                                isBook:
                                    books.contains(company.id) ? true : false,
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              )));
                    }),
              ),
              SizedBox(height: 35.0),
              Row(children: [
                Text(
                  "Recent Jobs",
                  style: kSectionTitleStyle,
                ),
                Spacer(),
                FlatButton(
                  child: Text("Load More"),
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder<List<Company>>(
                              future: futureRecentOffer,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var recent = snapshot.data[index];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      JobDetail(
                                                    company: recent,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: RecentJobCard(
                                                company: recent,
                                                isBook:
                                                    books.contains(recent.id)
                                                        ? true
                                                        : false),
                                          );
                                        });
                                  });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return Center(
                                    child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                        )));
                              });
                        });
                  },
                ),
              ]),
              FutureBuilder<List<Company>>(
                  future: futureRecentOffer,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var recent = snapshot.data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetail(
                                    company: recent,
                                    isBook: books.contains(recent.id)
                                        ? true
                                        : false,
                                  ),
                                ),
                              );
                            },
                            child: RecentJobCard(
                              company: recent,
                              isBook: books.contains(recent.id) ? true : false,
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            )));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
