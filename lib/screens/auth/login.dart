import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kMainColor = Colors.deepPurple;
var isSwitched = false;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstDegreeEquations(),
    );
  }
}

class FirstDegreeEquations extends StatefulWidget{

  @override
  _FirstDegreeEquationsState createState() => _FirstDegreeEquationsState();
}


class _FirstDegreeEquationsState extends State<FirstDegreeEquations> {


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Job Finder'
          ),
          backgroundColor: kMainColor,
        ),
        body:

        Padding( // padding mte3 el app kemla
          padding: EdgeInsets.symmetric(vertical: screenHeight * 10/ 100,
              horizontal: screenWidth * 10 / 100),


          child: Column(
            children: [



            SizedBox(
              height : screenHeight*4/100,
            ),

              Container(  //BIG container ( li fif username + password)

                padding : new EdgeInsets.fromLTRB(20,20, 20, 10),
                decoration: BoxDecoration (


                  border: Border(
                    top: BorderSide(width: 3.0, color: Color(0xFFFF000000)), // hedha el 5ochn mte3 el borders
                    left: BorderSide(width: 3.0, color: Color(0xFFFF000000)),
                    right: BorderSide(width: 3.0, color: Color(0xFFFF000000)),
                    bottom: BorderSide(width: 3.0, color: Color(0xFFFF000000)),
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(30.0) // tadwira fel border
                  ),

                   


                ),


                child:
                Column( // column li fiha container el login + password
                  mainAxisAlignment: MainAxisAlignment.center,


                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * 3 / 100,
                      child: Text('LOGIN',
                        style : TextStyle (
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )
                      ),


                    ),

                    SizedBox(
                      height : screenHeight * 3/100,
                    ),

                    Container( //login



                      decoration: const BoxDecoration ( //5ochn el borders
                        border: Border(
                          top: BorderSide(width: 3.0,
                              color: Color(0xFFFF000000)),
                          left: BorderSide(width: 3.0,
                              color: Color(0xFFFF000000)),
                          right: BorderSide(width: 3.0,
                              color: Color(0xFFFF000000)),
                          bottom: BorderSide(width: 3.0,
                              color: Color(0xFFFF000000)),
                        ),
                        borderRadius: BorderRadius.all( //tadwira fel borders
                            Radius.circular(10.0)
                        ),
                      ),

                      height: screenHeight * 10 / 100,

                      alignment: Alignment.center,
                      child: Row( // fiha TextField
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SizedBox( // fiha TextField
                            height: screenHeight*10/100,
                            width: screenWidth*50/100,
                            child: TextField(

                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email' // label text
                                  ),

                            ),
                          ),
                        ],
                      ),


                    ),


                    SizedBox(
                      height: screenHeight * 4 / 100,
                    ),
                    Container //container el password
                      (

                      decoration: const BoxDecoration (
                        border: Border(
                          top: BorderSide(width: 3.0,
                              color: Color(0xFFFF000000)),
                          left: BorderSide(width: 3.0,
                              color: Color(0xFFFF000000)),
                          right: BorderSide(width: 3.0,
                              color: Color(0xFFFF000000)),
                          bottom: BorderSide(width: 3.0,
                              color: Color(0xFFFF000000)),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)
                        ),
                      ),

                      height: screenHeight * 10 / 100,
                      alignment: Alignment.center,
                      child: Row
                        (
                            //fiha textfield

                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SizedBox( //fiha textfield
                            height: screenHeight*30/100,
                            width: screenWidth*50/100,
                            child: TextField(
                              //prefix icon
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password'
                              ),

                            ),
                          ),

                        ],
                      ),


                    ),
                      SizedBox(
                        height :screenHeight * 3/ 100,
                      ),
                    SizedBox( // fih el jomlet forgot password
                      height: screenHeight * 5/ 100,

                      child: Text('                            Forgot password?',
                      style : TextStyle (

                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),

                    ),
                    ),
                  ],

                ),
              ),



              Container( // button sign in
                child :
                    Row(
                      children : [

                        SizedBox(
                          height :screenHeight * 10/ 100,

                        ),


                SizedBox(
                  height :screenHeight * 4/ 100,


                    child :
                  FlatButton(
                    onPressed: () {

                    },
                    child: Text(
                      "Sign in",
                      style : TextStyle(
                        color : Colors.white
                      ),
                    ),

                    color : Colors.deepPurple,
                  ),
                  ),

                        SizedBox(
                          width : screenWidth*19/100,
                        ),
                        SizedBox(

                          child : Text('Remember me',
                          style : TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        ),



                        Switch(

                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched =  value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.deepPurple,
                          activeColor: Colors.white,
                        ),

                ],
                ),
              ),


              SizedBox(
                height: screenHeight * 4/ 100,

                child: Text('New user?',
                  style : TextStyle (

                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),

                ),
              ),



              Container( // button register
                child :
                Row(
                  children : [

                    SizedBox(
                      width :screenHeight * 15/ 100 ,
                    ),
                    SizedBox(
                      height: screenHeight * 5/ 100,
                      child :
                      FlatButton(
                        onPressed: () {

                        },
                        child: Text(
                          "Register",

                          style : TextStyle(
                              color : Colors.white
                          ),
                        ),

                        color : Colors.deepPurple,
                      ),

                    ),






                  ],
                ),
              ),



                  ],




          ),


        ),
      ),
    );
  }


}