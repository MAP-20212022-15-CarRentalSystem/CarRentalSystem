import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/widgets/confirmSheet.dart';
import '../widgets/widgets.dart';
import 'car_registration.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'owner_history.dart';
import 'profile_page.dart';


  /// Check If Vehicle Info Exists
  Future<void> checkIfDocExists() async {
    try {
      var collectionRef = FirebaseFirestore.instance
          .collection('users/${currentFirebaseUser.uid}/vehicle_details');

      var doc = await collectionRef.doc(currentFirebaseUser.uid).get();
      if (doc.exists) {
        exist = 'docexist';
      } else {
        exist = 'Please Register Your Car';
      }
    } catch (e) {
      exist = e;
    }
  }

  void goOnline() {
    print(currentFirebaseUser.uid);
    print("entered");

    Geofire.initialize('carsAvailable');
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);

    tripRequestRef = FirebaseDatabase.instance
        .reference()
        .child('cars/${currentFirebaseUser.uid}/newTrip');
    tripRequestRef.set('waiting');

    tripRequestRef.onValue.listen((event) {});
  }

  void getLocationUpdates() {
    print("location updates");

    homeTabPositionStream =
        Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isAvailable) {
        Geofire.setLocation(
            currentFirebaseUser.uid, position.latitude, position.longitude);
      }
      LatLng pos = LatLng(position.latitude, position.longitude);
      CameraPosition cp = new CameraPosition(target: pos, zoom: 15);
      mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    });
  }

  void goOffline() {
    Geofire.removeLocation(currentFirebaseUser.uid);
    tripRequestRef.onDisconnect();
    tripRequestRef.remove();
    tripRequestRef = null;
  }
}
