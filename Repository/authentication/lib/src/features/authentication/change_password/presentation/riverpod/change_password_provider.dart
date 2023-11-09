import 'package:equatable/equatable.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/change_password/domain/use_cases/change_password_use_cases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'change_password_notifier.dart';
part 'change_password_state.dart';

final changePasswordProvider =
    AutoDisposeNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
  ChangePasswordNotifier.new,
);
