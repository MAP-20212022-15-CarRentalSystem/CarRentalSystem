import 'dart:async';

import 'package:car_rental_system/constants/firebase_contants.dart';
import 'package:car_rental_system/models/user.dart';
import 'package:car_rental_system/services/api_state.dart';
import 'package:car_rental_system/services/network_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class CurrentUserNotifier extends StateNotifier<ApiState<AppUser>> {
  CurrentUserNotifier() : super(const ApiState.initial()) {
    getUser();
  }
  StreamSubscription<DocumentSnapshot<Object?>>? streamSub;
  Future<void> getUser() async {
    state = const ApiState.loading();
    try {
      streamSub = AppFBC.usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        state = ApiState.loaded(
          data: AppUser.fromMap(event.data()! as Map<String, dynamic>),
        );
      });
    } catch (e) {
      debugPrint(e.toString());
      state = ApiState.error(error: NetworkExceptions.getErrorMsg(e));
    }
  }

  @override
  void dispose() {
    if (streamSub != null) {
      streamSub!.cancel();
    }
    super.dispose();
  }
}
