import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:job_finder/screens/auth/utils/decoration_functions.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:job_finder/screens/Main/maps.dart';

class SettingsOnePage extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  static String name = "";
  bool _dark;
  bool _isOffers = true;
  bool _isUpdates = true;
  @override
  void initState() {
    super.initState();
    _dark = false;
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
    final databaseReference =
        FirebaseFirestore.instance.collection("users_data");
    final litUser = context.getSignedInUser();
    String uid = "";
    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getName(databaseReference, uid);

    return Scaffold(
      backgroundColor: _dark ? null : Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _tagsPopup(context, uid, databaseReference));
                        },
                        title: Text("Change Tags"),
                      ),
                      _buildDivider(),
                      ListTile(
                          leading:
                              Icon(Icons.location_on, color: Palette.navyBlue),
                          title: Text("Change Location"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationView()));
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
                    color: Colors.indigo,
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
                    });
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text("Log out"),
                  onTap: () {
                    context.signOut();
                  },
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ],
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

  Widget _tagsPopup(
      BuildContext context, String uid, CollectionReference databaseReference) {
    final myTag = TextEditingController();
    String newTag;
    return new AlertDialog(
      title: const Text('Change Tags'),
      content: new Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextField(
                controller: myTag,
                decoration: registerInputDecoration(hintText: 'Enter New Tag'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: FlatButton(
                onPressed: () {
                  print("hna add tag");
                },
                textColor: Theme.of(context).primaryColor,
                child: const Text('Add'),
              ),
            ),
          ),
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
              print("hna zid el fonction ta3 l'ajout");
            });
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Save'),
        ),
      ],
    );
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
