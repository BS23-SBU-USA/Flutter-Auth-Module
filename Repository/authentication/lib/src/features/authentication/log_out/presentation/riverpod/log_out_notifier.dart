part of '../riverpod/log_out_providers.dart';

class LogOutNotifier extends Notifier<LogOutState> {
  late LogOutUseCase logOutUseCase;

  @override
  LogOutState build() {
    logOutUseCase = ref.read(logOutUseCaseProvider);
    return const LogOutState();
  }

  Future<void> logOut({required BuildContext context}) async {
    Authentication.signOutFromGoogle();
    final offlineState = ref.read(offlineStateProvider);
    final ssoState = ref.read(ssoSignInProvider);
    try {
      final response = await logOutUseCase.call(
        offlineState: ssoState ? ssoState : offlineState,
      );

      if (response.$1.isEmpty) {
        state = state.copyWith(
          status: LogOutStatus.success,
        );
      } else {
        state = state.copyWith(
          status: LogOutStatus.failure,
          errorMessage: response.$1,
        );
      }
    } catch (e, stackTrace) {
      Log.debug(stackTrace.toString());
      state = state.copyWith(
        status: LogOutStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> removeStates() async {
    ref.read(offlineStateProvider.notifier).state = false;
    ref.read(ssoSignInProvider.notifier).state = false;
    ref.read(ssoUserProvider.notifier).state = null;
  }
}
