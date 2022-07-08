import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppFBC {
  AppFBC._(); //This is not ment to be initiated
  // FBC Stands for Firebase Contstants

  //users Collection
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  //all trip Collection
  static final  allTripCollection =
      FirebaseFirestore.instance
          .collection('trip')
          ;
  //all vehicle Collection
  static final  allVehicleCollection =
      FirebaseFirestore.instance
          .collection('vehicle')
          ;
  //users vehicle Collection
  static final DocumentReference<Map<String, dynamic>> userVehicleCollection =
      FirebaseFirestore.instance
          .collection('vehicle')
          .doc(FirebaseAuth.instance.currentUser!.uid);

  //others vehicle Collection
  static DocumentReference<Map<String, dynamic>> othersVehicleCollection(
    String uid,
  ) =>
      FirebaseFirestore.instance
          .collection('vehicle')
          .doc(uid);

  //String Constants for Firebase
  static const String vehileImages = 'vehileImages';
}
