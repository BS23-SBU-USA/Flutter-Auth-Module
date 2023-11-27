import 'package:auth_module/src/core/services/device_info/device_info_service.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/entities/sign_in_entity.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInUseCaseProvider = Provider<SignInUseCase>(
  (ref) {
    final repository = ref.read(signInRepositoryProvider);
    return SignInUseCase(repository: repository);
  },
);

class SignInUseCase {
  const SignInUseCase({required this.repository});

  final SignInRepository repository;

  Future<(String, dynamic)> call({
    required String email,
    required String password,
    required bool offlineState,
    required bool rememberMeState,
  }) async {
    final deviceOS =
        offlineState ? 'Android' : await DeviceInfoService().getDeviceOS();
    final deviceModel = offlineState
        ? 'Unknown Device'
        : await DeviceInfoService().getDeviceModel();

    final userCredential = UserCredential(
      email: email,
      password: password,
      deviceOS: deviceOS,
      deviceModel: deviceModel,
      fcmToken: 'Token',
    );

    return repository.signIn(
      requestBody: userCredential.toMap(),
      offlineState: offlineState,
      rememberMeState: rememberMeState,
    );
  }

  Future<Map<String, dynamic>?> getStoredCredentials() async {
    return repository.getStoredCredentials();
  }

  Future<String?> decideNextRoute() async {
    return repository.decideNextRoute();
  }
}
