import 'dart:io';

import 'package:auth_module/src/core/services/local_storage/cache_service.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/profile/root/data/models/profile_request_model.dart';
import 'package:auth_module/src/features/profile/root/domain/entities/profile_entity.dart';
import 'package:auth_module/src/features/profile/update_profile/domain/use_cases/update_profile_use_case.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_state.dart';
import 'package:auth_module/src/features/profile/user_profile/presentation/riverpod/user_profile_info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network/network.dart';

part 'update_profile_info_notifier.dart';

final updateProfileInfoProvider =
    AutoDisposeNotifierProvider<UpdateProfileInfoNotifier, UpdateProfileState>(
  UpdateProfileInfoNotifier.new,
);
