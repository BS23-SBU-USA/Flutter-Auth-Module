part of '../riverpod/sign_in_providers.dart';

class SignInNotifier extends Notifier<BaseState> {
  late SignInUseCase signInUseCase;

  @override
  BaseState build() {
    signInUseCase = ref.read(signInUseCaseProvider);
    return const BaseState();
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      state = state.copyWith(status: BaseStatus.loading);

      final signInCredential = SignInCredential(
        email: email,
        password: password,
      );

      final result = await signInUseCase.call(
        requestBody: signInCredential.toMap(),
        rememberMeState: ref.read(rememberMeStateProvider),
        offlineState: ref.read(offlineStateProvider),
      );

      if (result.$1.isEmpty) {
        state = state.copyWith(
          status: BaseStatus.success,
          data: result.$2,
        );
      } else {
        state = state.copyWith(
          status: BaseStatus.failure,
          error: result.$1,
        );
      }
    } catch (e, stackTrace) {
      Log.debug(stackTrace.toString());
      state = state.copyWith(
        status: BaseStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> ssoSignIn() async {
    try {
      final result = await signInUseCase.ssoSignIn();
      ref.read(ssoUserProvider.notifier).state = result.$2;
      if (result.$1.isEmpty) {
        state = state.copyWith(
          status: BaseStatus.success,
          data: result.$2,
        );
      } else {
        state = state.copyWith(
          status: BaseStatus.failure,
          error: result.$1,
        );
      }
    } catch (e, stackTrace) {
      Log.debug(stackTrace.toString());
      state = state.copyWith(
        status: BaseStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> decideNextRoute() async {
    final result = await signInUseCase.decideNextRoute();

    if (result != null) {
      ref.read(isUserLoggedInProvider.notifier).state = true;
    }
  }

  Future<Map<String, String>?> getStoredCredentials() async {
    final result = await signInUseCase.getStoredCredentials();
    
    if (result != null) {
      return {
        'email': result['userEmail'],
        'password': result['password'],
      };
    } else {
      return null;
    }

   
  }

}
