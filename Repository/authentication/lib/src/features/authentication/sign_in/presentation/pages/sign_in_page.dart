import 'dart:developer';

import 'package:auth_module/src/core/theme/typography/fonts.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/utils/validators/input_validators.dart';
import 'package:auth_module/src/core/widgets/password_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:auth_module/src/core/notifiers/text_edtitting_controller_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../core/services/routes/route_generator.dart';

part '../widgets/remember_me_and_forget_pass_builder.dart';

part '../widgets/sign_in_form_builder.dart';

part '../widgets/sign_up_navigation_builder.dart';

part '../widgets/single_sign_on.dart';

part '../widgets/social_logo.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late TextEditingControllersListenable _textEditingControllersListenable;
  final ValueNotifier<bool> _signInButtonState = ValueNotifier(false);
  bool _rememberMe = false;
  @override
  void initState() {
    super.initState();
    _textEditingControllersListenable =
        TextEditingControllersListenable(controllers: [
      _emailController,
      _passwordController,
    ]);
    getData();
    Future(() {
      ref.read(signInProvider.notifier).decideNextRoute();
    });
  }

  Future getData() async {
    Map<String, String>? result =
        await ref.read(signInProvider.notifier).getStoredCredentials();
    log(result.toString());
    if (result != null) {
      _rememberMe = true;
      _emailController.text = result['email']!;
      _passwordController.text = result['password']!;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _textEditingControllersListenable.dispose();
    _signInButtonState.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signInProvider);
    final notifier = ref.read(signInProvider.notifier);
    ref
      ..listen(isUserLoggedInProvider, (_, next) {
        if (next) {
          navigateToDashboardPage();
        }
      })
      ..listen(signInProvider, (previous, next) {
        if (next.status.isFailure) {
          ShowSnackBarMessage.showErrorSnackBar(
            message: next.error!,
            context: context,
          );
        } else if (next.status.isSuccess) {
          navigateToDashboardPage();
        }
      });

    _textEditingControllersListenable.addListener(() {
      _signInButtonState.value = !_textEditingControllersListenable.areNotEmpty;
    });

    return ScrollableWrapper(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          _buildOfflineButton(),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BuildTitleAndSubtitle(
            titleFirstPart: TextConstants.signInTitleFirstPart,
            titleLastPart: TextConstants.signInTitleLastPart,
            subtitleFirstPart: TextConstants.signInSubtitleFirstPart,
            subtitleLastPart: TextConstants.signInSubtitleLastPart,
          ),
          SizedBox(height: 30.h),
          const SingleSignOn(),
          SizedBox(height: 30.h),
          _SignInFormBuilder(
            emailController: _emailController,
            passwordController: _passwordController,
            formKey: formKey,
          ),
          const _RememberMeAndForgetPassBuilder(),
          SizedBox(height: 177.h),
          ValueListenableBuilder(
              valueListenable: _signInButtonState,
              builder: (context, buttonState, child) {
                return FilledButton(
                  onPressed: (state.status.isLoading || buttonState == false)
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            notifier.signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                  child: (state.status.isLoading)
                      ? Transform.scale(
                          scale: 0.75,
                          child: const CircularProgressIndicator(),
                        )
                      : const Text(
                          TextConstants.login,
                        ),
                );
              }),
          SizedBox(height: 16.h),
          const _SignUpNavigationBuilder(),
        ],
      ),
    );
  }

  Widget _buildOfflineButton() {
    final state = ref.watch(offlineStateProvider);
    final notifier = ref.read(offlineStateProvider.notifier);
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Row(
        children: [
          Text(
            TextConstants.offline,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: state,
              activeColor: theme.colorScheme.primary,
              trackColor: theme.colorScheme.secondary,
              thumbColor: theme.colorScheme.onPrimary,
              onChanged: (value) {
                notifier.state = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigateToDashboardPage() {
    router.go(Routes.home);
  }
}
