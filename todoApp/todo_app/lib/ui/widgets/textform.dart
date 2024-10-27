import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/size_config.dart';

import '../theme.dart';

class TxtForm extends StatelessWidget {
  final String label;
  final String hint;
  final Widget? leading;
  final String? Function(String?) validator;
  final void Function(String?)? onSave;
  const TxtForm({
    super.key,
    required this.label,
    required this.hint,
    this.leading,
    required this.validator,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Themes().titleStyle),
        Container(
          width: SizeConfig.screenWidth,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(13)),
          child: TextFormField(
            style: Themes().subTitleStyle,
            readOnly: leading == null ? false : true,
            validator: validator,
            onSaved: onSave,
            cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: context.theme.primaryColor,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: context.theme.primaryColor, width: 0),
              ),
              suffixIcon: leading,
              hintText: hint,
              hintStyle: Themes().subTitleStyle,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
