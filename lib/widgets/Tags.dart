import 'package:flutter/material.dart';


class Tag extends StatefulWidget {

  final String category;

  Tag({Key key, this.category}) : super(key: key);

  @override
  _TagState createState() => _TagState();



}



class _TagState extends State<Tag> {
  bool pressAttention = false;
  static List<String> choices = List();


  @override

  Widget build(BuildContext context) {

    return  RaisedButton(
      child: Text(widget.category),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: pressAttention ? Colors.grey : Colors.blue,
      onPressed: () => setState(()
      {
        pressAttention = !pressAttention;
        if (pressAttention == true)
        {
          choices.add(widget.category);
        }

        if (pressAttention == false)
        {
          choices.remove(widget.category);
        }

        print(choices);
      }),
    );


  }
}
