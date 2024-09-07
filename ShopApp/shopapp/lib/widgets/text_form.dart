import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String label;
  final String? Function(String?) valid;
    final void Function(String?) save;

  const TextForm({super.key,required this.label,required this.valid,required this.save});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
              decoration:  InputDecoration(
                labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color:Theme.of(context).colorScheme.primaryContainer),
                labelText:label,
              ),
              validator: valid,
              onSaved: save,
            );
  }
}
