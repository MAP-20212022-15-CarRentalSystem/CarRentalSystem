import 'dart:io';

import 'package:car_rental_system/constants/firebase_contants.dart';
import 'package:car_rental_system/models/destination_address_model.dart' as ds;
import 'package:car_rental_system/models/direction_details.dart';
import 'package:car_rental_system/models/own_address_model.dart';
import 'package:car_rental_system/utils/context_less.dart';
import 'package:car_rental_system/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class AppGLF {
  AppGLF._();

  static Future<String> uploadImage(File image, String directory) async {
    final ext = path.extension(image.path);

    final Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("$directory/${DateTime.now().toIso8601String()}$ext");
    final UploadTask uploadTask = firebaseStorageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String storagePath = await taskSnapshot.ref.getDownloadURL();
    return storagePath;
  }

  static Future<bool> getPermission() async {
    final loc.Location location = loc.Location();
    PermissionStatus locationPerm = await Permission.location.request();

    if (locationPerm.isGranted) {
      final bool locationEnabled =
          await GeolocatorPlatform.instance.isLocationServiceEnabled();

      if (locationEnabled) {
        return locationEnabled;
      } else {
        final bool serviceSatus = await location.requestService();
        return serviceSatus;
      }
    } else {
      locationPerm = await Permission.location.request();
      if (locationPerm.isGranted) {
        final bool locationEnabled =
            await GeolocatorPlatform.instance.isLocationServiceEnabled();
        if (locationEnabled) {
          return locationEnabled;
        } else {
          final bool serviceSatus = await location.requestService();
          return serviceSatus;
        }
      } else {
        return false;
      }
    }
  }

  static int calculateFares(DirectionDetails directionDetails) {
    final double timeTraveledFare =
        (directionDetails.durationValue / 60) * 0.20;
    final double distanceTraveledFare =
        (directionDetails.distanceValue / 1000) * 26;
    final double totalFareAmount = timeTraveledFare + distanceTraveledFare;
    return totalFareAmount.truncate();
  }

  static String getAddress(Results result) {
    String data = '';
    for (var i = 1; i < result.addressComponents!.length; i++) {
      data = '$data${result.addressComponents![i].longName!}, ';
    }
    return data;
  }

  static String getDestinationAddress(List<ds.AddressComponents> result) {
    String data = '';
    for (var i = 1; i < result.length; i++) {
      data = '$data${result[i].longName!}, ';
    }
    return data;
  }

  static String getRidText(int status, String uid) {
    final useruid = FirebaseAuth.instance.currentUser!.uid;
    String data = '';
    switch (status) {
      case 0:
        data = uid == useruid ? 'Waiting for Rider' : 'Confirm Pick Up';
        break;
      case 1:
        data = uid == useruid ? 'Car On the Way' : 'Start Ride';
        break;
      case 2:
        data = uid == useruid ? 'Your Ride has Started' : 'Finish';
        break;
      case 3:
        data = uid == useruid ? 'Please Pay the Drive' : 'Confirm Payment';
        break;
      case 4:
        data = 'Leave A Review';
        break;
    }
    return data;
  }

  static Future<void> makeReview(String uid, BuildContext context) async {
    final useruid = FirebaseAuth.instance.currentUser!.uid;
    final TextEditingController textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        final Size deviceSize = MediaQuery.of(context).size;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: deviceSize.width,
              height: 200,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Leave Review About Your last Ride',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Write A Review',
                    ),
                    maxLines: 5,
                    minLines: 3,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppFBC.allTripCollection
                          .doc(uid)
                          .collection('review')
                          .add({
                        'msg': textEditingController.text.trim(),
                        'by': useruid
                      }).then((value) {
                        context.nav.pop();
                      });
                    },
                    child: const CustomButton(text: 'Submit'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> endTrip(String uid) async {
    
    AppFBC.allTripCollection.doc(uid).update({'isActive': false});
  }

  static Future<void> updateTripStatus(String uid, int status) async {
   
    AppFBC.allTripCollection.doc(uid).update({'status': status});
  }
}
