// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:car_rental_system/configMaps.dart';
import 'package:car_rental_system/constants/regular_string_constants.dart';
import 'package:car_rental_system/models/address_model.dart';
import 'package:car_rental_system/models/destination_address_model.dart';
import 'package:car_rental_system/models/direction_details.dart';
import 'package:car_rental_system/models/own_address_model.dart';
import 'package:car_rental_system/models/prediction_model.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:car_rental_system/services/network_exceptions.dart';
import 'package:car_rental_system/utils/global_functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PredictionsNotifier extends StateNotifier<ApiState<PredictionsModel>> {
  PredictionsNotifier(this.query) : super(const ApiState.initial()) {
    getPredictions();
  }
  final String query;
  Dio dio = Dio();
  Future<void> getPredictions() async {
    state = const ApiState.loading();
    if (query.length >= 3) {
      try {
        final response = await dio.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$geocodingApi',
        );
        state = ApiState.loaded(
          data: PredictionsModel.fromMap(response.data as Map<String, dynamic>),
        );
      } catch (e) {
        debugPrint(e.toString());
        state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
      }
    }
  }
}

class AddressNotifier extends StateNotifier<ApiState<DestinationModel>> {
  AddressNotifier() : super(const ApiState.initial());

  Dio dio = Dio();
  Future<void> getPredictions(String placeId) async {
    state = const ApiState.loading();

    try {
      final response = await dio.get(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$geocodingApi',
      );
      state = ApiState.loaded(
        data: DestinationModel.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      debugPrint(e.toString());
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class OwnAddressNotifier extends StateNotifier<ApiState<OwnAddressModel>> {
  OwnAddressNotifier() : super(const ApiState.initial());

  Dio dio = Dio();
  Future<void> getPredictions(LatLng position) async {
    state = const ApiState.loading();

    try {
      final response = await dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$geocodingApi',
      );
      state = ApiState.loaded(
        data: OwnAddressModel.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      debugPrint('Hit Here ${e.toString()}');
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class TripNotifier extends StateNotifier<ApiState<DirectionDetails>> {
  TripNotifier() : super(const ApiState.initial());

  Dio dio = Dio();
  Future<void> getPredictions(
    LatLng initialPosition,
    LatLng finalPosition,
  ) async {
    state = const ApiState.loading();

    try {
      final response = await dio.get(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$geocodingApi',
      );

      final Map<String, dynamic> testData = {
        "encodedPoints": response.data['routes'][0]['overview_polyline']
            ['points'],
        "distanceText": response.data['routes'][0]['legs'][0]['distance']
            ['text'],
        "distanceValue": response.data['routes'][0]['legs'][0]['distance']
            ['value'],
        "durationText": response.data['routes'][0]['legs'][0]['duration']
            ['text'],
        "durationValue": response.data['routes'][0]['legs'][0]['duration']
            ['value']
      };
      state = ApiState.loaded(
        data: DirectionDetails.fromMap(testData),
      );
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class CurrentPostionNotifier extends StateNotifier<ApiState<Position>> {
  CurrentPostionNotifier() : super(const ApiState.initial()) {
    getPosition();
  }

  Future<void> getPosition() async {
    state = const ApiState.loading();
    final bool haspermission = await AppGLF.getPermission();
    if (haspermission) {
      try {
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            distanceFilter: 10,
            accuracy: LocationAccuracy.bestForNavigation,
          ),
        ).listen((event) {
          state = ApiState.loaded(data: event);
        });
      } catch (e) {
        state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
      }
    } else {
      state = const ApiState.error(error: AppRSC.noPermission);
      EasyLoading.showError('Please Enable Location To Run The App');
      Future.delayed(const Duration(seconds: 3)).then((value) {
        openAppSettings();
        exit(0);
      });
    }
  }
}
