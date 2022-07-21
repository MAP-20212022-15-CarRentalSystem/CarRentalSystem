import 'dart:async';
import 'dart:io';

import 'package:car_rental_system/constants/firebase_contants.dart';
import 'package:car_rental_system/constants/regular_string_constants.dart';
import 'package:car_rental_system/models/car_data_model.dart';
import 'package:car_rental_system/models/user.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:car_rental_system/services/network_exceptions.dart';
import 'package:car_rental_system/utils/global_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleUploadNotifier extends StateNotifier<ApiState<String>> {
  VehicleUploadNotifier() : super(const ApiState.initial());
  Future<void> upload(
    Map<String, dynamic> datau,
    File localFile,
  ) async {
    state = const ApiState.loading();
    try {
      final String url =
          await AppGLF.uploadImage(localFile, AppFBC.vehileImages);
      final data = {...datau};
      debugPrint('dw url $url');
      data['vehicleImg'] = url;
      data[AppRSC.vrfcHasCompletedRegistration] = true;
      data[AppRSC.vrfcUserId] = FirebaseAuth.instance.currentUser!.uid;
      data[AppRSC.vrfcOwnerEmail] = FirebaseAuth.instance.currentUser!.email;
      await AppFBC.userVehicleCollection.set(data);
      state = const ApiState.loaded(
        data: 'Success',
      );
    } catch (e) {
      debugPrint(e.toString());
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class VehicleUpdateNotifier extends StateNotifier<ApiState<String>> {
  VehicleUpdateNotifier() : super(const ApiState.initial());
  Future<void> update(
    Map<String, dynamic> data,
  ) async {
    state = const ApiState.loading();
    try {
      await AppFBC.userVehicleCollection.update(data);
      state = const ApiState.loaded(
        data: 'Success',
      );
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class VehicleUserNotifier extends StateNotifier<ApiState<VehicleUser>> {
  VehicleUserNotifier(this.uid) : super(const ApiState.initial());

  final String uid;
  Future<void> getOwner(
    Map<String, dynamic> data,
  ) async {
    state = const ApiState.loading();
    try {
      final DocumentSnapshot<Map<String, dynamic>> data =
          await AppFBC.othersVehicleCollection(uid).get();

      if (data.exists && data.data() != null) {
        state = ApiState.loaded(
          data: VehicleUser.fromMap(data.data()!),
        );
      }
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}



class UpdateVehicleStatusNotifier extends StateNotifier<ApiState<String>> {
  UpdateVehicleStatusNotifier() : super(const ApiState.initial());

  // ignore: avoid_positional_boolean_parameters
  Future<void> getData({required bool status}) async {
    state = const ApiState.loading();
    try {
      await AppFBC.userVehicleCollection
          .update({AppRSC.vrfcisAvaiable: status});

      state = const ApiState.loaded(
        data: 'Success',
      );
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class UpdateVehicleRideStatusNotifier extends StateNotifier<ApiState<String>> {
  UpdateVehicleRideStatusNotifier() : super(const ApiState.initial());

  // ignore: avoid_positional_boolean_parameters
  Future<void> getData(bool status) async {
    state = const ApiState.loading();
    try {
      await AppFBC.userVehicleCollection.update({AppRSC.vrfcisonRide: status});

      state = const ApiState.loaded(
        data: 'Success',
      );
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class VehicleListNotifier
    extends StateNotifier<ApiState<List<CarDetailsModel>>> {
  VehicleListNotifier() : super(const ApiState.initial()) {
    getData();
  }
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  // ignore: avoid_positional_boolean_parameters
  Future<void> getData() async {
    state = const ApiState.loading();
    try {
      streamSubscription =
          AppFBC.allVehicleCollection.snapshots().listen((event) {
        final List<CarDetailsModel> cars = [];
        for (final element in event.docs) {
          try {
            cars.add(CarDetailsModel.fromMap(element.data()));
          } catch (e) {
            debugPrint('Hit wall : ${e.toString()}');
          }
        }
        debugPrint('Hit wall : ${cars.length}');
        state = ApiState.loaded(data: cars);
      });
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }

  @override
  void dispose() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
    super.dispose();
  }
}
