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
        state = state.copyWith(
          status: UpdateProfileStatus.failure,
          error: response.$1,
        );
      }
    } catch (e, stackTrace) {
      Log.debug(stackTrace.toString());
      state.copyWith(
        status: UpdateProfileStatus.failure,
        error: e.toString(),
      );
    }
  }





}
