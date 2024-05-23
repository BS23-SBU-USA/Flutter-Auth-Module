import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/presentation/riverpod/forgot_password_provider.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/features/authentication/forgot_password/dashboard/domain/use_case/forgot_password_use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'forgot_password_state.dart';

final forgotPasswordProvider =
    AutoDisposeNotifierProvider<ForgotPasswordNotifier, BaseState>(
  ForgotPasswordNotifier.new,
  name: 'forgotPasswordProvider',
);

class ForgotPasswordNotifier extends AutoDisposeNotifier<BaseState> {
  late ForgotPasswordUseCase useCase;

  @override
  BaseState build() {
    useCase = ref.read(forgotPasswordUseCaseProvider);
    return const BaseState();
  }

  Future<void> forgotPasswordSubmit(
    String email,
  ) async {
    try {
      state = state.copyWith(status: BaseStatus.loading);

      final requestBody = <String, dynamic>{
        'email': email,
      };

      final response = await useCase.call(
        requestBody: requestBody,
        offlineState: ref.read(offlineStateProvider),
      );

      if (response.$1.isEmpty) {
        state = state.copyWith(
          status: BaseStatus.success,
        );
      } else {
        state = state.copyWith(
          status: BaseStatus.failure,
          error: response.$1,
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
}
