import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileProvider =
    StateProvider.autoDispose.family<File?, String>((ref, name) {
  return null;
});

final drawerStateProvider = StateProvider<bool>((ref) {
  return false;
});
final imageFileProvider = StateProvider.autoDispose<File?>((ref) {
  return null;
});
