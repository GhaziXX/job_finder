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

class Offers extends StatefulWidget {
  Offers({Key key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class FilterClass {
  String title;
  bool value;
  FilterClass(this.title, this.value);
  @override
  String toString() {
    return 'FilterClass{title: $title, value: $value}';
  }
}

Future<List<Company>> futurePopularOffer;
Future<List<Company>> futureRecentOffer;

class _OffersState extends State<Offers> {
  static String name = "";
  int present = 0;
  int perPage = 15;
  final originalItems = List<String>.generate(100, (i) => "Item $i");

  final myText = TextEditingController(); //Search text input
  final myLocation = TextEditingController(); //Location description
  final List<FilterClass> filterlist = List();
  bool pressAttention = false;
  var items = List<String>();
  @override
  void initState() {
    items.addAll(originalItems);
    setState(() {
      items.addAll(originalItems.getRange(present, present + perPage));
      present = present + perPage;
    });
    super.initState();
    futurePopularOffer = fetchOffer(tag: 'ruby', page: 0);
    futureRecentOffer =
        fetchOffer(tag: 'python', location: 'san francisco', fullTime: 'true');
  }

  void loadMore() {
    setState(() {
      if ((present + perPage) > originalItems.length) {
        items.addAll(originalItems.getRange(present, originalItems.length));
      } else {
        items.addAll(originalItems.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  bool checked = false;

  Widget build(BuildContext context) {
    final databaseReference =
        FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getName(databaseReference, uid);
    return Scaffold(
      backgroundColor: Palette.powderBlue,
      body: Container(
        margin: EdgeInsets.only(left: 18.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 32, top: 60, bottom: 3),
                child: Text(
                  "Welcome $name",
                  style: kPageTitleStyle,
                ),
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
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.search,
                              size: 25.0,
                              color: Colors.black,
                            ),
                            border: InputBorder.none,
                            hintText: "Search for job title",
                            hintStyle: kSubtitleStyle.copyWith(
                              color: Palette.navyBlue,
                            ),
                          ),
                        ),
                      ),
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
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(children: [
                                      SizedBox(height: 100),
                                      Text(
                                        'Filters',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      TextField(
                                        controller:
                                            myLocation, //to get the info in myText : myText.text

                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.home,
                                            size: 20.0,
                                            color: Colors.black,
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Location",
                                          hintStyle: kSubtitleStyle.copyWith(
                                            color: Palette.navyBlue,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Text('Fulltime Job'),
                                          SizedBox(width: 10),
                                          Checkbox(
                                            value: checked,
                                            onChanged: (bool value) {
                                              setState(() {
                                                checked = value;
                                                filterlist.add(FilterClass(
                                                    myLocation.text, value));
                                                print(filterlist.toString());
                                              });
                                            },
                                            activeColor: Colors.blueAccent,
                                          ),
                                        ],
                                      ),
                                    ]),
                                  );
                                });
                              });
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
                  "Popular Company",
                  style: kSectionTitleStyle,
                ),
                Spacer(),
                Container(
                  child: FlatButton(
                    child: Text(
                      "Show more",
                      style: kTitleStyle,
                    ),
                    onPressed: () {
                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => Column(children: <Widget>[
                                Expanded(
                                  child:
                                      NotificationListener<ScrollNotification>(
                                    onNotification:
                                        (ScrollNotification scrollInfo) {
                                      if (scrollInfo.metrics.pixels ==
                                          scrollInfo.metrics.maxScrollExtent) {
                                        loadMore();
                                      }
                                    },
                                    child: ListView.builder(
                                      itemCount:
                                          (present <= originalItems.length)
                                              ? items.length + 1
                                              : items.length,
                                      itemBuilder: (context, index) {
                                        return (index == items.length)
                                            ? Container(
                                                color: Colors.greenAccent,
                                              )
                                            : ListTile(
                                                title: Text('${items[index]}'),
                                              );
                                      },
                                    ),
                                  ),
                                ),
                              ]));
                    },
                  ),
                ),
              ]),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 190.0,
                child: FutureBuilder<List<Company>>(
                    future: futurePopularOffer,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
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
                                    ),
                                  ),
                                );
                              },
                              child: CompanyCard(company: company),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator(
                        strokeWidth: 1,
                      );
                    }),
              ),
              SizedBox(height: 35.0),
              Row(children: [
                Text(
                  "Recent Jobs",
                  style: kSectionTitleStyle,
                ),
                Spacer(),
                Text(
                  "Show more",
                  style: kTitleStyle,
                ),
              ]),
              FutureBuilder<List<Company>>(
                  future: futureRecentOffer,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          var recent = snapshot.data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetail(
                                    company: recent,
                                  ),
                                ),
                              );
                            },
                            child: RecentJobCard(company: recent),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator(
                      strokeWidth: 1,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void getName(CollectionReference f, String uid) async {
    f.get().then((QuerySnapshot snapshot) {
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
}
