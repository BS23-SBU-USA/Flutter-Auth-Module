part of 'change_password_provider.dart';

class ChangePasswordNotifier extends AutoDisposeNotifier<ChangePasswordState> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late final ChangePasswordUseCase useCase;

  @override
  ChangePasswordState build() {
    useCase = ref.read(changePasswordUseCaseProvider);
    return const ChangePasswordState();
  }

  Future<void> changePassword(bool offlineState) async {
    try {
      if (!formKey.currentState!.validate()) return;

      if (offlineState) {
        offlineChangePassword();
        return;
      }

      state = state.copyWith(status: ChangePasswordStatus.loading);

      final requestBody = <String, dynamic>{
        'oldPassword': oldPasswordController.text,
        'newPassword': newPasswordController.text,
        'confirmNewPassword': confirmPasswordController.text,
      };

      final response = await useCase.call(requestBody: requestBody);

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

  void offlineChangePassword() {
    final password = newPasswordController.text;

    useCase.offlineNewPassword(
      password: password,
    );

    state = state.copyWith(
      status: ChangePasswordStatus.success,
    );
  }
}
