import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/auth/utils/decoration_functions.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:job_finder/screens/Main/maps.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsOnePage extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  static String name = "";
  static bool _isOffers = true;
  static bool _isUpdates = true;
  static List<String> _tags = [];
  final databaseReference = FirebaseFirestore.instance.collection("users_data");
  static String uid = "";

  @override
  void initState() {
    final litUser = context.getSignedInUser();
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    super.initState();

    getTags(databaseReference, uid);
  }

  getSwitchValues() async {
    _isOffers = await getSwitchState();
    _isUpdates = await getSwitchState2();
    setState(() async {
      _isOffers = await getSwitchState();
      _isUpdates = await getSwitchState2();
    });
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("_off", value);
    return prefs.setBool("_off", value);
  }

  Future<bool> saveSwitchState2(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("_up", value);
    return prefs.setBool("_up", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isOffers = prefs.getBool("_off");
    return _isOffers;
  }

  Future<bool> getSwitchState2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isUpdates = prefs.getBool("_up");
    return _isUpdates;
  }

  void getTags(CollectionReference f, String uid) async {
    _tags = [];
    await f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      d.forEach((element) {
        Map<String, dynamic> da = element.data();
        if (da['uid'] == uid) {
          da['tags'].forEach((element) {
            _tags.add(element);
          });
        }
      });
    });
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

  @override
  Widget build(BuildContext context) {
    final litUser = context.getSignedInUser();
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getName(databaseReference, uid);
    getSwitchValues();
    if (_isOffers != true && _isOffers != false) _isOffers = true;
    if (_isUpdates != true && _isUpdates != false) _isUpdates = true;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[],
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Profile Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.navyBlue,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Palette.navyBlue,
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _namePopup(context, uid, databaseReference));
                      },
                      title: Text(
                        "$name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        child: Image.asset('assets/Images/profile.png'),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.business_center,
                            color: Palette.navyBlue,
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            showTagsDialog(context);
                          },
                          title: Text("Change Tags"),
                        ),
                        _buildDivider(),
                        ListTile(
                            leading: Icon(Icons.location_on,
                                color: Palette.navyBlue),
                            title: Text("Change Location"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationView()),
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.navyBlue,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: Palette.navyBlue,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text("Receive Offers notifications"),
                    value: _isOffers,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isOffers = newValue;
                        saveSwitchState(newValue);
                      });
                    },
                  ),
                  SwitchListTile(
                    activeColor: Palette.navyBlue,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text("Receive App Updates"),
                    value: _isUpdates,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isUpdates = newValue;
                        saveSwitchState2(newValue);
                      });
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text("Log out"),
                    onTap: () {
                      context.signOut();
                    },
                    trailing: Icon(
                      Icons.logout,
                      color: Palette.navyBlue,
                    ),
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  Widget _namePopup(
      BuildContext context, String uid, CollectionReference databaseReference) {
    final myName = TextEditingController();
    String newName;
    return new AlertDialog(
      title: const Text('Change Name'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: myName,
            decoration: registerInputDecoration(hintText: 'Enter New Name'),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              newName = myName.text;
              setData(databaseReference, uid, newName);
            });
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> showTagsDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final myTag = TextEditingController();

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: StickyHeader(
                    header: Container(
                      //color: Palette.navyBlue,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: TextField(
                                controller: myTag,
                                decoration:
                                    InputDecoration(hintText: "Enter New Tag"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(12.0),
                              child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    _tags.add(myTag.text);
                                  });
                                },
                                textColor: Colors.white,
                                child: const Text('Add'),
                                color: Palette.blueGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    content: Tags(
                        key: Key("2"),
                        symmetry: false,
                        columns: 0,
                        heightHorizontalScroll: 60,
                        itemCount: _tags.length,
                        itemBuilder: (index) {
                          final item = _tags[index];
                          return GestureDetector(
                              child: ItemTags(
                                key: Key(index.toString()),
                                index: index,
                                title: item,
                                pressEnabled: true,
                                activeColor: Colors.blueGrey[600],
                                singleItem: true,
                                splashColor: Palette.blueGreen,
                                combine: ItemTagsCombine.onlyText,
                                removeButton: ItemTagsRemoveButton(
                                  backgroundColor: Palette.ceayola,
                                  onRemoved: () {
                                    setState(() {
                                      _tags.removeAt(index);
                                    });
                                    return true;
                                  },
                                ),
                                textScaleFactor:
                                    utf8.encode(item.substring(0, 1)).length > 2
                                        ? 0.8
                                        : 1,
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(text: item));
                              });
                        })),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      uploadTags(_tags.toSet().toList());
                    });
                    Navigator.of(context).pop();
                  },
                  textColor: Theme.of(context).primaryColor,
                  child: const Text('Save'),
                ),
              ],
            );
          });
        });
  }

  void uploadTags(List<String> tags) {
    databaseReference.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      int l = snapshot.docs.length;
      for (var i = 0; i < l; i++) {
        if (d[i].data()["uid"].toString() == uid) {
          updateDataTags(databaseReference, tags, d[i].id);
          break;
        }
      }
    });
  }

  void updateDataTags(CollectionReference f, List<String> tags, String id) {
    try {
      f.doc(id).update({'tags': tags});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateData(CollectionReference f, String id, String name) {
    try {
      f.doc(id).update({'name': name});
    } catch (e) {
      print(e.toString());
    }
  }

  void setData(CollectionReference f, String uid, String name) {
    f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      int l = snapshot.docs.length;
      for (var i = 0; i < l; i++) {
        if (d[i].data()["uid"].toString() == uid) {
          updateData(f, d[i].id, name);
          break;
        }
      }
    });
  }
}
