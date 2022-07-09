import 'package:car_rental_system/models/trip_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Trp {
  Trp._();
  static int getRidesAsRider(List<TripdataModel> trips) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    int tripCount = 0;
    trips.forEach((element) {
      if (element.riderID == uid) {
        tripCount++;
      }
    });
    return tripCount;
  }
  static int getRidesAsPassenger(List<TripdataModel> trips) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    int tripCount = 0;
    trips.forEach((element) {
      if (element.userID == uid) {
        tripCount++;
      }
    });
    return tripCount;
  }
  static double getEarningAsRider(List<TripdataModel> trips) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    double tripamount = 0;
    trips.forEach((element) {
      if (element.riderID == uid) {
       tripamount= tripamount + element.cost;
      }
    });
    return tripamount;
  }
  static double getEarningAsPassenger(List<TripdataModel> trips) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    double tripamount = 0;
    trips.forEach((element) {
      if (element.userID == uid) {
        tripamount= tripamount + element.cost;
      }
    });
    return tripamount;
  }
}
