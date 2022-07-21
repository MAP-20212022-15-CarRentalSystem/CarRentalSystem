//For Logging Out
import 'package:car_rental_system/models/user.dart';
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

//gets current users Data
final currentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, ApiState<AppUser>>((ref) {
  return CurrentUserNotifier();
});
