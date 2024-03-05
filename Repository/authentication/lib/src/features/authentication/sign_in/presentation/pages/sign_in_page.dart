import 'dart:developer';

import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/utils/validators//input_validators.dart';
import 'package:auth_module/src/core/widgets/button/button.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/scrollable_wrapper.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/widgets/cutom_text_field.dart';

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
  late MaterialStatesController _signInButtonStateController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  @override
  void initState() {
    super.initState();
    _signInButtonStateController = MaterialStatesController();
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
    // TODO: implement dispose
    _signInButtonStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final buttonState = ref.watch(buttonStateProvider);
    final state = ref.watch(signInProvider);
    final notifier = ref.read(signInProvider.notifier);

    if (state.status == BaseStatus.loading) {
      _signInButtonStateController.update(MaterialState.selected, true);
    }
    // if (buttonState) {
    //   _signInButtonStateController.update(MaterialState.disabled, false);
    // } else {
    //   _signInButtonStateController.update(MaterialState.disabled, true);
    // }

    ref
      ..listen(isUserLoggedInProvider, (_, next) {
        if (next) {
          navigateToDashboardPage();
        }
      })
      ..listen(signInProvider, (previous, next) {
        if (next.status == BaseStatus.success) {
          navigateToDashboardPage();
        }
      });
    // ..listen(
    //   signInProvider,
    //   (previous, next) {
    //     if (next.status == BaseStatus.failure) {
    //       ShowSnackBarMessage.showErrorSnackBar(
    //         message: next.error!,
    //         context: context,
    //       );
    //     } else if (next.status == BaseStatus.success) {
    //       navigateToDashboardPage();
    //     }
    //   },
    // )

    return ScrollableWrapper(
      appBar: AppBar(
        backgroundColor: UIColors.white,
        elevation: 0,
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
          OutlinedButton(
            statesController: _signInButtonStateController,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                notifier.signIn(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              }
            },
            child: (state.status == BaseStatus.loading)
                ? Transform.scale(
                    scale: 0.75,
                    child: const CircularProgressIndicator(
                      color: UIColors.pineGreen,
                    ),
                  )
                : const Text(TextConstants.login),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Button(
          //   onPressed: () {
          //     if (formKey.currentState!.validate()) {
          //       formKey.currentState!.save();
          //       final email = _email;
          //       final password = _password;
          //       log(email + " " + password);
          //       notifier.signIn(
          //         email: email,
          //         password: password,
          //       );
          //     }
          //   },
          //   isLoading: state.status == BaseStatus.loading,
          //   label: TextConstants.login,
          //   textStyle: !buttonState
          //       ? AppTypography.semiBold16Caros(color: UIColors.gray)
          //       : AppTypography.semiBold16Caros(color: UIColors.white),
          //   disable: !buttonState,
          // ),
          SizedBox(height: 16.h),
          const _SignUpNavigationBuilder(),
        ],
      ),
    );
  }

  Widget _buildOfflineButton() {
    final state = ref.watch(offlineStateProvider);
    final notifier = ref.read(offlineStateProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Row(
        children: [
          Text(
            TextConstants.offline,
            style: AppTypography.bold14Caros(
              color: UIColors.pineGreen,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: state,
              activeColor: UIColors.pineGreen,
              trackColor: UIColors.gray,
              thumbColor: UIColors.white,
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
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.home,
      (route) => false,
    );
  }
}
