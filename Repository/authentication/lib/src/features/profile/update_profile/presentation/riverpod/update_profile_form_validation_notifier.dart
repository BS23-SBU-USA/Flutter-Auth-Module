part of 'update_profile_form_validation_provider.dart';

class UpdateProfileFormValidationNotifier
    extends AutoDisposeNotifier<UpdateProfileFormValidationState> {
  bool hasPhoneNumberBefore = false;
  @override
  UpdateProfileFormValidationState build() {
    hasPhoneNumberBefore =
        ref.watch(updateProfileInfoProvider.notifier).hasPhoneNumber;
    return const UpdateProfileFormValidationState();
  }

  bool isAbleToUpdate(String value) {
    bool isValid;

    if (hasPhoneNumberBefore && value.isEmpty) {
      isValid = false;
    } else {
      isValid = true;
    }

    state = state.copyWith(
      isValid: isValid,
    );
    return isValid;
  }
}
