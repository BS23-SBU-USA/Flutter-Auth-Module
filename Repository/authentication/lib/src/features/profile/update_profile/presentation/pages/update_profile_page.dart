import 'dart:convert';

import 'package:auth_module/src/features/profile/root/data/models/profile_request_model.dart';
import 'package:auth_module/src/features/profile/user_profile/presentation/riverpod/user_profile_info_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/services/image_service/image_capture.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/core/widgets/underlined_text.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_info_provider.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/widgets/gender_dorpdown_builder.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController avatarController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController countryCodeController =
      TextEditingController(text: "+880");

  final TextEditingController onlyPhoneController = TextEditingController();

  final TextEditingController genderController =
      TextEditingController(text: TextConstants.male);
  final TextEditingController dateOfBirthController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
  void initState() {
    final profileState = ref.read(userProfileInfoProvider);
    avatarController.text = profileState.data!.avatar!;
    firstNameController.text = profileState.data!.firstname!;
    lastNameController.text = profileState.data!.lastname!;
    countryCodeController.text = profileState.data!.phone!.substring(0, 4);
    onlyPhoneController.text = profileState.data!.phone!.substring(4);
    genderController.text = profileState.data!.gender!;
    dateOfBirthController.text = profileState.data!.dateOfBirth!;
    super.initState();
  }

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
            UserAvatarBuilder(
              avatarController: avatarController,
            ),
            const SizedBox(height: 15),
            Form(
              key: _formKey,
              child: UpdateProfileFormBuilder(
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                countryCodeController: countryCodeController,
                onlyPhoneController: onlyPhoneController,
                genderController: genderController,
                dateOfBirthController: dateOfBirthController,
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: state.status.isLoading
                  ? null
                  : _updateProfile,
              child: state.status.isLoading
                  ? Transform.scale(
                      scale: 0.75,
                      child: const CircularProgressIndicator(),
                    )
                  : const Text(TextConstants.updateProfile),
            ),
            SizedBox(height: 40.sp),
          ],
        ),
      ),
    );
  }

  //avatar image needs to be send
  void _updateProfile() {
    final profileEntity = ref.read(userProfileInfoProvider).data!;
    if(_formKey.currentState!.validate()){
      final profileRequestModel = ProfileRequestModel(
      firstname: (profileEntity.firstname != firstNameController.text)
          ? firstNameController.text
          : '',
      lastname: (profileEntity.lastname != lastNameController.text)
          ? lastNameController.text
          : '',
      dateOfBirth: (profileEntity.dateOfBirth != dateOfBirthController.text)
          ? dateOfBirthController.text
          : '',
      gender: (profileEntity.gender != genderController.text)
          ? genderController.text
          : '',
      phone: (profileEntity.phone != onlyPhoneController.text)
          ? countryCodeController.text + onlyPhoneController.text
          : '',
      avatar: (profileEntity.avatar != avatarController.text)
          ? avatarController.text
          : '',
    );
      ref.read(updateProfileInfoProvider.notifier).onUpdateProfileSubmit(
        profileRequestModel,
      );
    }
  }

  void _navigateToHomePage(BuildContext context) {
    ShowSnackBarMessage.showSuccessSnackBar(
      message: TextConstants.successfullyUpdated,
      context: context,
    );
    Navigator.pop(context);
  }
}
