import 'package:car_rental_system/models/address_model.dart';
import 'package:car_rental_system/models/destination_address_model.dart';
import 'package:car_rental_system/models/direction_details.dart';
import 'package:car_rental_system/models/own_address_model.dart';
import 'package:car_rental_system/models/prediction_model.dart';
import 'package:car_rental_system/notifier/maps_notifier.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

//Provides List places from Query
final predictionProvider =
    StateNotifierProvider<PredictionsNotifier, ApiState<PredictionsModel>>(
        (ref) {
  return PredictionsNotifier(ref.watch(searchQueryProvider));
});



//Provides Own Address
final ownAddressProvider =
    StateNotifierProvider<OwnAddressNotifier, ApiState<OwnAddressModel>>((ref) {
  return OwnAddressNotifier();
});

//Provides Destination Address
final destinationAddressProvider =
    StateNotifierProvider<AddressNotifier, ApiState<DestinationModel>>((ref) {
  return AddressNotifier();
});
//Provides Trip Details
//Reset These
final pickupAddressProvider = StateProvider<String>((ref) {
  return '';
});
final dropAddressProvider = StateProvider<String>((ref) {
  return '';
});
final tripInfoProvider = //make it null when trip ends
    StateProvider<DirectionDetails?>((ref) {
  return null;
});
//==================
final tripProvider =
    StateNotifierProvider<TripNotifier, ApiState<DirectionDetails>>((ref) {
  return TripNotifier();
});

//Google Map Controller
final googleMapsProvider = StateProvider<GoogleMapController?>((ref) {
  return null;
});
//Google Map Controller
final polyPointsProvider = StateProvider<List<Polyline>>((ref) {
  return [];
});

//=>Everything related to Location Position
//==================================================================//
final deafaultLocationProvider =
    Provider<LatLng>((ref) => const LatLng(23.788216, 90.401260));

//location tempStorage

final originLatlngTempProvider = StateProvider<LatLng?>((ref) => null);
//Provides users current location for the map
final originLatlngProvider = StateProvider<LatLng>((ref) {
  return ref.watch(postionStreamProvider).maybeWhen(
    orElse: () {
      if (ref.read(originLatlngTempProvider) != null) {
        return ref.read(originLatlngTempProvider)!;
      } else {
        return ref.read(deafaultLocationProvider);
      }
    },
    loaded: (_) {
      return LatLng(_.latitude, _.longitude);
    },
  );
});

//Location Stream
final postionStreamProvider =
    StateNotifierProvider<CurrentPostionNotifier, ApiState<Position>>((ref) {
  return CurrentPostionNotifier();
});
//==================================================================//
