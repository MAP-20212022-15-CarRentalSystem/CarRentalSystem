import 'package:car_rental_system/models/review_model.dart';
import 'package:car_rental_system/models/trip_data_model.dart';
import 'package:car_rental_system/notifier/trip_notfier.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final startTripProvider =
    StateNotifierProvider<StartTripNotifier, ApiState<String>>((ref) {
  return StartTripNotifier();
});

final activeTripProvider = StateProvider<TripdataModel?>((ref) {
  return ref.watch(userTripListProvider).maybeWhen(
    orElse: () {
      return null;
    },
    loaded: (_) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final List<TripdataModel> data = _
          .where(
            (element) =>
                element.isActive == true &&
                (element.userID == uid || element.riderID == uid),
          )
          .toList();
      return data.isNotEmpty ? data.first : null;
    },
  );
});
final allTripProvider = StateProvider<List<TripdataModel>>((ref) {
  return ref.watch(userTripListProvider).maybeWhen(
    orElse: () {
      return [];
    },
    loaded: (_) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final List<TripdataModel> data = _
          .where(
            (element) => element.userID == uid || element.riderID == uid,
          )
          .toList();
      return data;
    },
  );
});

final allReviewProvider =
    StateNotifierProvider<ReviewsNotifier, ApiState<List<ReviewModel>>>((ref) {
  return ReviewsNotifier();
});

final userTripListProvider =
    StateNotifierProvider<UserTripListNotifier, ApiState<List<TripdataModel>>>(
        (ref) {
  return UserTripListNotifier();
});
