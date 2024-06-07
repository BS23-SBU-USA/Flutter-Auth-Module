part of '../pages/update_profile_page.dart';

class UpdateProfileFormBuilder extends StatelessWidget {
  const UpdateProfileFormBuilder({
    required this.firstNameController,
    required this.lastNameController,
    required this.countryCodeController,
    required this.onlyPhoneController,
    required this.genderController,
    required this.dateOfBirthController,
    super.key,
  });

  final TextEditingController firstNameController;

  final TextEditingController lastNameController;

  final TextEditingController countryCodeController;

  final TextEditingController onlyPhoneController;

  final TextEditingController genderController;
  final TextEditingController dateOfBirthController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextConstants.firstName,
            style: text.labelLarge!.copyWith(
              color: color.primary,
            ),
          ),
          TextFormField(
            controller: firstNameController,
            keyboardType: TextInputType.name,
            validator: InputValidators.name,
            decoration: const InputDecoration(
              hintText: TextConstants.firstNameHint,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            TextConstants.lastName,
            style: text.labelLarge!.copyWith(
              color: color.primary,
            ),
          ),
          TextFormField(
            controller: lastNameController,
            keyboardType: TextInputType.name,
            validator: InputValidators.name,
            decoration: const InputDecoration(
              hintText: TextConstants.lastNameHint,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            TextConstants.phoneNumber,
            style: text.labelLarge!.copyWith(
              color: color.primary,
            ),
          ),
          TextFormField(
            controller: onlyPhoneController,
            keyboardType: TextInputType.phone,
            validator: InputValidators.phone,
            decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CountryCodePicker(
                    initialSelection: onlyPhoneController.text.split(" ")[0],
                    padding: EdgeInsets.zero, // Set zero padding to the left
                    countryFilter: const ['+880', 'US'],
                    textStyle: text.labelMedium?.copyWith(
                      fontSize: 16,
                    ),
                    barrierColor: color.surface.withOpacity(0.75),
                    dialogBackgroundColor: color.surface.withAlpha(10),
                    onChanged: (country) {
                      countryCodeController.text = country.dialCode!;
                    },
                  ),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.only(right: 5),
                    child: VerticalDivider(
                      color: color.outline,
                      width: 1,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              hintText: TextConstants.phoneNumberHint,
            ),
          ),
          // CustomInputField(
          //   textEditingController: notifier.onlyPhoneController,
          //   labelText: TextConstants.phoneNumber,
          //   maxLength: 10,
          //   bottomMargin: 10,
          //   prefix: IntrinsicHeight(
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         CountryCodePicker(
          //           initialSelection: notifier.countryCodeController.text,
          //           padding: EdgeInsets.zero, // Set zero padding to the left
          //           countryFilter: const ['+880', 'US'],
          //           textStyle: text.labelMedium?.copyWith(
          //             fontSize: 16,
          //           ),
      
          //           barrierColor: color.background.withOpacity(0.75),
          //           dialogBackgroundColor: color.surface.withAlpha(10),
          //           onChanged: (country) {
          //             notifier.countryCodeController.text = country.dialCode!;
          //           },
          //         ),
          //         Container(
          //           padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          //           child: VerticalDivider(
          //             color: color.outline,
          //             width: 1,
          //             thickness: 1,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   validator: InputValidators.phone,
          //   onChanged: (value) {
          //     ref
          //         .watch(updateProfileValidationProvider.notifier)
          //         .isAbleToUpdate(value);
          //   },
          // ),
          GenderDropdownFormField(
            controller: genderController,
          ),
          BirthdayFormFieldBuilder(
            controller: dateOfBirthController,
          ),
        ],
      ),
    );
  }
}
