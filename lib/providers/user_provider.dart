//For Logging Out
import 'package:car_rental_system/notifier/user_notifier.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//upload user after Sign Up
final uploadUserProvider =
    StateNotifierProvider<UploadUserNotifier, ApiState<String>>((ref) {
  return UploadUserNotifier();
});

//upload user after Sign Up
final updateUserProvider =
    StateNotifierProvider<UpdateUserNotifier, ApiState<String>>((ref) {
  return UpdateUserNotifier();
});

//checks if user has completed Profile
final userProfileCompleteProvider =
    StateNotifierProvider<UserProfileCompleteNotifier, ApiState<bool>>((ref) {
  return UserProfileCompleteNotifier();
});

//gets current users Data
final currentUserProvider =
    StateNotifierProvider<UserProfileCompleteNotifier, ApiState<bool>>((ref) {
  return UserProfileCompleteNotifier();
});
