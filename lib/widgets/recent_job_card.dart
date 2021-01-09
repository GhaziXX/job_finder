import 'package:flutter/material.dart';
import 'package:job_finder/config/FontsConstants.dart';
import 'package:job_finder/models/compay.dart';
import 'package:job_finder/screens/Main/bookmarked.dart';
Color savedColor;

class RecentJobCard extends StatefulWidget {
  final Company company;
  static List<Company> faves = List();
  static List<String> identifier = List();

  RecentJobCard({this.company});

  @override
  _RecentJobCardState createState() => _RecentJobCardState() ;
}

class _RecentJobCardState extends State<RecentJobCard>{

  @override
  bool isPressed = false;
  void _increment() {
    setState(() {
      savedColor = Colors.red;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.0,
      margin: EdgeInsets.only(right: 18.0, top: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: SizedBox(height:80,width:80, child: Image(image : NetworkImage(widget.company.companyLogo))),
        title: FittedBox(child: Text(widget.company.title, style: kTitleStyle)),
        subtitle: FittedBox(
          child: Text(
            "${widget.company.company} • ${widget.company.time}",
          ),
        ),
        trailing: IconButton(icon: Icon(Icons.favorite),
            color : isPressed ? Colors.red : Colors.grey,


            onPressed: () {
              setState(() {
                isPressed = !isPressed;
                if (isPressed == true) {
                  RecentJobCard.faves.add(widget.company);
                  RecentJobCard.identifier.add(widget.company.id);
                  //ektebli fonction upload el id






                }
                if (isPressed == false) {
                  RecentJobCard.faves.remove(widget.company);
                  RecentJobCard.identifier.remove(widget.company.id);


                }

                print(RecentJobCard.faves);
              });
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookmarkedPage(
                            faves : RecentJobCard.faves,

                          ),
                    ),
                  );
                },
              );

            }
        ),




        isThreeLine: true,
      ),
    );
  }

}
