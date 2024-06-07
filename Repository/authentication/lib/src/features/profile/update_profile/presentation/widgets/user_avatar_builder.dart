part of '../pages/update_profile_page.dart';

class UserAvatarBuilder extends ConsumerStatefulWidget {
  const UserAvatarBuilder({
    required this.avatarController,
    super.key,
  });
  final TextEditingController avatarController;
  @override
  ConsumerState<UserAvatarBuilder> createState() => _UserAvatarBuilderState();
}

class _UserAvatarBuilderState extends ConsumerState<UserAvatarBuilder> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(updateProfileInfoProvider.notifier);

    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;

    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: notifier.avatarController.text.isNotEmpty
              ? MemoryImage(
                  base64Decode(
                    notifier.avatarController.text,
                  ),
                )
              : null,
          backgroundColor: notifier.avatarController.text.isEmpty
              ? color.primaryContainer
              : color.primary,
          radius: 41,
          child: notifier.avatarController.text.isEmpty
              ? Icon(
                  Icons.photo,
                  size: 30,
                  color: color.surface,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                ),
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 300.h,
                    child: Padding(
                      padding: EdgeInsets.all(24.sp),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -10.h,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'Profile Photo',
                                style: text.titleMedium,
                              ),
                              SizedBox(height: 20.h),
                              _buildCameraButton(),
                              SizedBox(height: 40.h),
                              _buildMediaButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: color.primary,
              radius: 12,
              child: Icon(
                Icons.add_a_photo,
                size: 12,
                color: color.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaButton() {
    final notifier = ref.read(updateProfileInfoProvider.notifier);
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pop();

        final imageCapture = ImageCapture();
        await imageCapture.getImageFromGallery();

        final avatar = imageCapture.convertedBase64String;

        if (imageCapture.largeImage) {
          showAlertDialogForLargeImage(
            imageCapture.errorTittle!,
            imageCapture.errorMessage!,
            context,
          );
        } else if (avatar.isEmpty) {
          showAlertDialogForPermission(
            imageCapture.errorTittle!,
            imageCapture.errorMessage!,
            context,
          );
        } else {
          setState(() {
            notifier.avatarController.text = avatar;
          });
        }
      },
      child: Row(
        children: [
          Container(
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
              color: color.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.mediaIcon,
                colorFilter: ColorFilter.mode(
                  color.onPrimaryContainer,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Choose from Gallery',
            style: text.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraButton() {
    final notifier = ref.read(updateProfileInfoProvider.notifier);

    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pop();
        final imageCapture = ImageCapture();
        await imageCapture.getImageFromCamera();
        final avatar = imageCapture.convertedBase64String;
        if (avatar.isEmpty) {
          showAlertDialogForPermission(
            imageCapture.errorTittle!,
            imageCapture.errorMessage!,
            context,
          );
        } else if (imageCapture.largeImage) {
          showAlertDialogForLargeImage(
            imageCapture.errorTittle!,
            imageCapture.errorMessage!,
            context,
          );
        } else {
          setState(() {
            notifier.avatarController.text = avatar;
          });
        }
      },
      child: Row(
        children: [
          Container(
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
              color: color.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.cameraIcon,
                colorFilter: ColorFilter.mode(
                  color.onPrimaryContainer,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Take a Photo',
            style: text.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialogForPermission(
    String tittle,
    String message,
    BuildContext context,
  ) {
    // Create button
    final Widget okButton = ElevatedButton(
      child: const Text('SETTINGS'),
      onPressed: () {
        openAppSettings();
        Navigator.pop(context);
      },
    );

    final Widget cancelButton = ElevatedButton(
      child: const Text('CANCEL'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // Create AlertDialog
    final alert = AlertDialog(
      icon: const Icon(
        Icons.info,
        color: Colors.red,
        size: 48,
      ),
      title: Text(tittle),
      content: Text(message),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAlertDialogForLargeImage(
    String tittle,
    String message,
    BuildContext context,
  ) {
    // Create button
    final Widget okButton = ElevatedButton(
      child: const Text('OK'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // Create AlertDialog
    final alert = AlertDialog(
      icon: const Icon(
        Icons.cancel,
        color: Colors.red,
        size: 48,
      ),
      title: Text(tittle),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
