import 'package:car_rental_system/constants/firebase_contants.dart';
import 'package:car_rental_system/models/user.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:car_rental_system/services/network_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadUserNotifier extends StateNotifier<ApiState<String>> {
  UploadUserNotifier() : super(const ApiState.initial());
  Future<void> uploadUserData(Map<String, dynamic> data) async {
    state = const ApiState.loading();
    try {
      await AppFBC.usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data);
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class UpdateUserNotifier extends StateNotifier<ApiState<String>> {
  UpdateUserNotifier() : super(const ApiState.initial());
  Future<void> updateUserData(Map<String, dynamic> data) async {
    state = const ApiState.loading();
    try {
      await AppFBC.usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class UserProfileCompleteNotifier extends StateNotifier<ApiState<bool>> {
  UserProfileCompleteNotifier() : super(const ApiState.initial());
  Future<void> hasCompleted() async {
    state = const ApiState.loading();
    try {
      final DocumentSnapshot<Object?> response = await AppFBC.usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (response.exists && response.data() != null) {
        state = ApiState.loaded(
          data: AppUser.fromMap(response.data()! as Map<String, dynamic>)
              .hasCompleteProfile,
        );
      }

    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}

class CurrentUserNotifier extends StateNotifier<ApiState<AppUser>> {
  CurrentUserNotifier() : super(const ApiState.initial());
  Future<void> getUser() async {
    state = const ApiState.loading();
    try {
      final DocumentSnapshot<Object?> response = await AppFBC.usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (response.exists && response.data() != null) {
        state = ApiState.loaded(
          data: AppUser.fromMap(response.data()! as Map<String, dynamic>)
              ,
        );
      }

    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }
}
