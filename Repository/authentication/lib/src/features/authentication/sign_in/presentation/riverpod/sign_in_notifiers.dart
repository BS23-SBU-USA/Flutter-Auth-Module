part of '../riverpod/sign_in_providers.dart';

class SignInNotifier extends Notifier<BaseState> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late SignInUseCase signInUseCase;

  @override
  BaseState build() {
    signInUseCase = ref.read(signInUseCaseProvider);
    ref.onDispose(_clearFields);
    return const BaseState();
  }

  Future<void> signIn() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      final email = emailController.text;
      final password = passwordController.text;

      state = state.copyWith(status: BaseStatus.loading);

      final result = await signInUseCase.call(
        email: email,
        password: password,
        rememberMeState: ref.read(rememberMeStateProvider),
        offlineState: ref.read(offlineStateProvider),
      );

      if (result.$1!.isEmpty) {
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

  Future<void> getStoredCredentials() async {
    final result = await signInUseCase.getStoredCredentials();

    if (result != null) {
      emailController.text = result['userEmail'];
      passwordController.text = result['password'];

      ref.read(rememberMeStateProvider.notifier).state = true;
    }
  }

  void _clearFields() {
    emailController.clear();
    passwordController.clear();
  }
}
