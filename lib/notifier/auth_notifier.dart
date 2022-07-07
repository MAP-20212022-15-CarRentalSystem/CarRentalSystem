import 'package:car_rental_system/services/api_state.dart';
import 'package:car_rental_system/services/network_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
