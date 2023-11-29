part of 'change_password_provider.dart';

class ChangePasswordNotifier extends AutoDisposeNotifier<ChangePasswordState> {
  late final ChangePasswordUseCase useCase;

  @override
  ChangePasswordState build() {
    useCase = ref.read(changePasswordUseCaseProvider);
    return const ChangePasswordState();
  }

  Future<void> changePassword() async {
    try {
      state = state.copyWith(status: ChangePasswordStatus.loading);

      final requestBody = <String, dynamic>{
        'oldPassword':
            ref.read(changedOldPasswordStateProvider.notifier).state.text,
        'newPassword':
            ref.read(changedNewPasswordStateProvider.notifier).state.text,
        'confirmNewPassword':
            ref.read(changedConfirmPasswordStateProvider.notifier).state.text,
      };

      final response = await useCase.call(
        requestBody: requestBody,
        offlineState: ref.read(offlineStateProvider),
      );

      if (response.$1.isEmpty) {
        state = state.copyWith(
          status: ChangePasswordStatus.success,
        );
      } else {
        state = state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: response.$1,
        );
      }
    } catch (e, stackTrace) {
      Log.debug(stackTrace.toString());
      state = state.copyWith(
        status: ChangePasswordStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }
}
