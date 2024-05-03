// ignore_for_file: library_private_types_in_public_api, avoid_dynamic_calls
// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: use_build_context_synchronously

import 'package:auth_module/src/core/theme/typography/fonts.dart';
import 'package:auth_module/src/core/utils/loggers/logger.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/widgets/avatar.dart';
import 'package:auth_module/src/core/widgets/name_with_letter.dart';
import 'package:auth_module/src/features/authentication/root/presentation/riverpod/mock_user/mock_user_provider.dart';
import 'package:auth_module/src/features/authentication/sign_in/presentation/riverpod/sign_in_providers.dart';
import 'package:auth_module/src/features/home/presentation/widget/drawer_builder.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_info_provider.dart';
import 'package:auth_module/src/features/profile/user_profile/presentation/riverpod/user_profile_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future(initializationProfile);
  }

  Future<void> initializationProfile() async {
    String? userID;
    await ref.read(userProfileInfoProvider.notifier).fetchUserProfile(userID);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(userProfileInfoProvider);
    final updateState = ref.watch(updateProfileInfoProvider);
    final mockUser = ref.read(mockUserProvider);
    final offlineState = ref.read(offlineStateProvider.notifier).state;
    final ssoState = ref.read(ssoSignInProvider.notifier).state;
    final ssoUser = ref.read(ssoUserProvider.notifier).state;
    final name = NameInitials.getInitialsFromFullName(
      offlineState ? mockUser.fullName : profileState.data?.fullName ?? '',
    );

    Log.debug('user');
    Log.debug(ssoUser.toString());

    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primary,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: (offlineState)
                    ? Avatar.circleWithFullName(
                        height: 30.r,
                        width: 30.r,
                        borderColor: UIColors.pineGreen,
                        backgroundColor: UIColors.celeste,
                        nameWithLetter: name,
                      )
                    : ssoState
                        ? Avatar.circle(
                            url: ssoUser?.photoUrl ?? '',
                            height: 30.r,
                            width: 30.r,
                            borderColor: color.outline,
                          )
                        : (profileState.status.isLoading ||
                                updateState.status.isLoading)
                            ? Center(
                                child: SizedBox(
                                  height: 20.sp,
                                  width: 20.sp,
                                  child: CircularProgressIndicator(
                                    color: color.onPrimary,
                                    strokeWidth: 2.sp,
                                  ),
                                ),
                              )
                            : profileState.status.isFailure
                                ? const Text(TextConstants.somethingWentWrong)
                                : profileState.data?.avatar != null
                                    ? Avatar.circle(
                                        url: profileState.data!.avatar!,
                                        height: 30.r,
                                        width: 30.r,
                                        borderColor: color.outline,
                                      )
                                    : Avatar.circleWithFullName(
                                        height: 30.r,
                                        width: 30.r,
                                        borderColor: color.outline,
                                        backgroundColor: color.primaryContainer,
                                        nameWithLetter: name,
                                      ),
              ),
            );
          },
        ),
        title: Text(
          offlineState
              ? '${mockUser.firstName} ${mockUser.lastName}'
              : ssoState
                  ? ssoUser?.displayName ?? 'User Name'
                  : (profileState.status.isLoading ||
                          updateState.status.isLoading)
                      ? TextConstants.connecting
                      : '${profileState.data?.firstname} '
                          '${profileState.data?.lastname}',
          style: text.titleMedium!.copyWith(
            fontWeight: FontWeightManager.semiBold,
            color: color.onPrimary,
          ),
        ),
        centerTitle: false,
      ),
      drawer: const DrawerBuilder(),
      body: Center(
        child: Text(
          offlineState
              ? 'Hello\n${mockUser.firstName} ${mockUser.lastName}!'
              : ssoState
                  ? 'Hello\n${ssoUser?.displayName ?? 'User Name'}'
                  : (profileState.status.isLoading ||
                          updateState.status.isLoading)
                      ? ''
                      : 'Hello\n${profileState.data?.firstname} ${profileState.data?.lastname}!',
          style: text.headlineSmall!.copyWith(
            fontWeight: FontWeightManager.bold,
            color: color.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
