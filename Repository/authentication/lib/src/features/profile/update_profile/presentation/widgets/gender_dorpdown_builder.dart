import 'package:auth_module/src/core/utils/text_constants.dart';
import 'package:auth_module/src/core/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';

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
                    icon: Assets.images.maleIcon.path,
                    label: TextConstants.male,
                  ),
                  ModalCard(
                    onTap: () {
                      controller.text = TextConstants.female;
                      context.pop();
                    },
                    icon: Assets.images.femaleIcon.path,
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
