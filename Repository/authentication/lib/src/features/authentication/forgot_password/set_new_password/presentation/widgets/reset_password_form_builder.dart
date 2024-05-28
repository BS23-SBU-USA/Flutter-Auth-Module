part of '../pages/set_new_password_page.dart';

class _ResetPasswordFormBuilder extends ConsumerWidget {
  const _ResetPasswordFormBuilder({
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(setNewPasswordFormKeyStateProvider.notifier).state,
      child: Column(
        children: [
         

          
        ],
      ),
    );
  }
}
