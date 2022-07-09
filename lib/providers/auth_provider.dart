import 'package:car_rental_system/notifier/auth_notifier.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//For Logging Out
final signOutProvider =
    StateNotifierProvider<SignOutNotifier, ApiState<String>>((ref) {
  return SignOutNotifier();
});

//For Signing Up
final signUpProvider =
    StateNotifierProvider<SignUpNotifier, ApiState<UserCredential>>((ref) {
  return SignUpNotifier();
});
//For Resetting Password
final forgotPassworProvider =
    StateNotifierProvider<ForgotPassNotifier, ApiState<String>>((ref) {
  return ForgotPassNotifier();
});
