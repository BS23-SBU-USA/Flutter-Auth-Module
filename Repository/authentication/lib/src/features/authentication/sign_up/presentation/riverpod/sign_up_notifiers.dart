part of '../riverpod/sign_up_providers.dart';

class SignUpNotifier extends StateNotifier<BaseState> {
  SignUpNotifier(this.signUpUseCase) : super(const BaseState());
  final SignUpUseCase signUpUseCase;

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController1 = TextEditingController();
  final TextEditingController nameController2 = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late bool offlineState;

  Future<void> signUp(bool offlineState) async {
    try {
      if (!formKey.currentState!.validate()) return;

      if (offlineState) {
        offlineSignUp();
        return;
      }

      state = state.copyWith(status: BaseStatus.loading);
      final requestBody = <String, dynamic>{
        'firstname': nameController1.text,
        'lastname': nameController2.text,
        'email': emailController.text,
        'password': passwordController.text,
      };

      final result = await signUpUseCase.call(requestBody: requestBody);

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

  void offlineSignUp() {
    final firstName = nameController1.text;
    final lastName = nameController2.text;
    final email = emailController.text;
    final password = passwordController.text;

    final mockUserModel = MockUserModel();

    signUpUseCase.offlineSignUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    state = state.copyWith(
      status: BaseStatus.success,
    );

    mockUserModel.firstName = firstName;
    mockUserModel.lastName = lastName;
    mockUserModel.email = email;
    mockUserModel.password = password;
  }
}
