import 'package:car_rental_system/services/api_state.dart';
import 'package:car_rental_system/services/network_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignOutNotifier extends StateNotifier<ApiState<String>> {
  SignOutNotifier() : super(const ApiState.initial());
  Future<void> signOut() async {
    state = const ApiState.loading();
    try {
      await FirebaseAuth.instance.signOut();
      EasyLoading.showSuccess('Logged Out');
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class SignUpNotifier extends StateNotifier<ApiState<UserCredential>> {
  SignUpNotifier() : super(const ApiState.initial());
  Future<void> signUp(String email, String password) async {
    state = const ApiState.loading();
    try {
      final UserCredential data =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.showSuccess('Account Created Succesfully');
      state = ApiState.loaded(data: data);
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class ForgotPassNotifier extends StateNotifier<ApiState<String>> {
  ForgotPassNotifier() : super(const ApiState.initial());
  Future<void> resetPass(String email) async {
    state = const ApiState.loading();
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}
