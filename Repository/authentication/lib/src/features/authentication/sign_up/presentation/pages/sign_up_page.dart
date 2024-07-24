
import 'package:auth_module/src/core/notifiers/text_edtitting_controller_listener.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/theme/typography/fonts.dart';
import 'package:auth_module/src/core/utils/formatter/first_letter_upper_case.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/utils/validators/input_validators.dart';
import 'package:auth_module/src/core/widgets/password_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_back_button.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/password_validation_builder.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:auth_module/src/features/authentication/sign_up/presentation/riverpod/sign_up_providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/services/routes/route_generator.dart';

part '../widgets/sign_in_navigation_builder.dart';

part '../widgets/sign_up_form_builder.dart';

part '../widgets/terms_and_condition_checker_builder.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUpPage> {
  late TextEditingControllersListenable _textEditingControllersListenable;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _signUpButtonState = ValueNotifier(false);

  @override
  void initState() {
    _textEditingControllersListenable = TextEditingControllersListenable(
      controllers: [
        _firstNameController,
        _lastNameController,
        _emailController,
        _passwordController,
        _confirmPasswordController,
      ],
    );
    super.initState();
  }

  @override
  void dispose() {
    _textEditingControllersListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    ref.listen(
      signUpProvider,
      (previous, next) {
        if (next.status.isFailure) {
          ShowSnackBarMessage.showErrorSnackBar(
            message: next.error!,
            context: context,
          );
        } else if (next.status.isSuccess) {
          _navigateToIdentityVerificationPage();
        }
      },
    );

    _textEditingControllersListenable.addListener(
      () => _signUpButtonState.value =
          _textEditingControllersListenable.areNotEmpty,
    );

    return ScrollableWrapper(
      floatingActionButton: const BuildBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BuildTitleAndSubtitle(
            titleFirstPart: TextConstants.signUpTitleFirstPart,
            titleLastPart: TextConstants.signUpTitleLastPart,
            subtitleFirstPart: TextConstants.signUpSubtitleFirstPart,
            subtitleLastPart: TextConstants.signUpSubtitleLastPart,
          ),
          SizedBox(height: 60.h),
          Form(
            key: formKey,
            child: SignUpFormBuilder(
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              emailController: _emailController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
            ),
          ),
          SizedBox(height: 10.h),
          const TermsAndConditionCheckerBuilder(),
          SizedBox(height: 34.h),
          ValueListenableBuilder(
              valueListenable: _signUpButtonState,
              builder: (context, disable, child) {
                return FilledButton(
                  onPressed: signUpState.status.isLoading || disable
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            signUpNotifier.signUp();
                          }
                        },
                  child: signUpState.status.isLoading
                      ? Transform.scale(
                          scale: 0.75,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : const Text(
                          TextConstants.createAnAccount,
                        ),
                );
              }),
          SizedBox(height: 16.h),
          const _SignInNavigationBuilder(),
          SizedBox(height: 37.h),
        ],
      ),
    );
  }

  void _navigateToIdentityVerificationPage() {
    router.push(Routes.identityVerification, extra: {
      'email': _emailController.text,
      'isFromSignUp': true,
    });
  }
}
