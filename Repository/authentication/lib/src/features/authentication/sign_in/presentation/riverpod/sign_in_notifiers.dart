part of '../riverpod/sign_in_providers.dart';

class SignInNotifier extends Notifier<BaseState> {
  late SignInUseCase signInUseCase;

  @override
  BaseState build() {
    signInUseCase = ref.read(signInUseCaseProvider);
    ref.onDispose(_clearFields);
    return const BaseState();
  }

  Future<void> signIn() async {
    try {
      state = state.copyWith(status: BaseStatus.loading);

      final signInCredential = SignInCredential(
        email: ref.read(signInEmailStateProvider.notifier).state.text,
        password: ref.read(signInPasswordStateProvider.notifier).state.text,
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

  Future<void> ssoSignIn({required BuildContext context}) async {
    try {
      final result = await signInUseCase.ssoSignIn(context: context);
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

  Future<void> authConfigure() async {
    final result = await signInUseCase.authConfigure();

    ref.read(logoVisibilityStateProvider.notifier).state =
        result.logoVisibility;
    ref.read(ssoVisibilityStateProvider.notifier).state = result.ssoVisibility;
    ref.read(userOptionStateProvider.notifier).state = result.userOption;
  }

  Future<void> decideNextRoute() async {
    final result = await signInUseCase.decideNextRoute();

    if (result != null) {
      ref.read(isUserLoggedInProvider.notifier).state = true;
    }
  }

  Future<void> getStoredCredentials() async {
    final result = await signInUseCase.getStoredCredentials();

    if (result != null) {
      ref.read(signInEmailStateProvider.notifier).state.text =
          result['userEmail'];
      ref.read(signInPasswordStateProvider.notifier).state.text =
          result['password'];
      ref.read(rememberMeStateProvider.notifier).state = true;
    }
  }

  void _clearFields() {
    ref.read(signInEmailStateProvider.notifier).state = TextEditingController();
    ref.read(signInPasswordStateProvider.notifier).state =
        TextEditingController();
  }
}
