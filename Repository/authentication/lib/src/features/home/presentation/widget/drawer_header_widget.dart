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
      return _buildOfflineHeader(ref);
    } else if (profileState.status.isLoading || updateState.status.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: UIColors.primary,
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
              backgroundColor: UIColors.secondary,
              radius: 30,
            ),
          if (profileState.data!.avatar == null)
            Avatar.circleWithFullName(
              height: 60.r,
              width: 60.r,
              borderColor: UIColors.primary,
              backgroundColor: UIColors.lightTealShade,
              nameWithLetter: name,
            ),
          const SizedBox(height: 10),
          Text(
            profileState.data!.fullName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            profileState.data?.email != null
                ? profileState.data!.email!
                : 'userEmail',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildOfflineHeader(WidgetRef ref) {
    final mockUser = ref.read(mockUserProvider);
    final name = NameInitials.getInitialsFromFullName(mockUser.fullName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar.circleWithFullName(
          height: 60.r,
          width: 60.r,
          borderColor: UIColors.primary,
          backgroundColor: UIColors.lightTealShade,
          nameWithLetter: name,
        ),
        const SizedBox(height: 10),
        Text(
          '${mockUser.firstName} ${mockUser.lastName}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          mockUser.email,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
