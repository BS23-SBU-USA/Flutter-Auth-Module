import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_form_validation_state.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'update_profile_form_validation_notifier.dart';

final updateProfileValidationProvider = AutoDisposeNotifierProvider<
    UpdateProfileFormValidationNotifier, UpdateProfileFormValidationState>(
  UpdateProfileFormValidationNotifier.new,
);
