part of '../riverpod/sign_up_providers.dart';

class SignUpNotifier extends Notifier<BaseState> {
  late SignUpUseCase signUpUseCase;

  @override
  BaseState build() {
    signUpUseCase = ref.read(signUpUseCaseProvider);
    return const BaseState();
  }

  Future<void> signUp() async {
    try {
      state = state.copyWith(status: BaseStatus.loading);

      final signUpCredential = SignUpCredential(
        firstname: ref.read(signUpFirstNameStateProvider.notifier).state.text,
        lastname: ref.read(signUpSecondNameStateProvider.notifier).state.text,
        email: ref.read(signUpEmailStateProvider.notifier).state.text,
        password: ref.read(signUpPasswordStateProvider.notifier).state.text,
      );

      final result = await signUpUseCase.call(
        requestBody: signUpCredential.toMap(),
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

  void capitalizeFirstLetter(TextEditingController controller) {
    final text = controller.text;
    final newText = text.replaceAllMapped(
      RegExp(r'\b\w'),
      (match) => match.group(0)!.toUpperCase(),
    );

    if (newText != text) {
      final newSelectionOffset = newText.length;
      controller.value = controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newSelectionOffset),
      );
    }
  }
}
