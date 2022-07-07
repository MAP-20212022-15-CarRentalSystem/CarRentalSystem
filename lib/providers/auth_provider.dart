import 'package:car_rental_system/notifier/auth_notifier.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//For Signing Up
final signUpProvider =
    StateNotifierProvider<SignUpNotifier, ApiState<UserCredential>>((ref) {
  return SignUpNotifier();
});
