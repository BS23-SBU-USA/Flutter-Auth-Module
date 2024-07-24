part of '../pages/forgot_password_page.dart';

class _EmailField extends ConsumerWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(forgotPasswordFormKeyStateProvider.notifier).state,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: InputValidators.email,
        controller: ref.read(forgotPasswordEmailStateProvider.notifier).state,
        decoration: const InputDecoration(
          labelText: TextConstants.yourEmail,
        ),
        onChanged: (value) {
          ref.read(forgotPassButtonStateProvider.notifier).state =
              value.isNotEmpty;
        },
      )
      
      
      
      
      

     
    );
  }
}
