import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';

import '../../models/task.dart';

Widget buildTextField({
  required TextEditingController controller,
  required TextInputType typeKeyboard,
  bool obsecure = false,
  void Function()? onTap,
  required String label,
  required IconData prefix,
  IconData? suffix,
}) {
  return TextField(
    controller: controller,
    keyboardType: typeKeyboard,
    obscureText: obsecure,
    decoration: InputDecoration(
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: onTap,
            )
          : null,
      label: Text(label),
      border: const OutlineInputBorder(),
    ),
  );
}

Widget buildTextFormField({
  required TextEditingController controller,
  required String? Function(String?) validator,
  required TextInputType typeKeyboard,
  bool obsecure = false,
  void Function()? onTap,
  required String label,
  required IconData prefix,
  IconData? suffix,
  void Function()? touch,
}) {
  return TextFormField(
    readOnly: touch == null ? false : true,
    onTap: touch,
    validator: validator,
    controller: controller,
    keyboardType: typeKeyboard,
    obscureText: obsecure,
    decoration: InputDecoration(
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: onTap,
            )
          : null,
      label: Text(label),
      border: const OutlineInputBorder(),
    ),
  );
}

Widget buildTask(Task task, BuildContext cntx) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Dismissible(
      key: ValueKey(task),
      onDismissed: (direction) {
        AppCubit.get(cntx).deleteFromDB(task.id!);
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            child: Text(
              task.time,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  task.date,
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(cntx).updateDB(task.id!, 'done');
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(cntx).updateDB(task.id!, 'archive');
              },
              icon: Icon(Icons.archive, color: Colors.black45)),
        ],
      ),
    ),
  );
}
