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
Future<List<Company>> futurePopularOffer;
Future<List<Company>> futureRecentOffer;
Future<List<Company>> futureSearchOffer;

class _OffersState extends State<Offers> {

  static String name = "";
  TextEditingController myText;//Search text input
  TextEditingController myLocation;
  //Location description
  TextEditingController myDescription;

  final  List filterList = List();
  bool pressAttention = false;
  var items = List<String>();
  bool checked = false;
  @override
  void initState(){
    super.initState();
    futurePopularOffer= fetchOffer(tag:'ruby',page: 0);
    futureRecentOffer = fetchOffer();
    myText = TextEditingController();
    myLocation = TextEditingController();
    myDescription = TextEditingController(); //description

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
  Widget build(BuildContext context) {
    final databaseReference = FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => dname = user.displayName, empty: () {}, initializing: () {});
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
                child: Text("Welcome $name", style: kPageTitleStyle,),
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
                          controller: myText,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for an opportunity",
                            hintStyle: kSubtitleStyle.copyWith(color: Palette.navyBlue,),
                          ),
                          onSubmitted: (String value) async {
                            await showMaterialModalBottomSheet(
                              context: context,
                                builder: (BuildContext context) {
                                  return FutureBuilder <List<Company>>(
                                      future:fetchOffer(tag:myText.text,location: myLocation.text,fullTime: checked.toString()),
                                      builder: (context, snapshot)  {
                                        if (snapshot.hasData) {
                                          return StatefulBuilder(
                                              builder: (BuildContext context, StateSetter setState){
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 30,),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 20),
                                                          Text('Search result for : \n'+myText.text,style: kSectionTitleStyle),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10,),
                                                      ListView.builder(
                                                        itemCount: snapshot.data.length,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        physics: ScrollPhysics(),
                                                        itemBuilder: (context, index) {
                                                          var recent = snapshot.data[index];
                                                          return InkWell(
                                                            onTap: () {
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetail(company: recent,),),);
                                                            },
                                                            child: RecentJobCard(company: recent),
                                                          );
                                                        }),
                                                    ]),
                                                );}
                                          );
                                        }
                                        else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }
                                        return Center(child: SizedBox(height:50,width:50,child: CircularProgressIndicator(strokeWidth: 1,)));
                                      })
                                  ;});
                        },)
                        ),
                      ),
                    Container(width: 50.0, height: 50.0,
                      margin: EdgeInsets.only(left: 12.0),
                      decoration: BoxDecoration(color: Palette.navyBlue, borderRadius: BorderRadius.circular(12.0),),
                      child: FlatButton( //filter
                        onPressed: () {
                          showMaterialModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return SingleChildScrollView(
                                        child: Column(
                                            children :[
                                              SizedBox(height: 20),
                                              Text('Filters',
                                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                              SizedBox(height : 20),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                                child: TextField(
                                                  controller: myLocation, //to get the info in myText : myText.text
                                                  cursorColor: Colors.black,
                                                  decoration: InputDecoration(
                                                    icon: Icon(Icons.home, size: 25.0, color: Colors.black,),
                                                    border: InputBorder.none,
                                                    hintText: "Location",
                                                    hintStyle: kSubtitleStyle.copyWith(color: Palette.navyBlue,),),),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                                child: TextField(
                                                  controller: myDescription, //to get the info in myText : myText.text
                                                  cursorColor: Colors.black,
                                                  decoration: InputDecoration(
                                                    icon: Icon(Icons.business_center, size: 25.0, color: Colors.black,),
                                                    border: InputBorder.none,
                                                    hintText: "Job Description",
                                                    hintStyle: kSubtitleStyle.copyWith(color: Palette.navyBlue,),),),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(width : 15),
                                                  Checkbox(value : checked,
                                                    onChanged:  (bool value) {
                                                    setState(() {
                                                        checked = value;
                                                        })
                                                    ;},
                                                    activeColor: Colors.blueAccent,
                                                  ),
                                                  SizedBox(width : 10),
                                                  Text('Full-Time Job'),
                                                ],),]
                                        ),
                                      );
                                    });
                              });},
                        child: Icon(FontAwesomeIcons.slidersH, color: Colors.white, size: 20.0,),),
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
                SizedBox(width: 170.0),
                Container(
                  child: FlatButton(
                    child: Text("Load More"),
                    onPressed: () {
                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return FutureBuilder <List<Company>>(
                                future: futurePopularOffer,
                                builder: (context, snapshot)  {
                                  if (snapshot.hasData) {
                                    return StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setState){
                                          return ListView.builder(
                                              itemCount: snapshot.data.length,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                var recent = snapshot.data[index];
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetail(company: recent,),),);
                                                  },
                                                  child: RecentJobCard(company: recent),
                                                );
                                              });}
                                    );
                                  }
                                  else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return Center(child: SizedBox(height:50,width:50,child: CircularProgressIndicator(strokeWidth: 1,)));
                                })
                            ;}
                      );},
                  ),
                ),]),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                height: 190.0,
                child: FutureBuilder<List<Company>>(
                  future: futurePopularOffer,
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
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
                                ),
                              ),
                            );
                          },
                          child: CompanyCard(company: company),
                        );
                      },
                    );}
                    else if (snapshot.hasError) {
                    return Text("${snapshot.error}");}
                    return Center(child: SizedBox(height:50,width:50,child: CircularProgressIndicator(strokeWidth: 1,)));
                    }),
                    ),
              SizedBox(height: 35.0),
              Row(children: [
                Text("Recent Jobs", style: kSectionTitleStyle,),
                SizedBox(width: 130.0),
                FlatButton(
                  child: Text("Load More"),
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder <List<Company>>(
                              future: futureRecentOffer,
                              builder: (context, snapshot)  {
                                if (snapshot.hasData) {
                                  return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState){
                                        return ListView.builder(
                                            itemCount: snapshot.data.length,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var recent = snapshot.data[index];
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetail(company: recent,),),);
                                                },
                                                child: RecentJobCard(company: recent),
                                              );
                                            });}
                                  );
                                }
                                else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return Center(child: SizedBox(height:50,width:50,child: CircularProgressIndicator(strokeWidth: 1,)));
                              })
                          ;}
                    );},
                ),
              ]),
              FutureBuilder <List<Company>>(
                future: futureRecentOffer,
                builder: (context,snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 5,
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
                                builder: (context) =>
                                    JobDetail(company: recent,),
                              ),);},
                          child: RecentJobCard(company: recent),
                        );},
                    );}
                  else if (snapshot.hasError) {
                    return Text("${snapshot.error}");}
                  return Center(child: SizedBox(height:50,width:50,child: CircularProgressIndicator(strokeWidth: 1,)));
                }),
            ],
          ),
        ),
      ),
    );
  }
}