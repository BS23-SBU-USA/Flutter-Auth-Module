// ignore_for_file: must_be_immutable, avoid_dynamic_calls

part of '../widget/drawer_builder.dart';

class DrawerHeaderWidget extends ConsumerWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch (userProfileInfoProvider);
    final updateState = ref.watch(updateProfileInfoProvider);
    final offlineState = ref.read(offlineStateProvider.notifier).state;
    final ssoNotifier = ref.read(ssoSignInProvider.notifier).state;
    final user = ref.read(ssoUserProvider.notifier).state;
    final mockUser = ref.read(mockUserProvider);

    final name = NameInitials.getInitialsFromFullName(
        offlineState ? mockUser.fullName : profileState.data?.fullName ?? '');

    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;

    if ((profileState.status.isLoading || updateState.status.isLoading) &&
        (!ssoNotifier && !offlineState)) {
      return Center(
        child: CircularProgressIndicator(
          color: color.onPrimary,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ssoNotifier)
          CircleAvatar(
            backgroundImage: NetworkImage(user!.photoUrl ?? ''),
            backgroundColor: color.primary,
            radius: 30,
          )
        else if (profileState.status.isFailure)
          const SizedBox()
        else
          (offlineState || profileState.data!.avatar == null)
              ? Avatar.circleWithFullName(
                  height: 60.r,
                  width: 60.r,
                  borderColor: color.outline,
                  backgroundColor: color.primaryContainer,
                  nameWithLetter: name,
                )
              : CircleAvatar(
                  backgroundImage:
                      MemoryImage(base64Decode(profileState.data!.avatar!)),
                  backgroundColor: color.primaryContainer,
                  radius: 30,
                ),
        const SizedBox(height: 10),
        Text(
          ssoNotifier
              ? user!.displayName ?? 'User Name'
              : offlineState
                  ? mockUser.fullName
                  : profileState.status.isSuccess
                      ? profileState.data!.fullName
                      : TextConstants.userNotFound,
          style: text.titleMedium!.copyWith(color: color.onPrimary),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Text(
          ssoNotifier
              ? user!.email
              : offlineState
                  ? mockUser.email
                  : profileState.status.isSuccess
                      ? profileState.data?.email ?? 'userEmail'
                      : "",
          style: text.titleSmall!.copyWith(color: color.onPrimary),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
