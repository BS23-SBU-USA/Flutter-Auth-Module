import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpButtonStateProvider = StateProvider<bool>(
  (ref) => false,
);

final otpStateProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'otpStateProvider',
);

final otpFormKeyStateProvider = StateProvider<GlobalKey<FormState>>(
  (ref) => GlobalKey<FormState>(),
  name: 'otpFormKeyStateProvider',
);
