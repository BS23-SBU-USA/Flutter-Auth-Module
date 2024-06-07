part of '../pages/update_profile_page.dart';

class BirthdayFormFieldBuilder extends StatelessWidget {
  final TextEditingController controller;

  const BirthdayFormFieldBuilder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onTap: () {
              _picKCalender(context);
            },
            readOnly: true,
            controller: controller,
            decoration: InputDecoration(
              labelText: TextConstants.dateOfBirth,
              suffixIcon: GestureDetector(
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
        ),
      ],
    );
  }

  Future<void> _picKCalender(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      controller.text = formattedDate;
    }
  }
}
