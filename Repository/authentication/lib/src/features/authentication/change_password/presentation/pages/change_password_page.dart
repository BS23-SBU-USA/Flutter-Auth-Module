import 'package:auth_module/src/core/services/routes/routes.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/widgets/password_field.dart';
import 'package:auth_module/src/core/widgets/primary_snackbar.dart';
import 'package:auth_module/src/features/authentication/change_password/presentation/riverpod/change_password_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/password_validity/password_validity_provider.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/build_title.dart';
import 'package:auth_module/src/features/authentication/root/presentation/widgets/password_validation_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../core/notifiers/text_edtitting_controller_listener.dart';
import '../../../../../core/services/routes/route_generator.dart';

part '../widgets/change_password_form_builder.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  late TextEditingControllersListenable _textEditingControllersListenable;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> _buttonState = ValueNotifier(true);

  @override
  void initState() {
    _textEditingControllersListenable = TextEditingControllersListenable(
      controllers: [
        currentPasswordController,
        newPasswordController,
        confirmPasswordController,
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
    final state = ref.watch(changePasswordProvider);
    ref.listen(changePasswordProvider, (_, next) {
      if (next.status == ChangePasswordStatus.success) {
        _onSuccess(context);
      } else if (next.status == ChangePasswordStatus.failure) {
        _onError(next, context);
      }
    });

    _textEditingControllersListenable.addListener(
      () => _buttonState.value = _textEditingControllersListenable.areNotEmpty,
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Row(
              children: [
                SizedBox(width: 24.sp),
                SizedBox(
                  width: 24.sp,
                  height: 24.sp,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(
                      Assets.images.backIcon,
                      width: 8.sp,
                      height: 12.sp,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onBackground,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 60.sp),
              const BuildTitleAndSubtitle(
                titleFirstPart: TextConstants.changePasswordTitleFirstPart,
                titleLastPart: TextConstants.changePasswordTitleLastPart,
                subtitleFirstPart:
                    TextConstants.changePasswordSubtitleFirstPart,
                subtitleLastPart: TextConstants.changePasswordSubtitleLastPart,
              ),
              SizedBox(height: 70.sp),
              Form(
                key: _formKey,
                child: ChangePasswordFormBuilder(
                  oldPasswordController: currentPasswordController,
                  newPasswordController: newPasswordController,
                  confirmPasswordController: confirmPasswordController,
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: _buttonState,
                  builder: (context, disable, child) {
                    return FilledButton(
                      onPressed: state.status == ChangePasswordStatus.loading ||
                              disable
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(changePasswordProvider.notifier)
                                    .changePassword(
                                      oldPassword:
                                          currentPasswordController.text.trim(),
                                      newPassword:
                                          newPasswordController.text.trim(),
                                      confirmPassword:
                                          confirmPasswordController.text.trim(),
                                    );
                              } else {
                                ShowSnackBarMessage.showErrorSnackBar(
                                  message:
                                      TextConstants.passwordFieldsNotMatched,
                                  context: context,
                                );
                              }
                            },
                      child: state.status == ChangePasswordStatus.loading
                          ? Transform.scale(
                              scale: 0.75,
                              child: const CircularProgressIndicator(),
                            )
                          : const Text(
                              TextConstants.changePassword,
                            ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _onSuccess(BuildContext context) {
    ShowSnackBarMessage.showSuccessSnackBar(
      message: TextConstants.passwordChangeSuccess,
      context: context,
    );
    _navigateToSignIn();
  }

  void _onError(ChangePasswordState state, BuildContext context) {
    ShowSnackBarMessage.showErrorSnackBar(
      message: state.errorMessage,
      context: context,
    );
  }

  void _navigateToSignIn() {
    router.go(Routes.signIn);
  }
}
