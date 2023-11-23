import 'package:auth_module/src/core/base/state.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/data_sources/sign_in_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/models/sign_in_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:auth_module/src/features/profile/root/data/data_sources/profile_data_source.dart';
import 'package:auth_module/src/features/profile/root/data/models/profile_response_model.dart';
import 'package:auth_module/src/features/profile/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:auth_module/src/features/profile/user_profile/domain/repositories/user_profile_repsitories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';

import 'failed_responses.dart';
import 'success_responses.dart';

ProviderContainer provider() {
  final provider = ProviderContainer(parent: null);
  addTearDown(provider.dispose);
  return provider;
}

class MockUserProfileRepository extends Mock implements ProfileRepository {}

class MockProfileDataSource extends Mock implements ProfileDataSource {
  @override
  Future<Response<dynamic>> fetchUserProfile(String userId) async {
    if (userId == '64e88b944df82fd8cf42c065') {
      return Response<dynamic>(
        statusCode: 200,
        data: successFetchUserAPIData,
        requestOptions: RequestOptions(
          path: '',
        ),
      );
    } else {
      throw BadRequest(invalidUserData);
    }
  }
}

class MockSignInRepository extends Mock implements SignInRepository {}

class MockSignInDataSource extends Mock implements SignInDataSource {
  @override
  Future<Response> signIn({required Map<String, dynamic> requestBody}) async {
    if (requestBody['email'] == 'a@yopmail.com' &&
        requestBody['password'] == 'Aa@123456') {
      return Response<dynamic>(
        statusCode: 200,
        data: successSignInAPIData,
        requestOptions: RequestOptions(
          path: '',
        ),
      );
    } else if (requestBody['email'] != 'a@yopmail.com') {
      throw NotFound(noUserSignIn);
    } else {
      throw Unauthorized(invalidSignIn);
    }
  }
}

class MockSignInDataSourceOnline extends Mock implements SignInDataSource {}

class MockSignInUseCaseOnline extends Mock implements SignInUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Offline signIn test', () {
    test('Test for successful signIn', () {
      final mockSignInProvider = provider();
      final notifier = mockSignInProvider.read(signInProvider.notifier);

      notifier.emailController.text = 'foo@foo.com';
      notifier.passwordController.text = 'Foo@1234';
      notifier.offlineState = true;

      notifier.signIn;

      mockSignInProvider.listen(
        signInProvider,
        (previous, next) {
          expect(
            next.status,
            BaseStatus.success,
          );
        },
      );
    });

    test('Test for failed signIn', () {
      final mockSignInProvider = provider();

      mockSignInProvider.listen(
        signInProvider,
        (previous, next) {
          expect(
            next.status,
            BaseStatus.failure,
          );
        },
      );
      final notifier = mockSignInProvider.read(signInProvider.notifier);

      notifier.emailController.text = 'foo@foo.com';
      notifier.passwordController.text = 'Foo@1234';
      notifier.offlineState = true;

      notifier.signIn;
    });
  });

  group('Online signIn test', () {
    test('success', () async {
      final mockUserData = SignInModel.fromJson(successSignInAPIData);
      final mockDataSource = MockSignInDataSource();
      final mockUser = MockUserModel();

      final mockRepository = SignInRepositoryImp(
        dataSource: mockDataSource,
        mockUser: mockUser,
      );

      final userSignInInfo = await mockRepository.signIn(
        email: 'a@yopmail.com',
        password: 'Aa@123456',
        rememberMeState: false,
      );

      expect(userSignInInfo.$2!.user.firstName, mockUserData.user.firstName);
    });

    test('failure on Invalid Credential', () async {
      final mockDataSource = MockSignInDataSource();
      final mockUser = MockUserModel();

      final mockRepository = SignInRepositoryImp(
        dataSource: mockDataSource,
        mockUser: mockUser,
      );

      final userSignInInfo = await mockRepository.signIn(
        email: 'a@yopmail.com',
        password: 'Aa@12345',
        rememberMeState: false,
      );

      expect(userSignInInfo.$1, 'Invalid credentials.');
    });

    test('failure on User not found', () async {
      final mockDataSource = MockSignInDataSource();
      final mockUser = MockUserModel();

      final mockRepository = SignInRepositoryImp(
        dataSource: mockDataSource,
        mockUser: mockUser,
      );

      final userSignInInfo = await mockRepository.signIn(
        email: 'a@yopmail',
        password: 'Aa@12345',
        rememberMeState: false,
      );

      expect(userSignInInfo.$1, 'User not found !');
    });
  });

  group('Fetch user info ', () {
    test('Success', () async {
      final mockUserData =
          ProfileResponseModel.fromJson(successFetchUserAPIData);
      final mockDataSource = MockProfileDataSource();
      final mockRepository = ProfileRepositoryImp(dataSource: mockDataSource);
      const String userId = '64e88b944df82fd8cf42c065';

      final userProfileInfo = await mockRepository.fetchUserProfile(userId);

      expect(userProfileInfo.$2!.email, mockUserData.data.email);
    });

    test('failed on Invalid request', () async {
      final mockDataSource = MockProfileDataSource();
      final mockRepository = ProfileRepositoryImp(dataSource: mockDataSource);
      const String userId = '64e88b944df82fd8cf42c06';

      final userProfileInfo = await mockRepository.fetchUserProfile(userId);

      expect(userProfileInfo.$1, 'Invalid requested Id');
    });
  });

  group('API signIn test', () {
    test(
      'Test for failed signIn',
      () async {
        final mockSignInProvider = provider();

        final notifier = mockSignInProvider.read(signInProvider.notifier);

        notifier.emailController.text = 'a@yopmail.com';
        notifier.passwordController.text = 'Aa@123456';
        notifier.offlineState = false;

        await notifier.signIn();

        final state = mockSignInProvider.read(signInProvider);

        expect(state.status, BaseStatus.failure);
      },
    );
  });
}
