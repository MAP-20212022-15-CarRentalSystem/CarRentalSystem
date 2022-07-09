import 'package:car_rental_system/constants/firebase_contants.dart';
import 'package:car_rental_system/models/review_model.dart';
import 'package:car_rental_system/models/trip_data_model.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:car_rental_system/services/network_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartTripNotifier extends StateNotifier<ApiState<String>> {
  StartTripNotifier() : super(const ApiState.initial());
  Future<void> startTrip(TripdataModel trip) async {
    state = const ApiState.loading();
    try {
      await AppFBC.allTripCollection.add(trip.toMap());
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class UserTripListNotifier
    extends StateNotifier<ApiState<List<TripdataModel>>> {
  UserTripListNotifier() : super(const ApiState.initial()) {
    getTrips();
  }
  Future<void> getTrips() async {
    state = const ApiState.loading();
    try {
      AppFBC.allTripCollection.snapshots().listen((event) {
        final List<TripdataModel> abcData = [];

        for (final doc in event.docs) {
          final abData = TripdataModel.fromMap(doc.data());
          if (abData.docID == null) {
            AppFBC.allTripCollection.doc(doc.id).update({'docID': doc.id});
          }
          abcData.add(abData);
        }
        state = ApiState.loaded(data: abcData);
      });
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class ReviewsNotifier extends StateNotifier<ApiState<List<ReviewModel>>> {
  ReviewsNotifier() : super(const ApiState.initial());
  Future<void> getReviews(String id) async {
    state = const ApiState.loading();
    try {
      AppFBC.allTripCollection.doc(id).collection('review').snapshots().listen((event) {
        final List<ReviewModel> abcData = [];

        for (final doc in event.docs) {
          final abData = ReviewModel.fromMap(doc.data());
          
          abcData.add(abData);
        }
        state = ApiState.loaded(data: abcData);
      });
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}
