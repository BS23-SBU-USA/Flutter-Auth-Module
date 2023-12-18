// ignore_for_file: avoid_dynamic_calls

part of 'user_profile_info_provider.dart';

class UserProfileInfoNotifier extends Notifier<UserProfileState> {
  late final UserProfileUseCase _userProfileUseCase;
  final formKey = GlobalKey<FormState>();
  bool isNotificationEnabled = false;

  @override
  UserProfileState build() {
    _userProfileUseCase = ref.read(userProfileUseCaseProvider);
    return UserProfileState();
  }

  Future<void> fetchUserProfile(String? userID) async {
    state = state.copyWith(
      status: UserProfileStatus.loading,
    );

    try {
      final response = await _userProfileUseCase.call(userID);

      if (response.$1.isEmpty) {
        state = state.copyWith(
          status: UserProfileStatus.success,
          data: response.$2,
        );

        if (userID == null) {
          ref.read(updateProfileInfoProvider.notifier).profileEntity =
              response.$2!;
        }
      } else {
        state = state.copyWith(
          status: UserProfileStatus.failure,
          error: response.$1,
        );
      }
    } catch (e, stackTrace) {
      await CacheService.instance.clearProfileId();
      await CacheService.instance.clearBearerToken();
      Log.debug(stackTrace.toString());
      state.copyWith(
        status: UserProfileStatus.failure,
        error: e.toString(),
      );
    }
  }
}
