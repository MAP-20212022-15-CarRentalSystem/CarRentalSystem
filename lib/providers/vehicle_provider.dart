//gets current users Data
import 'package:car_rental_system/models/car_data_model.dart';
import 'package:car_rental_system/models/user.dart';
import 'package:car_rental_system/notifier/vehicle_notifier.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Uploads Vehicle For the First Time
final vehicleUploadProvider =
    StateNotifierProvider<VehicleUploadNotifier, ApiState<String>>((ref) {
  return VehicleUploadNotifier();
});

//updates Vehicle details
final vehicleUpdateProvider =
    StateNotifierProvider<VehicleUpdateNotifier, ApiState<String>>((ref) {
  return VehicleUpdateNotifier();
});

//provides vehicle data, can have multiple instance
final vehicleUserProvider = StateNotifierProvider.autoDispose
    .family<VehicleUserNotifier, ApiState<VehicleUser>, String>((ref, uid) {
  return VehicleUserNotifier(uid);
});

//updates Vehicle details
final userHasVehicleProvider =
    StateNotifierProvider<UserhasVehicleNotifier, ApiState<bool>>((ref) {
  return UserhasVehicleNotifier();
});
//updates Vehicle Status
final udateVehicleStatusProvider =
    StateNotifierProvider<UpdateVehicleStatusNotifier, ApiState<String>>((ref) {
  return UpdateVehicleStatusNotifier();
});


final udateVehicleAvailabiltyStatusProvider =
    StateNotifierProvider<UpdateVehicleRideStatusNotifier, ApiState<String>>(
        (ref) {
  return UpdateVehicleRideStatusNotifier();
});




//All cars

final allcarsProvider = StateProvider<List<CarDetailsModel>>((ref) {
  return [] ;
});

//Gets All Cars
final carListProvider =
    StateNotifierProvider<VehicleListNotifier, ApiState<List<CarDetailsModel>>>(
        (ref) {
  return VehicleListNotifier();
});
