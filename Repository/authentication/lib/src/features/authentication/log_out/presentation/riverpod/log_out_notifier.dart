part of '../riverpod/log_out_providers.dart';

class LogOutNotifier extends Notifier<LogOutState> {
  late LogOutUseCase logOutUseCase;

  @override
  LogOutState build() {
    logOutUseCase = ref.read(logOutUseCaseProvider);
    return const LogOutState();
  }

  Future<void> logOut() async {
    try {
      state = state.copyWith(status: LogOutStatus.loading);
      final response = await logOutUseCase.call(
        offlineState: ref.read(offlineStateProvider),
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
}
