import 'package:auth_module/src/core/theme/context_extension.dart';
import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/widgets/modal_bottom_sheet.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderDropdownFormField extends ConsumerStatefulWidget {
  const GenderDropdownFormField({
    super.key,
    this.hintText,
    this.onIconTap,
    this.onChanged,
  });

  final String? hintText;
  final void Function()? onIconTap;
  final void Function(String?)? onChanged;

  @override
  ConsumerState<GenderDropdownFormField> createState() =>
      _CustomDropdownInputFormFieldState();
}

class _CustomDropdownInputFormFieldState
    extends ConsumerState<GenderDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(updateProfileInfoProvider.notifier);

    return Row(
      children: [
        Expanded(
          child: InputFormField(
            textEditingController: notifier.genderController,
            readOnly: true,
            label: Text(
              TextConstants.gender,
              style: context.theme.text.medium14Circular
                  .copyWith(color: context.theme.color.pineGreen),
            ),
            style: context.theme.text.regular16Caros,
            borderColor: context.theme.color.timberWolf,
            suffix: ModalBottomSheet(
              title: TextConstants.selectGender,
              children: [
                ModalCard(
                  onTap: () {
                    notifier.genderController.text = TextConstants.male;
                    Navigator.of(context).pop();
                  },
                  icon: Assets.male,
                  label: TextConstants.male,
                ),
                ModalCard(
                  onTap: () {
                    notifier.genderController.text = TextConstants.female;
                    Navigator.of(context).pop();
                  },
                  icon: Assets.female,
                  label: TextConstants.female,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
