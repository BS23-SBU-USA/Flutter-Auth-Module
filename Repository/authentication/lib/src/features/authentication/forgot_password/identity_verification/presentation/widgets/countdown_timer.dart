import 'dart:async';

import 'package:auth_module/src/core/theme/app_theme/context_extension.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/features/authentication/forgot_password/identity_verification/presentation/riverpod/identity_verification_notifier.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownTimer extends ConsumerStatefulWidget {
  const CountdownTimer({
    super.key,
  });

  @override
  ConsumerState<CountdownTimer> createState() => CountdownTimerState();
}

class CountdownTimerState extends ConsumerState<CountdownTimer> {
  late Timer _timer;

  int _secondsRemaining = 30;
  bool showResendButton = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');

    final state = ref.watch(identityVerificationProvider);
    final offlineState = ref.watch(offlineStateProvider);

    ref.listen(
      identityVerificationProvider,
      (_, next) {
        if (next.status == IdentityVerificationStatus.success &&
            !_timer.isActive) {
          _startTimer();
          showResendButton = false;
        } else if (next.status == IdentityVerificationStatus.failure &&
            _secondsRemaining <= 0) {
          showResendButton = true;
        }
      },
    );

    return GestureDetector(
      onTap: () async {
        if (state.status == IdentityVerificationStatus.loading) return;

        if (showResendButton) {
          setState(() {
            _resetTimer();
            showResendButton = false;
            ref
                .read(identityVerificationProvider.notifier)
                .resendOTPToEmail(offlineState);
          });
        }
      },
      child: Text(
        showResendButton
            ? TextConstants.resendEmail
            : '${TextConstants.resendEmail} in ${seconds}s',
        style: context.theme.text.semiBold14Circular
            .copyWith(color: context.theme.color.pineGreen),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_secondsRemaining <= 0) {
          timer.cancel();
          showResendButton = true;
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _secondsRemaining = 30;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
