// ignore_for_file: must_be_immutable, avoid_dynamic_calls

part of '../widget/drawer_builder.dart';

class DrawerHeaderWidget extends ConsumerWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(userProfileInfoProvider);
    final updateState = ref.watch(updateProfileInfoProvider);
    final offlineState = ref.read(offlineStateProvider.notifier).state;
    final ssoNotifier = ref.read(ssoSignInProvider.notifier).state;
    final user = ref.read(ssoUserProvider.notifier).state;
    final mockUser = ref.read(mockUserProvider);

    final name = NameInitials.getInitialsFromFullName(
        offlineState ? mockUser.fullName : profileState.data?.fullName ?? '');

    if ((profileState.status.isLoading || updateState.status.isLoading) &&
        (!ssoNotifier && !offlineState)) {
      return const Center(
        child: CircularProgressIndicator(
          color: UIColors.white,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ssoNotifier)
          CircleAvatar(
            backgroundImage: NetworkImage(user!.photoUrl ?? ''),
            backgroundColor: UIColors.pineGreen,
            radius: 30,
          )
        else
          (offlineState || profileState.data!.avatar == null)
              ? Avatar.circleWithFullName(
                  height: 60.r,
                  width: 60.r,
                  borderColor: UIColors.white,
                  backgroundColor: UIColors.celeste,
                  nameWithLetter: name,
                )
              : CircleAvatar(
                  backgroundImage:
                      MemoryImage(base64Decode(profileState.data!.avatar!)),
                  backgroundColor: UIColors.pineGreen,
                  radius: 30,
                ),
        const SizedBox(height: 10),
        Text(
          ssoNotifier
              ? user!.displayName ?? 'User Name'
              : offlineState
                  ? mockUser.fullName
                  : profileState.data!.fullName,
          style: AppTypography.semiBold16Caros(color: UIColors.white),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Text(
          ssoNotifier
              ? user!.email
              : offlineState
                  ? mockUser.email
                  : profileState.data?.email ?? 'userEmail',
          style: AppTypography.regular14Caros(color: UIColors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
