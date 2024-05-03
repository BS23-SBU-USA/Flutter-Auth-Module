part of '../pages/update_profile_page.dart';

class UpdateProfileFormBuilder extends ConsumerStatefulWidget {
  const UpdateProfileFormBuilder({super.key});

  @override
  ConsumerState<UpdateProfileFormBuilder> createState() {
    return _UpdateProfileFormBuilderState();
  }
}

class _UpdateProfileFormBuilderState
    extends ConsumerState<UpdateProfileFormBuilder> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(updateProfileInfoProvider.notifier);
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final text = theme.textTheme;
    return SingleChildScrollView(
      child: Form(
        key: notifier.formKey,
        child: Column(
          children: [
            CustomInputField(
              onChanged: (value) {
                _capitalizeFirstLetter(notifier.firstNameController);
              },
              textEditingController: notifier.firstNameController,
              labelText: TextConstants.firstName,
              bottomMargin: 10,
            ),
            CustomInputField(
              onChanged: (value) {
                _capitalizeFirstLetter(notifier.lastNameController);
              },
              textEditingController: notifier.lastNameController,
              labelText: TextConstants.lastName,
              keyboardType: TextInputType.name,
              bottomMargin: 10,
            ),
            CustomInputField(
              textEditingController: notifier.onlyPhoneController,
              labelText: TextConstants.phoneNumber,
              maxLength: 10,
              bottomMargin: 10,
              prefix: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CountryCodePicker(
                      initialSelection: notifier.countryCodeController.text,
                      padding: EdgeInsets.zero, // Set zero padding to the left
                      countryFilter: const ['+880', 'US'],
                      textStyle: text.labelMedium?.copyWith(
                        fontSize: 16,
                      ),
                      onChanged: (country) {
                        notifier.countryCodeController.text = country.dialCode!;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: VerticalDivider(
                        color: color.outline,
                        width: 1,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              validator: InputValidators.phone,
              onChanged: (value) {
                ref
                    .watch(updateProfileValidationProvider.notifier)
                    .isAbleToUpdate(value);
              },
            ),
            const GenderDropdownFormField(),
            const BirthdayFormFieldBuilder(),
          ],
        ),
      ),
    );
  }

  void _capitalizeFirstLetter(TextEditingController controller) {
    final text = controller.text;
    final newText = text.replaceAllMapped(
      RegExp(r'\b\w'),
      (match) => match.group(0)!.toUpperCase(),
    );

    if (newText != text) {
      final newSelectionOffset = newText.length;
      controller.value = controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newSelectionOffset),
      );
    }
  }
}
