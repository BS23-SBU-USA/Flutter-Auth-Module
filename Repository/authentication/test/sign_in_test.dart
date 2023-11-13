import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

ProviderContainer mockSignInProvider() {
  final mockSignInProvider = ProviderContainer(parent: null);
  addTearDown(mockSignInProvider.dispose);
  return mockSignInProvider;
}

class MockSignInUseCase extends Mock implements SignInUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Offline signIn test', () {
    test('Test for successful signIn', () {
      final mockContainer = mockSignInProvider();
      final notifier = mockContainer.read(signInProvider.notifier);

      notifier.emailController.text = 'foo@foo.com';
      notifier.passwordController.text = 'Foo@1234';
      notifier.offlineState = true;

      notifier.signIn;
      mockContainer.listen(
        signInProvider,
        (previous, next) {
          expect(
            previous!.status,
            BaseStatus.initial,
          );
          expect(
            next.status,
            BaseStatus.success,
          );
        },
      );
    });
    test('Test for failed signIn', () {
      final mockContainer = mockSignInProvider();

      mockContainer.listen(
        signInProvider,
        (previous, next) {
          expect(
            previous!.status,
            BaseStatus.initial,
          );
          expect(
            next.status,
            BaseStatus.success,
          );
        },
      );
      final notifier = mockContainer.read(signInProvider.notifier);

      notifier.emailController.text = 'foo@foo.com';
      notifier.passwordController.text = 'Foo@1234';
      notifier.offlineState = true;

      notifier.signIn;
    });
  });
}
