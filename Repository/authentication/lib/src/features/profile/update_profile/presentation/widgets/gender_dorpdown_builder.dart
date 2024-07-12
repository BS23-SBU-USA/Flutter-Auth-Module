import 'package:auth_module/src/core/utils/assets.dart';
import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/theme/theme.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/widgets/cutom_input_field.dart';
import 'package:auth_module/src/core/widgets/modal_bottom_sheet.dart';
import 'package:auth_module/src/core/widgets/primary_input_form_field.dart';
import 'package:auth_module/src/features/profile/update_profile/presentation/riverpod/update_profile_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GenderDropdownFormField extends StatelessWidget {
  const GenderDropdownFormField({
    super.key,
    this.hintText,
    this.onIconTap,
    this.onChanged,
    required this.controller,
  });

  final String? hintText;
  final void Function()? onIconTap;
  final void Function(String?)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: TextConstants.gender,
              suffix: ModalBottomSheet(
                title: TextConstants.selectGender,
                children: [
                  ModalCard(
                    onTap: () {
                      controller.text = TextConstants.male;
                      context.pop();
                    },
                    icon: Assets.male,
                    label: TextConstants.male,
                  ),
                  ModalCard(
                    onTap: () {
                      controller.text = TextConstants.female;
                      context.pop();
                    },
                    icon: Assets.female,
                    label: TextConstants.female,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
