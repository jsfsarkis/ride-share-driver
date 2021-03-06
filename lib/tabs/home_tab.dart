import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_share_driver/components/confirmation_sheet.dart';
import 'package:ride_share_driver/components/rounded_button.dart';
import 'package:ride_share_driver/constants.dart';
import 'package:ride_share_driver/global_variables.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Position currentPosition;

  String availabilityTitle = 'GO ONLINE';
  Color availabilityColor = colorOrange;
  bool isAvailable = false;

  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }

  void goOnline() {
    Geofire.initialize('driversAvailable');

    Geofire.setLocation(
      currentFirebaseUser.uid,
      currentPosition.latitude,
      currentPosition.longitude,
    );

    tripRequestRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${currentFirebaseUser.uid}/newtrip');

    tripRequestRef.set('waiting');
    tripRequestRef.onValue.listen((event) {});
  }

  void goOffline() {
    Geofire.removeLocation(currentFirebaseUser.uid);
    tripRequestRef.onDisconnect();
    tripRequestRef.remove();
    tripRequestRef = null;
  }

  void getLocationUpdates() {
    homeTabPositionStream =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;

      if (isAvailable) {
        Geofire.setLocation(
            currentFirebaseUser.uid, position.latitude, position.longitude);
      }

      LatLng pos = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newLatLng(pos));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 1.6,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              mapController = controller;
              await getCurrentPosition();
            },
          ),
          Container(
            height: 135,
            width: double.infinity,
            color: colorPrimary,
          ),
          Positioned(
            top: 34,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      builder: (BuildContext context) => ConfirmationSheet(
                        title: (!isAvailable) ? 'GO ONLINE' : 'GO OFFLINE',
                        subtitle: (!isAvailable)
                            ? 'You are about to become available to receive trip requests.'
                            : 'You will stop receiving trip requests.',
                        onPressed: () {
                          if (!isAvailable) {
                            goOnline();
                            getLocationUpdates();
                            Navigator.pop(context);
                            setState(() {
                              availabilityColor = colorGreen;
                              availabilityTitle = 'GO OFFLINE';
                              isAvailable = true;
                            });
                          } else {
                            goOffline();
                            Navigator.pop(context);
                            setState(() {
                              availabilityTitle = 'GO ONLINE';
                              availabilityColor = colorOrange;
                              isAvailable = false;
                            });
                          }
                        },
                      ),
                    );
                  },
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.width / 6,
                  fillColor: availabilityColor,
                  title: availabilityTitle,
                  titleColor: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
