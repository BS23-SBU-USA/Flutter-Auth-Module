import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPassButtonStateProvider = StateProvider<bool>(
  (ref) => false,
);

final forgotPasswordEmailStateProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
  name: 'forgotPasswordEmailStateProvider',
);

final forgotPasswordFormKeyStateProvider = StateProvider<GlobalKey<FormState>>(
  (ref) => GlobalKey<FormState>(),
  name: 'forgotPasswordFormKeyStateProvider',
);
