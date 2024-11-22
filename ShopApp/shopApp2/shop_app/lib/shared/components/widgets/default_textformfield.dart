import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData preIcon;
  final IconData? sufIcon;
  final TextInputType type;
  final String? Function(String?) validator;
  final bool? isPassword;
  final void Function()? sufPress;

  const DefaultTextFormField({
    super.key,
    required this.type,
    required this.controller,
    required this.label,
    required this.preIcon,
    this.sufIcon,
    required this.validator,
    bool? isPassword,
    this.sufPress,
  }) : isPassword = isPassword ?? false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.labelLarge,
          prefixIcon: Icon(preIcon),
          suffixIcon: sufIcon == null
              ? null
              : IconButton(onPressed: sufPress, icon: Icon(sufIcon))),
      obscureText: isPassword!,
    );
  }
}
