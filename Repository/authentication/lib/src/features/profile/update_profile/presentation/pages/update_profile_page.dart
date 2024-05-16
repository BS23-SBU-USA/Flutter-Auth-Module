import 'dart:convert';

import 'package:auth_module/src/core/widgets/cutom_input_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/services/image_service/image_capture.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/core/widgets/underlined_text.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_form_validation_provider.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_info_provider.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/widgets/gender_dorpdown_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

part '../widgets/birthday_formfield_builder.dart';

part '../widgets/form_builder.dart';

part '../widgets/user_avatar_builder.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  const UpdateProfilePage({
    super.key,
  });

  @override
  ConsumerState<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateProfileInfoProvider);
    final notifier = ref.read(updateProfileInfoProvider.notifier);

    ref.listen(updateProfileInfoProvider, (_, next) {
      if (next.status.isSuccess) {
        _navigateToHomePage(context);
      } else if (next.status.isFailure) {
        ShowSnackBarMessage.showErrorSnackBar(
          message: next.error!,
          context: context,
        );
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Button.back(),
        title: const UnderlinedText(title: TextConstants.updateProfile),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: Column(
          children: [
            const UserAvatarBuilder(),
            const SizedBox(height: 15),
            const UpdateProfileFormBuilder(),
            const Spacer(),
            Button(
              isLoading: state.status.isLoading,
              label: TextConstants.updateProfile,
              onPressed: notifier.onUpdateProfileSubmit,
              textStyle: !ref.watch(updateProfileValidationProvider).isValid
                  ? AppTypography.semiBold16Caros(color: UIColors.gray)
                  : AppTypography.semiBold16Caros(color: UIColors.white),
              disable: !ref.watch(updateProfileValidationProvider).isValid,
            ),
            SizedBox(height: 40.sp),
          ],
        ),
      ),
    );
  }

  void _navigateToHomePage(BuildContext context) {
    ShowSnackBarMessage.showSuccessSnackBar(
      message: TextConstants.successfullyUpdated,
      context: context,
    );
    Navigator.pop(context);
  }
}
