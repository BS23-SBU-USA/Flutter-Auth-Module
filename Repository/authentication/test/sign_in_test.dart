import 'package:auth_module/src/core/services/device_info/device_info_service.dart';
import 'package:auth_module/src/core/services/network/error_model.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/data_sources/sign_in_data_source.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/models/sign_in_model.dart';
import 'package:auth_module/src/features/authentication/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:auth_module/src/features/authentication/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:auth_module/src/features/profile/root/data/data_sources/profile_data_source.dart';
import 'package:auth_module/src/features/profile/user_profile/domain/repositories/user_profile_repsitories.dart';
import 'package:dio/dio.dart';
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
        data: successFetchUserData,
        requestOptions: RequestOptions(
          path: '',
        ), // Replace with your RequestOptions
      );
    } else {
      return Response<dynamic>(
        statusCode: 401,
        data: wrongSignIn,
        requestOptions: RequestOptions(
          path: '',
        ), // Replace with your RequestOptions
      );
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
        data: successSignInData,
        requestOptions: RequestOptions(
          path: '',
        ), // Replace with your RequestOptions
      );
    } else if (requestBody['email'] != 'a@yopmail.com') {
      return Response<dynamic>(
        statusCode: 401,
        data: failedSignIn,
        requestOptions: RequestOptions(
          path: '',
        ), // Replace with your RequestOptions
      );
    } else {
      return Response<dynamic>(
        statusCode: 401,
        data: wrongSignIn,
        requestOptions: RequestOptions(
          path: '',
        ), // Replace with your RequestOptions
      );
    }
  }
}

class MockDeviceInfo extends Mock implements DeviceInfoService {
  @override
  Future<String> getDeviceOS() async {
    return TextConstants.android;
  }

  @override
  Future<String> getDeviceModel() async {
    return 'model';
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // group('Offline signIn test', () {
  //   test('Test for successful signIn', () {
  //     final mockSignInProvider = provider();
  //     final notifier = mockSignInProvider.read(signInProvider.notifier);
  //
  //     notifier.emailController.text = 'foo@foo.com';
  //     notifier.passwordController.text = 'Foo@1234';
  //     notifier.offlineState = true;
  //
  //     notifier.signIn;
  //
  //     mockSignInProvider.listen(
  //       signInProvider,
  //       (previous, next) {
  //         expect(
  //           previous!.status,
  //           BaseStatus.initial,
  //         );
  //         expect(
  //           next.status,
  //           BaseStatus.success,
  //         );
  //       },
  //     );
  //   });
  //   test('Test for failed signIn', () {
  //     final mockSignInProvider = provider();
  //
  //     mockSignInProvider.listen(
  //       signInProvider,
  //       (previous, next) {
  //         expect(
  //           previous!.status,
  //           BaseStatus.initial,
  //         );
  //         expect(
  //           next.status,
  //           BaseStatus.success,
  //         );
  //       },
  //     );
  //     final notifier = mockSignInProvider.read(signInProvider.notifier);
  //
  //     notifier.emailController.text = 'foo@foo.com';
  //     notifier.passwordController.text = 'Foo@1234';
  //     notifier.offlineState = true;
  //
  //     notifier.signIn;
  //   });
  // });

  // group('Fetch user info ', () {
  //   test('Success', () async {
  //     final mockUserData = ProfileResponseModel.fromJson(userData);
  //     final mockDataSource = MockProfileDataSource();
  //     final mockRepository = ProfileRepositoryImp(dataSource: mockDataSource);
  //     const String userId = '64e88b944df82fd8cf42c065';
  //
  //     final userProfileInfo = await mockRepository.fetchUserProfile(userId);
  //
  //     expect(userProfileInfo.$2!.email, mockUserData.data.email);
  //   });
  //
  //   test('failed', () async {
  //     final mockDataSource = MockProfileDataSource();
  //     final mockRepository = ProfileRepositoryImp(dataSource: mockDataSource);
  //     const String userId = '64e88b944df82fd8cf42c06';
  //
  //     final userProfileInfo = await mockRepository.fetchUserProfile(userId);
  //
  //     expect(userProfileInfo.$1,
  //         "type \'_TypeError\' is not a subtype of type \'Failure\' in type cast");
  //   });
  // });

  group('Online signIn test', () {
    // test('success', () async {
    //   final mockSuccess = SignInModel.fromJson(successSignInData);
    //   final mockDataSource = MockSignInDataSource();
    //   final mockUser = MockUserModel();
    //   final mockRepository = SignInRepositoryImp(
    //     dataSource: mockDataSource,
    //     mockUser: mockUser,
    //   );
    //
    //   final userSignInInfo = await mockRepository.signIn(
    //     email: 'a@yopmail.com',
    //     password: 'Aa@123456',
    //     rememberMeState: false,
    //   );
    //
    //   expect(userSignInInfo.$2?.user.firstName, mockSuccess.user.firstName);
    // });

    // test('failure on Invalid', () async {
    //   final mockFailure = ErrorModel.fromJson((wrongSignIn as Failure).error);
    //
    //   final mockDataSource = MockSignInDataSource();
    //   final mockUser = MockUserModel();
    //
    //   final mockRepository = SignInRepositoryImp(
    //     dataSource: mockDataSource,
    //     mockUser: mockUser,
    //   );
    //
    //   final userSignInInfo = await mockRepository.signIn(
    //     email: 'a@yopmail.com',
    //     password: 'Aa@124',
    //     rememberMeState: false,
    //   );
    //
    //   expect(userSignInInfo.$1, mockFailure.message);
    // });

    test('failure on not found user', () async {
      //  final mockFailure = ErrorModel.fromJson((failedSignIn as Failure).error);

      final mockDataSource = MockSignInDataSource();
      final mockUser = MockUserModel();

      final mockRepository = SignInRepositoryImp(
        dataSource: mockDataSource,
        mockUser: mockUser,
      );

      final userSignInInfo = await mockRepository.signIn(
        email: 'a@yopmail.co',
        password: 'Aa@124',
        rememberMeState: false,
      );

      expect(userSignInInfo.$1, 'not found');
    });
  });
}
