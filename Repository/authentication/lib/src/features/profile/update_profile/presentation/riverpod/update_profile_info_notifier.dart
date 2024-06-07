part of 'update_profile_info_provider.dart';

class UpdateProfileInfoNotifier
    extends AutoDisposeNotifier<UpdateProfileState> {
  late final UpdateProfileUseCase _updateProfileUseCase;
  final formKey = GlobalKey<FormState>();
  bool isNotificationEnabled = false;
  bool hasPhoneNumber = false;
  late ProfileEntity profileEntity;

  @override
  UpdateProfileState build() {
    _updateProfileUseCase = ref.read(updateProfileUseCaseProvider);

    ref.listen(userProfileInfoProvider, (previous, next) {
      if (next.status.isSuccess) {
        profileEntity = next.data!;
        _resetProfile();
      }
    });
    return UpdateProfileState();
  }
  Future<void> onUpdateProfileSubmit(
    ProfileRequestModel profileRequestModel,
  ) async {

    state = state.copyWith(status: UpdateProfileStatus.loading);

    try {
      final response = await _updateProfileUseCase.call(
        requestBody: profileRequestModel.toJson(),
      );

      if (response.$1.isEmpty) {
        profileEntity = response.$2!;
        await CacheService.instance.storeFullName(
          profileEntity.firstname!,
          profileEntity.lastname!,
        );
        state = state.copyWith(
          status: UpdateProfileStatus.success,
          data: profileEntity,
        );
        ref.read(userProfileInfoProvider).data = profileEntity;
      } else {
        _resetProfile();
        state = state.copyWith(
          status: UpdateProfileStatus.failure,
          error: response.$1,
        );
      }
    } catch (e, stackTrace) {
      _resetProfile();
      Log.debug(stackTrace.toString());
      state.copyWith(
        status: UpdateProfileStatus.failure,
        error: e.toString(),
      );
    }
  }

  void _resetProfile() {
    firstNameController.text = profileEntity.firstname!;
    lastNameController.text = profileEntity.lastname!;
    avatarController.text = profileEntity.avatar ?? '';
    onlyPhoneController.text = profileEntity.phone != null
        ? profileEntity.phone!.substring(
            profileEntity.phone!.length - 10,
            profileEntity.phone!.length,
          )
        : '';
    genderController.text = profileEntity.gender ?? '';
    countryCodeController.text = profileEntity.phone != null
        ? profileEntity.phone!.substring(0, profileEntity.phone!.length - 10)
        : '+880';
    dateOfBirthController.text = profileEntity.dateOfBirth ?? '';
    isNotificationEnabled = profileEntity.notificationPreference ?? false;

    profileEntity.phone != null
        ? hasPhoneNumber = true
        : hasPhoneNumber = false;
  }

  /// Text fields controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController onlyPhoneController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
}
