import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/task.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        AppCubit cubit = AppCubit.get(context);
        List<Task> newTasks = cubit.tasks.where(
          (element) {
            return element.status == 'archive';
          },
        ).toList();
        if (newTasks.isEmpty) {
          return Center(child: Text('Add new Tasks'));
        }
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildTask(newTasks[index], context);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newTasks.length);
      },
      listener: (context, state) {},
    );
  }
}
