import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:job_finder/config/Palette.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class LocationView extends StatefulWidget {
  LocationView({Key key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  GoogleMapController mapController;
  String searchAddr;
  LatLng position;

  static LatLng _initialPosition;
  static List<Marker> _markers = [];
  final databaseReference = FirebaseFirestore.instance.collection("users_data");
  String uid = "";

  @override
  void initState() {
    super.initState();

    final litUser = context.getSignedInUser();

    litUser.when((user) => uid = user.uid, empty: () {}, initializing: () {});
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            compassEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            trafficEnabled: true,
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 10),
            onTap: handleTap,
            markers: Set.from(_markers),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 160.0, right: 6.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: "1",
                  onPressed: () {
                    getUserLocation();
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(_initialPosition.latitude,
                                _initialPosition.longitude),
                            zoom: 10.0)));
                  },
                  backgroundColor: Palette.navyBlue,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  child: const Icon(
                    Icons.gps_fixed,
                    size: 24.0,
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 100.0, right: 6.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: "2",
                  onPressed: () {
                    savePosition(databaseReference, uid, position);
                  },
                  backgroundColor: Palette.navyBlue,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  child: const Icon(
                    Icons.save_sharp,
                    size: 24.0,
                  ),
                ),
              )),
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  handleTap(LatLng tappedPoint) {
    setState(() {
      _markers = [];
      position = tappedPoint;
      _markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          }));
    });
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  void savePosition(CollectionReference f, String uid, LatLng pos) {
    getData(f, uid, pos);
  }

  void getData(CollectionReference f, String uid, LatLng pos) async {
    await f.get().then((QuerySnapshot snapshot) {
      List<QueryDocumentSnapshot> d = snapshot.docs;
      int l = snapshot.docs.length;

      for (var i = 0; i < l; i++) {
        if (d[i].data()['uid'] == uid) {
          updateData(f, d[i].id, GeoPoint(pos.latitude, pos.longitude));
          break;
        }
      }
    });
  }

  void updateData(CollectionReference f, String id, GeoPoint pos) {
    try {
      f.doc(id).update({'position': pos});
    } catch (e) {
      print(e.toString());
    }
  }

  void getUserLocation() async {
    Position position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();

    return FloatingSearchBar(
      hint: 'Search for new place',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      controller: controller,
      onQueryChanged: (query) {
        searchAddr = query;
      },
      onSubmitted: (query) {
        searchNavigate();
        setState(() {
          controller.close();
        });
      },
      transition: CircularFloatingSearchBarTransition(),
      // leadingActions: [
      //   FloatingSearchBarAction(
      //     showIfOpened: false,
      //     child: CircularButton(
      //       icon: const Icon(Icons.arrow_back),
      //       onPressed: () {
      //         Navigator.pop(context);
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => SettingsOnePage()));
      //       },
      //     ),
      //   ),
      // ],
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {
              getUserLocation();
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(_initialPosition.latitude,
                          _initialPosition.longitude),
                      zoom: 10.0)));
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
        );
      },
    );
  }

  Future<void> searchNavigate() async {
    List<Location> l =
        await GeocodingPlatform.instance.locationFromAddress(searchAddr);

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(l[0].latitude, l[0].longitude), zoom: 10.0)));
    setState(() {
      position = LatLng(l[0].latitude, l[0].longitude);
    });
    handleTap(LatLng(l[0].latitude, l[0].longitude));
  }
}
