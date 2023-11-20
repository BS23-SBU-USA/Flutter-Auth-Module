// ignore_for_file: must_be_immutable, avoid_dynamic_calls

part of '../widget/drawer_builder.dart';

class DrawerHeaderWidget extends ConsumerWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(userProfileInfoProvider);
    final updateState = ref.watch(updateProfileInfoProvider);
    bool offlineState = ref.read(offlineStateProvider);

    final name =
        NameInitials.getInitialsFromFullName(profileState.data?.fullName ?? '');

    if (offlineState) {
      return _buildOfflineHeader(ref, context);
    } else if (profileState.status.isLoading || updateState.status.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: context.theme.color.white,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (profileState.data!.avatar != null)
            CircleAvatar(
              backgroundImage:
                  MemoryImage(base64Decode(profileState.data!.avatar!)),
              backgroundColor: context.theme.color.pineGreen,
              radius: 30,
            ),
          if (profileState.data!.avatar == null)
            Avatar.circleWithFullName(
              height: 60.r,
              width: 60.r,
              borderColor: context.theme.color.white,
              backgroundColor: context.theme.color.celeste,
              nameWithLetter: name,
            ),
          const SizedBox(height: 10),
          Text(
            profileState.data!.fullName,
            style: context.theme.text.semiBold16Caros
                .copyWith(color: context.theme.color.white),
          ),
          const SizedBox(height: 5),
          Text(
            profileState.data?.email != null
                ? profileState.data!.email!
                : 'userEmail',
            style: context.theme.text.regular14Caros
                .copyWith(color: context.theme.color.white),
          ),
        ],
      );
    }
  }

  Widget _buildOfflineHeader(WidgetRef ref, BuildContext context) {
    final mockUser = ref.read(mockUserProvider);
    final name = NameInitials.getInitialsFromFullName(mockUser.fullName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar.circleWithFullName(
          height: 60.r,
          width: 60.r,
          borderColor: context.theme.color.white,
          backgroundColor: context.theme.color.celeste,
          nameWithLetter: name,
        ),
        const SizedBox(height: 10),
        Text(
          '${mockUser.firstName} ${mockUser.lastName}',
          style: context.theme.text.semiBold16Caros
              .copyWith(color: context.theme.color.white),
        ),
        const SizedBox(height: 5),
        Text(
          mockUser.email,
          style: context.theme.text.regular14Caros
              .copyWith(color: context.theme.color.white),
        ),
      ],
    );
  }
}
