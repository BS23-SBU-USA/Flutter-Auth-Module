part of '../riverpod/sign_up_providers.dart';

class SignUpNotifier extends AutoDisposeNotifier<BaseState> {
  late SignUpUseCase signUpUseCase;

  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  BaseState build() {
    signUpUseCase = ref.read(signUpUseCaseProvider);
    return const BaseState();
  }

  Future<void> signUp() async {
    try {
      if (!formKey.currentState!.validate()) return;

      state = state.copyWith(status: BaseStatus.loading);

      final requestBody = <String, dynamic>{
        'firstname': firstNameController.text,
        'lastname': secondNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };

      final result = await signUpUseCase.call(
        requestBody: requestBody,
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
