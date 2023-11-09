import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/services/local_storage/cache_service.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_info_provider.dart';
import 'package:auth_module/src/features/profile/user_profile/domain/use_cases/user_profile_use_case.dart';
import 'package:auth_module/src/features/profile/user_profile/presentation/riverpod/user_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'user_profile_info_notifier.dart';

final userProfileInfoProvider =
    NotifierProvider<UserProfileInfoNotifier, UserProfileState>(
  UserProfileInfoNotifier.new,
);
