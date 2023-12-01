import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/log_out/domain/use_cases/log_out_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part '../riverpod/log_out_notifier.dart';
part '../riverpod/log_out_state.dart';

final logOutProvider = NotifierProvider<LogOutNotifier, LogOutState>(
  LogOutNotifier.new,
);
