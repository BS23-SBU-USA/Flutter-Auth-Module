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
    return Row(
      children: [
        Expanded(
          child: InputFormField(
            onChanged: (value) {
              _picKCalender(context);
            },
            readOnly: true,
            textEditingController: notifier.dateOfBirthController,
            labelText: TextConstants.dateOfBirth,
            style: AppTypography.regular16Caros(),
            labelTextStyle: AppTypography.medium14Circular(
              color: UIColors.pineGreen,
            ),
            borderColor: UIColors.timberWolf,
            autocorrect: false,
            suffix: GestureDetector(
              onTap: () {
                _picKCalender(context);
              },
              child: Image.asset(
                Assets.calenderIcon,
                height: 8.sp,
                width: 20.sp,
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: UIColors.pineGreen,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        notifier.dateOfBirthController.text = formattedDate;
      });
    }
  }
}
