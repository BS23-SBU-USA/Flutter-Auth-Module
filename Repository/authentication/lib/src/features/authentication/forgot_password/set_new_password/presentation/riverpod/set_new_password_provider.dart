import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setNewPasswordStateProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'setNewPasswordStateProvider',
);

final setConfirmPasswordStateProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'setConfirmPasswordStateProvider',
);
