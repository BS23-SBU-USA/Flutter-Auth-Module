part of '../pages/update_profile_page.dart';

class BirthdayFormFieldBuilder extends ConsumerStatefulWidget {
  const BirthdayFormFieldBuilder({super.key});

  @override
  ConsumerState<BirthdayFormFieldBuilder> createState() =>
      _BirthdayFormFieldBuilderState();
}

class _BirthdayFormFieldBuilderState
    extends ConsumerState<BirthdayFormFieldBuilder> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(updateProfileInfoProvider.notifier);
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    return Row(
      children: [
        Expanded(
          child: CustomInputField(
            onChanged: (value) {
              _picKCalender(context);
            },
            readOnly: true,
            textEditingController: notifier.dateOfBirthController,
            labelText: TextConstants.dateOfBirth,
            suffix: GestureDetector(
              onTap: () {
                _picKCalender(context);
              },
              child: Image.asset(
                Assets.calenderIcon,
                color: color.primary,
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _picKCalender(BuildContext context) async {
    final notifier = ref.read(updateProfileInfoProvider.notifier);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        notifier.dateOfBirthController.text = formattedDate;
      });
    }
  }
}
