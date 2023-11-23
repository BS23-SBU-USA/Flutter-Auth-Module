part of 'update_profile_info_provider.dart';

class UpdateProfileInfoNotifier
    extends AutoDisposeNotifier<UpdateProfileState> {
  late final UpdateProfileUseCase _updateProfileUseCase;
  final formKey = GlobalKey<FormState>();
  bool isNotificationEnabled = false;
  bool hasPhoneNumber = false;
  late ProfileEntity profileEntity;

  XFile? imageFile;
  String? uploadedImage;

  Dio dio = Dio();

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

  Future<void> onUpdateProfileSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    state = state.copyWith(status: UpdateProfileStatus.loading);

    if (imageFile != null) {
      File file = File(imageFile!.path);

      Map<String, dynamic> requestBody = {
        'file': await MultipartFile.fromFile(
          imageFile!.path,
          filename: file.path.split('/').last,
        ),
      };

      final response =
          await _updateProfileUseCase.uploadImage(requestBody: requestBody);

      if (response.$1.isEmpty) {
        uploadedImage = response.$2!.data.image?.url;
      } else {
        _resetProfile();
        state = state.copyWith(
          status: UpdateProfileStatus.failure,
          error: response.$1,
        );
      }
    }

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
      avatar: uploadedImage ??
          ((profileEntity.avatar != avatarController.text)
              ? avatarController.text
              : ''),
    );

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
