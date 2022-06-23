import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/assistant/assistantMethods.dart';
import 'package:vehicle_sharing_app/dataHandler/appdata.dart';
import 'package:vehicle_sharing_app/models/directionDetails.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/screens/about_us.dart';
import 'package:vehicle_sharing_app/screens/car_list.dart';
import 'package:vehicle_sharing_app/screens/edit_car.dart';
import 'package:vehicle_sharing_app/screens/profile_page.dart';
import 'package:vehicle_sharing_app/screens/ride_history_page.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

import '../assistant/fireHelper.dart';
import '../globalvariables.dart';
import '../models/nearbyCar.dart';
import 'login_page.dart';
import 'owner_homePage.dart';
import 'search_dropOff.dart';



  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: 'Please Wait....'),
    );

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);
    setState(() {
      tripDirectionDetails = details;
      finalDestination = finalPos.placeName;
      initialLocation = initialPos.placeName;
    });

    Navigator.pop(context);
    // print('encoded points::');
    // print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();

    List<PointLatLng> decodedPolylinePointResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    pLinesCoordinates.clear();

    if (decodedPolylinePointResult.isNotEmpty) {
      decodedPolylinePointResult.forEach((PointLatLng pointLatLng) {
        pLinesCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(
      () {
        Polyline polyline = Polyline(
          color: Colors.green,
          polylineId: PolylineId('PolyLineID'),
          jointType: JointType.round,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          points: pLinesCoordinates,
          geodesic: true,
        );

        polylineSet.add(polyline);

        LatLngBounds latLngBounds;

        if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
            pickUpLatLng.longitude > dropOffLatLng.longitude) {
          latLngBounds =
              LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
        } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
          latLngBounds = LatLngBounds(
            southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
            northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          );
        } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
          latLngBounds = LatLngBounds(
            southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
            northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          );
        } else {
          latLngBounds =
              LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
        }

        newGoogleMapController.animateCamera(
          CameraUpdate.newLatLngBounds(latLngBounds, 100),
        );

        Marker pickUpLocMarker = Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow:
              InfoWindow(title: initialPos.placeName, snippet: 'PickUp'),
          position: pickUpLatLng,
          markerId: MarkerId('pickUpId'),
        );

        Marker dropOffLocMarker = Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: finalPos.placeName, snippet: 'DropOff'),
          position: dropOffLatLng,
          markerId: MarkerId('dropOffId'),
        );

        setState(() {
          markerSet.add(pickUpLocMarker);
          markerSet.add(dropOffLocMarker);
        });

        Circle pickUpLocCircle = Circle(
          fillColor: Colors.blueAccent,
          center: pickUpLatLng,
          radius: 12,
          strokeWidth: 4,
          strokeColor: Colors.blueAccent,
          circleId: CircleId('pickUpId'),
        );

        Circle dropOffLocCircle = Circle(
          fillColor: Colors.deepPurple,
          center: dropOffLatLng,
          radius: 12,
          strokeWidth: 4,
          strokeColor: Colors.deepPurple,
          circleId: CircleId('dropOffId'),
        );

        setState(() {
          circleSet.add(pickUpLocCircle);
          circleSet.add(dropOffLocCircle);
        });
      },
    );
  }
}
